import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:final_project/features/auth/data/auth_repository.dart';
import 'package:final_project/features/auth/domain/app_user.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

part 'auth_provider.g.dart';

// -----------------------------------------------------------------------------
// YAYIN 1: KİMLİK BİLGİSİ YAYINI (Firebase Auth)
// Sadece kullanıcının sisteme giriş yapıp yapmadığını ve UID'sini takip eder.
// go_router'daki bekçi (guard) burayı dinliyor.
// -----------------------------------------------------------------------------
@riverpod
Stream<User?> authState(AuthStateRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
}


// -----------------------------------------------------------------------------
// YAYIN 2: PROFİL BİLGİSİ YAYINI (Firestore Veritabanı)
// İlk yayındaki UID'yi alır, veritabanına gider, kişinin ismini ve rolünü bulup
// bizim uygulamadaki AppUser modelimize çevirip ekranlara (Dashboard'a) dağıtır.
// -----------------------------------------------------------------------------
@riverpod
Stream<AppUser?> currentUser(CurrentUserRef ref) async* {
  
  // 1. Önce kimlik yayınına kulak verip giriş yapılıp yapılmadığına bakıyoruz
  final authState = ref.watch(authStateProvider);
  final firebaseUser = authState.value;

  // Giriş yapmamışsa veritabanına hiç gitmeden null fırlat (Kapat)
  if (firebaseUser == null) {
    yield null; 
    return;
  }

  // 2. Giriş yapmışsa, Firestore'daki "users" tablosuna gidip kendi UID'sini soruyoruz
  final docStream = FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).snapshots();
  
  // 3. Veritabanındaki değişiklikleri (İsim değişimi vs.) anında yakalayan nehir (yield)
  await for (final snapshot in docStream) {
    if (snapshot.exists && snapshot.data() != null) {
       
       final data = Map<String, dynamic>.from(snapshot.data()!);
       data['id'] = snapshot.id; 
       
       print("🚀 FIRESTORE'DAN GELEN VERİ: $data"); // DEBUG İÇİN
       
       // --- YENİ EKLENEN KOD: OTURUM (SESSION) GÜVENLİK DUVARI ---
       final prefs = await SharedPreferences.getInstance();
       final localSessionId = prefs.getString('sessionId');
       
       // Giriş işlemi yapılıyorsa (yarış durumu) atma işlemini atla
       if (localSessionId == 'IGNORE_KICKOUT') {
         print("⏳ GİRİŞ İŞLEMİ SÜRÜYOR, KICK-OUT KORUMASI DEVRE DIŞI...");
       }
       // Eğer veritabanındaki şifre bizim telefondakiyle uyuşmuyorsa BAŞKASI GİRMİŞ DEMEKTİR!
       // (localSessionId null olsa bile, veritabanında yeni bir session varsa eski cihazı atar)
       else if (data['sessionId'] != null && data['sessionId'] != localSessionId) {
         print("🚨 BAŞKA BİR CİHAZDAN GİRİŞ TESPİT EDİLDİ! ESKİ CİHAZ ATILIYOR...");
         await FirebaseAuth.instance.signOut();
         yield null;
         continue; // Aşağıdaki kodları okuma, işlemi kes!
       }

       try {
         final userObj = AppUser.fromJson(data);
         print("✅ APPUSER DÖNÜŞÜMÜ BAŞARILI: ${userObj.name}");
         
         // OneSignal Etiketleme
         OneSignal.login(userObj.id);
         OneSignal.User.addTagWithKey("apartmentId", userObj.apartmentId);
         OneSignal.User.addTagWithKey("role", userObj.role.name);

         yield userObj;
       } catch (e, stacktrace) {
         print("❌ DÖNÜŞÜM HATASI: $e");
         print("❌ HATA DETAYI: $stacktrace");
         yield null;
       }
       
      } else {
       print("⚠️ FIRESTORE BELGESİ BULUNAMADI (UID: ${firebaseUser.uid})");
       // --- YENİ EKLENEN KOD: KULLANICIYI ZORLA ÇIKIŞ YAPTIR (KICK-OUT) ---
       await FirebaseAuth.instance.signOut();
       // ------------------------------------------------------------------
       yield null; 
    }
    }
  }


// -----------------------------------------------------------------------------
// YAYIN 3: SEÇİLİ APARTMAN HAFIZASI
// Yöneticinin o an görüntülediği apartmanı tutar.
// Uygulama ilk açıldığında yöneticinin KENDİ apartmanı seçili gelir.
// -----------------------------------------------------------------------------
@riverpod
class SelectedApartment extends _$SelectedApartment {
  @override
  String? build() {
    // Sadece başlangıçta null döner. activeApartmentProvider bunu yakalayıp
    // otomatik olarak kullanıcının kendi apartmanına veya listedeki ilk apartmana düşürür.
    // ref.watch(currentUserProvider) kullanmıyoruz çünkü kullanıcı verisi (Stream)
    // her güncellendiğinde bu sınıfın sıfırlanıp adminin seçtiği apartmanı unutmasına sebep oluyordu!
    return null; 
  }
  
  // Yönetici başka apartmana geçmek istediğinde bu fonksiyon çalışır
  void setApartment(String apartmentId) {
    state = apartmentId;
  }
}
@riverpod
Future<List<String>> uniqueApartments(UniqueApartmentsRef ref) {
  return ref.watch(authRepositoryProvider).getAllUniqueApartments();
}

@riverpod
String activeApartment(ActiveApartmentRef ref) {
  final user = ref.watch(currentUserProvider).value;
  if (user == null) return '';
  
  final isAdmin = user.role == UserRole.admin ;
  
  if (isAdmin) {
     final selected = ref.watch(selectedApartmentProvider);
     return selected ?? user.apartmentId!;
  }
  
  return user.apartmentId!;
}