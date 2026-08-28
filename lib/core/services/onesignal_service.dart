import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OneSignalService {
  static const String _appId = "4b15a6e8-a1b4-41c0-9227-dfbd73ee8b53";
  static String get _restApiKey => dotenv.env['ONESIGNAL_REST_API_KEY'] ?? "";

  static Future<void> sendTargetedNotification({
    required String title,
    required String message,
    required String targetApartmentId,
  }) async {
    final url = Uri.parse('https://onesignal.com/api/v1/notifications');

    final body = {
      "app_id": _appId,
      "filters": [
        {"field": "tag", "key": "apartmentId", "relation": "=", "value": targetApartmentId}
      ],
      "headings": {"en": title, "tr": title},
      "contents": {"en": message, "tr": message},
    };

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization": "Basic $_restApiKey"
        },
        body: jsonEncode(body),
      );
      print("OneSignal Response: ${response.statusCode} - ${response.body}");
    } catch (e) {
      print("OneSignal Bildirim Gönderme Hatası: $e");
    }
  }
    // --- 1. SİLAH: SADECE BELİRLİ BİR ROLE BİLDİRİM (Örn: Sadece Yöneticilere) ---
  static Future<void> sendNotificationToRole({
    required String title,
    required String message,
    required String targetApartmentId,
    required String targetRole, // manager veya resident
  }) async {
    final url = Uri.parse('https://onesignal.com/api/v1/notifications');
    final body = {
      "app_id": _appId,
      "filters": [
        {"field": "tag", "key": "apartmentId", "relation": "=", "value": targetApartmentId},
        {"operator": "AND"}, // VEEE (Çift Şart Koşuyoruz)
        {"field": "tag", "key": "role", "relation": "=", "value": targetRole}
      ],
      "headings": {"en": title, "tr": title},
      "contents": {"en": message, "tr": message},
    };

    try {
      await http.post(
        url,
        headers: {"Content-Type": "application/json; charset=utf-8", "Authorization": "Basic $_restApiKey"},
        body: jsonEncode(body),
      );
    } catch (e) {
      print("Role Özel Bildirim Hatası: $e");
    }
  }

  // --- 2. SİLAH: SADECE BELİRLİ BİR KİŞİYE BİLDİRİM (Kişiye Özel) ---
  static Future<void> sendNotificationToUser({
    required String title,
    required String message,
    required String targetUserId, // Yalnızca bu ID'ye sahip telefona gidecek
  }) async {
    final url = Uri.parse('https://onesignal.com/api/v1/notifications');
    final body = {
      "app_id": _appId,
      // Doğrudan kullanıcının Firebase ID'sini (OneSignal'daki external_id) hedef alıyoruz
      "include_aliases": {
        "external_id": [targetUserId]
      },
      "target_channel": "push",
      "headings": {"en": title, "tr": title},
      "contents": {"en": message, "tr": message},
    };

    try {
      await http.post(
        url,
        headers: {"Content-Type": "application/json; charset=utf-8", "Authorization": "Basic $_restApiKey"},
        body: jsonEncode(body),
      );
    } catch (e) {
      print("Kişiye Özel Bildirim Hatası: $e");
    }
  }
}
