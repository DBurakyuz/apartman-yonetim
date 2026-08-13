import 'package:final_project/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:final_project/shared/design_system/atoms/app_button.dart';

class ButtonGalleryPage extends StatelessWidget {
  const ButtonGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF17171C), // Koyu arka plan
      appBar: AppBar(
        title: const Text('Buton Tasarım Testi'),
        backgroundColor: Colors.black45,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("PRIMARY (Lacivert)", style: AppTextStyles.caption.copyWith(color: Colors.white70)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                AppButton.primary(text: "Ödeme Ekle", onPressed: () {}),
                AppButton.primary(text: "Kaydediliyor", isLoading: true),
                AppButton.primary(text: "Ödeme Ekle", onPressed: null),
              ],
            ),
            
            const Divider(color: Colors.white12, height: 48),

            Text("SECONDARY (Çizgili)", style: AppTextStyles.button.copyWith(color: Colors.white70)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                AppButton.secondary(text: "Vazgeç", onPressed: () {}),
                AppButton.secondary(text: "Kaydediliyor", isLoading: true),
                AppButton.secondary(text: "Vazgeç", onPressed: null),
              ],
            ),

            const Divider(color: Colors.white12, height: 48),

            Text("TEXT (Sadece Yazı)", style: AppTextStyles.body.copyWith(color: Colors.white70)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                AppButton.text(text: "Detayları gör", onPressed: () {}),
                AppButton.text(text: "Yükleniyor", isLoading: true),
                AppButton.text(text: "Detayları gör", onPressed: null),
              ],
            ),

            const Divider(color: Colors.white12, height: 48),

            Text("EKSTRALAR (İkonlu & Tam Genişlik)", style: AppTextStyles.body),
            const SizedBox(height: 16),
            AppButton.primary(text: "Talep oluştur", icon: Icons.add, onPressed: () {}),
            const SizedBox(height: 16),
            AppButton.primary(text: "Ödemeyi onayla", icon: Icons.arrow_downward, isFullWidth: true, onPressed: () {}),
          ],
        ),
      ),
    );
  }
}