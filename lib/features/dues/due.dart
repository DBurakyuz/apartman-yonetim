import 'package:freezed_annotation/freezed_annotation.dart';
part 'due.freezed.dart';
part 'due.g.dart';
@freezed
class Due with _$Due {
  const factory Due({
    required String id,          // Faturanın seri numarası (Firebase ID)
    required String residentId,  // Borçlu kişinin UID'si
    required double amount,      // Tutar (Kuruşlu olabilsin diye double kullanıyoruz)
    required String title,       // Hangi ay? (Örn: "Şubat 2024")
    required bool isPaid,        // Ödendi mi? (Evet: true, Hayır: false)
    required DateTime createdAt, // Fatura kesim tarihi
     required String apartmentId,
  }) = _Due;
  // Firebase'den gelen veriyi bizim Due kalıbımıza döker
  factory Due.fromJson(Map<String, dynamic> json) => _$DueFromJson(json);
}