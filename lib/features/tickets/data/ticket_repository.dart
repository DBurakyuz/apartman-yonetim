import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/features/tickets/domain/ticket.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ticket_repository.g.dart';

class TicketRepository {
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> addTicket(Ticket ticket)async {
    final data = ticket.toJson();

    data.remove('id');

    data['createdAt'] = FieldValue.serverTimestamp();

    await _firestore.collection('tickets').add(data);

  }

  Future<void> updateTicketStatus(String ticketId, TicketStatus newStatus) async {
    // Firebase'de o belgeyi bul (.doc(ticketId)) ve sadece 'status' (durum) alanını güncelle
    await _firestore.collection('tickets').doc(ticketId).update({
      'status': newStatus.name, // Örn: 'resolved' yazısı gidecek
    });
  }

  
  Stream<List<Ticket>> getTicketsStream(String apartmentId, {String? residentId}) {
    return _firestore.collection('tickets')
        .where('apartmentId', isEqualTo: apartmentId)
        .snapshots()
        .map((snapshot) {
      
      List<Ticket> tickets = []; 

      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>; 
        data['id'] = doc.id; 
        
        if (data['createdAt'] is Timestamp) {
           data['createdAt'] = (data['createdAt'] as Timestamp).toDate().toIso8601String();
        }
        
        final ticket = Ticket.fromJson(data);
        
        // Eğer residentId verilmişse, sadece o kişinin biletlerini ekle (Lokal filtreleme)
        if (residentId != null && ticket.residentId != residentId) {
          continue;
        }
        
        tickets.add(ticket);
      }
      
      // Sıralamayı Firebase yerine Dart (Telefon) üzerinde yapıyoruz
      tickets.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return tickets;
    });
  }
}

@riverpod
TicketRepository ticketRepository(TicketRepositoryRef ref) {
  return TicketRepository();
}

@riverpod
Stream<List<Ticket>> ticketsStream(TicketsStreamRef ref, String apartmentId, {String? residentId}) {
  return ref.watch(ticketRepositoryProvider).getTicketsStream(apartmentId, residentId: residentId);
}
