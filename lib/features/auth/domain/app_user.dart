 import 'package:freezed_annotation/freezed_annotation.dart';

// Bu satırlar çok önemli! 
// Build_runner birazdan bu isimlerde iki yeni dosya üretecek.
part 'app_user.freezed.dart';
part 'app_user.g.dart';

// Uygulamadaki 3 Kullanıcı Rolü
enum UserRole {
  admin,      // Sistemin sahibi
  manager,    // Yönetici
  resident,   // Daire sahibi/Kiracı
}

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String email,
    required String name,
    required UserRole role,
    String? apartmentId, // Hangi site/apartmanda olduğu (Admin için boş olabilir)
    String? flatNumber,  // Kapı numarası (Sadece resident için dolu olabilir)
  }) = _AppUser;

  // Firebase'den gelen JSON verisini objeye çevirmek için gerekli metod
  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
}