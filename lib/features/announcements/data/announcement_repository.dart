import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:final_project/features/announcements/domain/announcement.dart';

part 'announcement_repository.g.dart';

class AnnouncementRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 1. DUYURULARI GETİR (CANLI YAYIN - STREAM)
  Stream<List<Announcement>> getAnnouncements(String apartmentId) {
    return _firestore
        .collection('announcements')
        .where('apartmentId', isEqualTo: apartmentId) // Filtre eklendi, orderBy kaldırıldı (index hatası için)
        .snapshots()
        .map((snapshot) {
      
      final list = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; 
        
        // Firestore tarihi Timestamp olarak tutar, Dart ise String(ISO) bekler. Dönüştürüyoruz:
        if (data['createdAt'] is Timestamp) {
           data['createdAt'] = (data['createdAt'] as Timestamp).toDate().toIso8601String();
        }
        
        return Announcement.fromJson(data);
      }).toList();
      
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return list;
    });
  }

  Future<void> addAnnouncement(Announcement announcement) async {
    
    final data = announcement.toJson();
    data.remove('id'); // ID'yi biz değil Firebase kendisi otomatik verecek
    
    // String tarihi, Firestore'un anlayacağı asıl formata çeviriyoruz
    data['createdAt'] = FieldValue.serverTimestamp();

    await _firestore.collection('announcements').add(data);
  }
}

// --- SAĞLAYICILAR (PROVIDERS) ---

// 1. Sadece postacının kendisini tutan sağlayıcı
@riverpod
AnnouncementRepository announcementRepository(AnnouncementRepositoryRef ref) {
  return AnnouncementRepository();
}

// 2. Arayüzde (Dashboard) doğrudan listeyi dinlemek için kolaylaştırıcı yayın (Stream)
@riverpod
Stream<List<Announcement>> announcementsStream(AnnouncementsStreamRef ref, String apartmentId) {
  return ref.watch(announcementRepositoryProvider).getAnnouncements(apartmentId);
}