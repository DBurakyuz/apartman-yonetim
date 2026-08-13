import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket.freezed.dart';
part 'ticket.g.dart';

enum TicketStatus {
  pending,       // Bekliyor
  resolved,      // Çözüldü
  rejected       // Reddedildi
}


@freezed
class Ticket with _$Ticket {
  const factory Ticket({
    required String id,             // Her talebin Firebase'deki benzersiz kimlik numarası
    required String residentId,     // Talebi açan kişinin UID'si
    required String authorName,     // Talebi açan kişinin adı (Ekranda göstermek için)
    required String title,          // Şikayet/Talep başlığı (Örn: Asansör Bozuk)
    required String description,    // Detaylı açıklama
    required TicketStatus status,   // Durumu (Bekliyor, Çözüldü, Reddedildi)
    required DateTime createdAt,    // Açılma tarihi ve saati
     required String apartmentId,
  }) = _Ticket;

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);
}