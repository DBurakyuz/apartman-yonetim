import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/features/auth/domain/app_user.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  // Sınıfın içine Firebase kimlik doğrulama objesini (instance) alıyoruz
  final FirebaseAuth _auth;

  AuthRepository(this._auth);

  // 1. KULLANICI DURUMUNU DİNLEME (Stream)
  // Kullanıcı giriş yaptı mı, çıkış mı yaptı sürekli takip eder (Radyo yayını gibi)
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  // 2. GİRİŞ YAPMA METODU
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // 3. ÇIKIŞ YAPMA METODU
  Future<void> signOut() {
    return _auth.signOut();
  }

  // 4. TÜM KULLANICILARI GETİR (Yönetici dahil)
  Future<List<AppUser>> getAllResidents(String apartmentId) async {
    // Veritabanında (Firestore) 'users' isimli klasöre git

    
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('apartmentId', isEqualTo:apartmentId)
        .get();
        
    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id; 
      return AppUser.fromJson(data);
    }).toList();
  }

    Future<List<String>> getAllUniqueApartments() async {
    final snapshot = await FirebaseFirestore.instance.collection('users').get();
    
    final Set<String> apartments = {};
    for (var doc in snapshot.docs) {
      final data = doc.data();
      if (data['apartmentId'] != null && data['apartmentId'].toString().isNotEmpty) {
       apartments.add(data['apartmentId'].toString());
      }
    }
    
    return apartments.toList();
  }
    //  YENİ KULLANICI KAYDI (Register)
  Future<UserCredential> registerResident({
    required String email,
    required String password,
    required String name,
    required String flatNumber,
     required String apartmentId,
  }) async {
    // Firebase'de şifreli hesabı oluşturur (Firebase Auth)
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final String newUid = credential.user!.uid;

    //  kişinin adını ve kapı numarasını kendi Firestore (users) tablomuza kaydeder
    final newUser = AppUser(
      id: newUid,
      email: email,
      name: name,
      flatNumber: flatNumber,
      apartmentId: apartmentId,
      role: UserRole.resident, // default resident atar
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(newUid)
        .set(newUser.toJson());

    return credential;
  }

  // --- KULLANICI YETKİSİNİ GÜNCELLEME ---
  Future<void> updateUserRole(String userId, UserRole newRole) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'role': newRole.name});
  }
}

  
// Tüm uygulamanın bu depoya kolayca ulaşabilmesi için bir Provider oluşturuyoruz
@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(FirebaseAuth.instance);
}


