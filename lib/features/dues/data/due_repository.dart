import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/features/dues/due.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:final_project/features/auth/domain/app_user.dart';

part 'due_repository.g.dart';

class DueRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 1. KULLANICIYA AİT AİDATLARI GETİR (Filtreli Stream)
  Stream<List<Due>> getUserDues(String residentId) {
    return _firestore
        .collection('dues')
        // SADECE BENİM BORCUMU GETİR (Filtreleme)
        .where('residentId', isEqualTo: residentId) 
        .snapshots()
        .map((snapshot) {
          
      // Verileri kalıba döküyoruz
      final list = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        
        if (data['createdAt'] is Timestamp) {
           data['createdAt'] = (data['createdAt'] as Timestamp).toDate().toIso8601String();
        }
        return Due.fromJson(data);
      }).toList();
      
      // Index hatası yememek için sıralamayı telefonda (Dart ile) kendimiz yapıyoruz (En yeni en üstte)
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return list;
    });
  }

  // 2. YENİ AİDAT OLUŞTUR (Sadece Admin kullanacak)
  Future<void> addDue(Due due) async {
    final data = due.toJson();
    data.remove('id');
    data['createdAt'] = FieldValue.serverTimestamp();

    await _firestore.collection('dues').add(data);
  }

  // 3. YENİ YETENEK: AİDATI "ÖDENDİ" OLARAK GÜNCELLE
  Future<void> markAsPaid(String dueId) async {
    // Sadece "isPaid" alanını true yap, geri kalan bilgilere dokunma!
    await _firestore.collection('dues').doc(dueId).update({
      'isPaid': true,
    });
  }
  
  // 4. TOPLU BORÇLANDIRMA MAKİNESİ (Batch Write)
  Future<void> assignDueToAll(String title, double amount, List<AppUser> residents) async {
    // (Batch) hazırlıyoruz
    final batch = _firestore.batch();
    
    // "Sakinler Listesindeki" herkes için sırayla dönüyoruz
    for (var resident in residents) {
      
      // Herkese özel rastgele boş bir fatura belgesi açıyoruz
      final docRef = _firestore.collection('dues').doc(); 
      
      // Fatura bilgilerini (Due) dolduruyoruz
      final due = Due(
        id: '', 
        residentId: resident.id, // Faturayı sıradaki sakine (resident) kesiyoruz!
        amount: amount,
        apartmentId: resident.apartmentId ?? 'Bilinmiyor',
        title: title,
        isPaid: false,
        createdAt: DateTime.now(),
      );
      
      // Veriyi Firebase'in anlayacağı JSON diline çeviriyoruz
      final data = due.toJson();
      data.remove('id'); 
      data['createdAt'] = FieldValue.serverTimestamp(); // Firebase'in saatini basıyoruz
      
      // Faturayı (batch) yüklüyoruz (Henüz yola çıkmadı!)
      batch.set(docRef, data);
    }
    
    // veritabanına gönderiyoruz
    await batch.commit(); 
  }

  // 5. SADECE BİZİM APARTMANIN AİDATLARINI GETİR (Filtreli Stream)
  Stream<List<Due>> getAllDues(String apartmentId) {
    return _firestore
        .collection('dues')
        .where('apartmentId', isEqualTo: apartmentId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        if (data['createdAt'] is Timestamp) {
           data['createdAt'] = (data['createdAt'] as Timestamp).toDate().toIso8601String();
        }
        return Due.fromJson(data);
      }).toList();
    });
  }
}



// --- SAĞLAYICILAR ---

@riverpod
DueRepository dueRepository(DueRepositoryRef ref) {
  return DueRepository();
}

// DİKKAT: Artık bu yayını dinlerken parametre (argüman) olarak UID yollamak zorundayız!
@riverpod
Stream<List<Due>> userDuesStream(UserDuesStreamRef ref, String residentId) {
  return ref.watch(dueRepositoryProvider).getUserDues(residentId);
}

// Tüm aidatların (Kasanın) durumunu dinleyen yayın (Şifreli)
@riverpod
Stream<List<Due>> allDuesStream(AllDuesStreamRef ref, String apartmentId) {
  return ref.watch(dueRepositoryProvider).getAllDues(apartmentId);
}