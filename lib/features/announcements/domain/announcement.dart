import 'package:freezed_annotation/freezed_annotation.dart';

// build_runner bu iki dosyayı bizim için üretecek
part 'announcement.freezed.dart';
part 'announcement.g.dart';

@freezed
class Announcement with _$Announcement {
  const factory Announcement({
    required String id,          // Duyurunun benzersiz şifresi
    required String title,       // Başlık (Örn: Asansör Bakımı)
    required String content,     // İçerik (Örn: Yarın sabah 10'da...)
    required DateTime createdAt, // Ne zaman yayınlandı?
    required String authorName,  // Kim yayınladı? (Örn: Burak)
     required String apartmentId,
  }) = _Announcement;

  // Firebase'den gelen karmaşık JSON verisini bu şablona çeviren metod
  factory Announcement.fromJson(Map<String, dynamic> json) => _$AnnouncementFromJson(json);
}