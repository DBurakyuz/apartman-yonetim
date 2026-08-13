import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Tema ve Bileşen İçe Aktarımları (Import)
import 'package:final_project/core/theme/app_colors.dart';
import 'package:final_project/core/theme/app_text_styles.dart';
import 'package:final_project/core/theme/app_spacing.dart';
import 'package:final_project/shared/design_system/atoms/app_button.dart';
import 'package:final_project/shared/design_system/atoms/app_text_field.dart';

import 'package:final_project/features/auth/presentation/providers/auth_provider.dart';
import 'package:final_project/features/auth/domain/app_user.dart';
import 'package:final_project/features/auth/data/auth_repository.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  // Şifrenin görünürlük durumu
  bool _isPasswordVisible = false;
  // E-Posta ve Şifre kutularındaki yazıları yakalayacak denetleyiciler
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // Yükleniyor durumunu göstermek için (Butona basıldığında dönen çark)
  bool _isLoading = false;

  void _showResetPasswordDialog() {
    final resetEmailController = TextEditingController();
    bool isResetting = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Theme.of(context).cardColor,
              title: Text("Şifre Sıfırlama", style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Kayıtlı e-posta adresinizi girin. Size bir sıfırlama bağlantısı göndereceğiz.", 
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: resetEmailController,
                    hintText: "E-Posta Adresiniz",
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: isResetting ? null : () => Navigator.pop(context),
                  child: const Text("İptal", style: TextStyle(color: Colors.grey)),
                ),
                isResetting 
                  ? const CircularProgressIndicator()
                  : AppButton.primary(
                      text: "Gönder",
                      onPressed: () async {
                        final email = resetEmailController.text.trim();
                        if (email.isEmpty) return;

                        setDialogState(() => isResetting = true);
                        try {
                          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                          if (context.mounted) {
                            Navigator.pop(context); 
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Bağlantı gönderildi! E-postanızı kontrol edin."), backgroundColor: Colors.green),
                            );
                          }
                        } catch (e) {
                          setDialogState(() => isResetting = false);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Hata: ${e.toString().split(']').last}"), backgroundColor: Colors.red),
                            );
                          }
                        }
                      },
                    ),
              ],
            );
          }
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // SafeArea çentik ve alt barların üzerine taşmayı önler
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.pagePadding, // Oluşturduğumuz sabit boşluk (24px)
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- 1. BAŞLIKLAR ---
              Text(
                "Site Yönetim",
                style: AppTextStyles.heading1.copyWith(color: Theme.of(context).colorScheme.onSurface),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                "Lütfen e-posta ve şifrenizle giriş yapın",
                style: AppTextStyles.body.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.54)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),

              // --- 2. E-POSTA KUTUSU ---
              AppTextField(
                controller: _emailController,
                hintText: "E-Posta",
              ),
              const SizedBox(height: AppSpacing.md),

              // --- 3. ŞİFRE KUTUSU ---
              AppTextField(
                controller: _passwordController,
                hintText: "Şifre",
                obscureText: !_isPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.54),
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // --- 4. GİRİŞ YAP BUTONU ---
              AppButton.primary(
                text: _isLoading ? "Giriş yapılıyor..." : "Giriş Yap",
                isFullWidth: true,
                onPressed: _isLoading ? null : () async {
                  
                  if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Lütfen e-posta ve şifreyi doldurun")),
                    );
                    return;
                  }

                  setState(() {
                    _isLoading = true;
                  });

                  try {
                    await ref.read(authRepositoryProvider).signInWithEmailAndPassword(
                      _emailController.text.trim(), 
                      _passwordController.text.trim()
                    );
                  } catch (e) {
                    setState(() {
                      _isLoading = false; 
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Giriş başarısız: ${e.toString().split(']').last}"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
              
                const SizedBox(height:8,),

              // --- 5. ŞİFREMİ UNUTTUM BUTONU ---
              AppButton.text(
                text: "Şifremi Unuttum",
                onPressed: () {
                  _showResetPasswordDialog();
                },
              ),
              const SizedBox(height:8,),

                const SizedBox(height: AppSpacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Hesabınız yok mu?", style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.54))),
                  TextButton(
                    onPressed: () {
                      context.push('/register'); // YENİ: Kayıt sayfasına git emri
                    },
                    child: Text("Kayıt Ol", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}