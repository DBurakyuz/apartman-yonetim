import 'package:final_project/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:final_project/core/theme/app_colors.dart';
import 'package:final_project/core/theme/app_spacing.dart';
import 'package:final_project/shared/design_system/atoms/app_button.dart';
import 'package:final_project/features/auth/data/auth_repository.dart';
import 'package:final_project/features/auth/domain/app_user.dart';
import 'package:final_project/features/dues/data/due_repository.dart';

// Ekranda klavyeden yazı yazılacağı ve yükleniyor çarkı döneceği için (Ekran güncellenecek)
// StatelessWidget DEĞİL, Stateful (Değişken) Widget kullanıyoruz.
class AddDueDialog extends ConsumerStatefulWidget {
  const AddDueDialog({super.key});

  @override
  ConsumerState<AddDueDialog> createState() => _AddDueDialogState();
}

class _AddDueDialogState extends ConsumerState<AddDueDialog> {
  // --- DEĞİŞKENLER (İSKELET) ---
  
  // 1. Yönetici her seferinde 'Aidat' yazmasın diye kutunun içine peşinen "Aidat" yazdıran ajanımız:
  final _titleController = TextEditingController(text: "Aidat"); 
  
  // 2. Yöneticinin gireceği parayı tutacak olan boş ajanımız:
  final _amountController = TextEditingController();
  
  // 3. Butona basılınca dönen o meşhur yükleniyor çarkının tetikleyicisi (Başlangıçta kapalı):
  bool _isLoading = false;

  // --- AŞAMA 3: BEYİN (Firebase İşlemleri) ---
  Future<void> _submit() async {
    // 1. Kutulara yazılan yazıları alıyoruz (trim ile gereksiz boşlukları siliyoruz)
    final title = _titleController.text.trim();
    final amountText = _amountController.text.trim();

    // 2. GÜVENLİK KONTROLÜ: Kutular boş mu?
    if (title.isEmpty || amountText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen başlık ve tutar girin!")),
      );
      return; // Hata varsa kodu burada durdur!
    }
    
    // 3. GÜVENLİK KONTROLÜ: Tutar gerçekten bir sayı mı ve 0'dan büyük mü?
    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Geçersiz tutar! Lütfen 0'dan büyük bir sayı girin.")),
      );
      return;
    }

    // Her şey yolundaysa çarkı döndürmeye başla
    setState(() => _isLoading = true);

    try {
      
      final activeApt = ref.read(activeApartmentProvider);
      
      // Yöneticinin apartman bilgisi bulunamadıysa işlemi durdur!
      if (activeApt.isEmpty) {
        throw Exception("Seçili apartman bilgisi bulunamadı!");
      }

      // 4. AuthRepository'deki radarımızı SADECE KENDİ APARTMANIMIZ İÇİN çalıştırıyoruz
      final allUsers = await ref.read(authRepositoryProvider).getAllResidents(activeApt);
      
    
      final residents = allUsers.where((user) => user.role == UserRole.resident).toList();
      
      // Apartman boşsa uyarı ver
      if (residents.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Apartmanda kayıtlı hiç sakin bulunamadı!")),
          );
        }
        return;
      }

      // 5. DueRepository'deki o devasa kamyonu çalıştırıp herkesin hesabına faturayı kesiyoruz!
      await ref.read(dueRepositoryProvider).assignDueToAll(title, amount, residents);

      // 6. Başarılı olduysa pencereyi kapat ve yeşil mesaj ver
      if (mounted) {
        Navigator.of(context).pop(); 
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Faturalar tüm sakinlere başarıyla gönderildi!", style: TextStyle(color: Colors.green))),
        );
      }
    } catch (e) {
      // Bir hata olursa kırmızı mesaj ver
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Hata oluştu: $e", style: const TextStyle(color: Colors.red))),
        );
      }
    } finally {
      // İşlem bitince (başarılı veya başarısız) çarkı durdur
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
  
  // --- AŞAMA 2: GÖRÜNÜM (Tasarım) ---
  @override
  Widget build(BuildContext context) {
    // Ekranda açılan o uyarı kutularına Flutter'da "AlertDialog" denir.
    return AlertDialog(
      backgroundColor: AppColors.buttonPrimary,
      title: const Text("Toplu Borçlandır", style: TextStyle(color: AppColors.white)),
      
      // Pencerenin içi (Content): Alt alta iki kutu koyacağımız için Column kullanıyoruz
      content: Column(
        mainAxisSize: MainAxisSize.min, // Pencere sadece içindeki yazılar kadar uzun olsun
        children: [
          // 1. Kutu: Başlık (Aidat, Çatı masrafı vs.)
          TextField(
            controller: _titleController, // Olayları izleyen ajanımızı bağladık
            style: const TextStyle(color: AppColors.white),
            decoration: const InputDecoration(
              labelText: "Başlık / Açıklama",
              labelStyle: TextStyle(color: AppColors.white54),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.white24)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.buttonPrimary)),
            ),
          ),
          
          const SizedBox(height: AppSpacing.md), // İki kutu arası boşluk
          
          // 2. Kutu: Tutar
          TextField(
            controller: _amountController, // Tutar ajanımızı bağladık
            keyboardType: const TextInputType.numberWithOptions(decimal: true), // Sadece Sayı Klavyesi açılsın!
            style: const TextStyle(color: AppColors.white),
            decoration: const InputDecoration(
              labelText: "Tutar (TL)",
              labelStyle: TextStyle(color: AppColors.white54),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.white24)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.buttonPrimary)),
            ),
          ),
        ],
      ),
      
      // Pencerenin altındaki Butonlar (Actions)
      actions: [
        // İptal Butonu
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(), // Kapat
          child: const Text("İptal", style: TextStyle(color: AppColors.white54)),
        ),
        
        // Gönder Butonu (Eğer yükleniyorsa çark dönsün, yoksa mavi buton çıksın)
        _isLoading
            ? const CircularProgressIndicator(color: AppColors.buttonPrimary)
            : AppButton.primary(
                text: "Herkese Gönder",
                onPressed: _submit, // BEYİN BURAYA BAĞLANDI!
              ),
      ],
    );
  }
}