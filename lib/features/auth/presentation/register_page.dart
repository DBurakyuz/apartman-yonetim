import 'package:final_project/core/services/onesignal_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:final_project/core/theme/app_colors.dart';
import 'package:final_project/core/theme/app_text_styles.dart';
import 'package:final_project/core/theme/app_spacing.dart';
import 'package:final_project/shared/design_system/atoms/app_button.dart';
import 'package:final_project/shared/design_system/atoms/app_text_field.dart';

import 'package:final_project/features/auth/data/auth_repository.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _flatController = TextEditingController();
  final _passwordController = TextEditingController();
  final _apartmentIdController = TextEditingController();
  
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  Future<void> _register() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final flat = _flatController.text.trim();
    final password = _passwordController.text.trim();
    final apartmentId= _apartmentIdController.text.trim();

    if (name.isEmpty || email.isEmpty || flat.isEmpty || password.isEmpty || apartmentId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen tüm alanları doldurun")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref.read(authRepositoryProvider).registerResident(
        email: email,
        password: password,
        name: name,
        flatNumber: flat,
        apartmentId: apartmentId,
      );
      final prefs = await SharedPreferences.getInstance();
      final sessionId = DateTime.now().millisecondsSinceEpoch.toString();
      await prefs.setString('sessionId', sessionId);
      
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'sessionId': sessionId
        });
      }

         OneSignalService.sendTargetedNotification(
        title: "👋 Yeni Komşu!",
        message: "$name, Daire $flat olarak aramıza katıldı. Hoş geldin diyelim!",
        targetApartmentId: apartmentId, // Sadece o apartmana gider
      );
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Kayıt Başarılı! Uygulamaya giriliyor..."), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Hata: ${e.toString().split(']').last}"), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.md),
              
              // Geri Dön Tuşu
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface),
                  onPressed: () => context.pop(), // Geldiği yere geri döner
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              
              Text(
                "Aramıza Katıl",
                style: AppTextStyles.heading1.copyWith(color: Theme.of(context).colorScheme.onSurface),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                "Sisteme dahil olmak için bilgilerini gir",
                style: AppTextStyles.body.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.54)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),

              AppTextField(controller: _nameController, hintText: "Ad Soyad"),
              const SizedBox(height: AppSpacing.md),
              
              AppTextField(controller: _emailController, hintText: "E-Posta"),
              const SizedBox(height: AppSpacing.md),

              AppTextField(controller: _apartmentIdController, hintText: "Apartman veya Site Adı"),
              const SizedBox(height: AppSpacing.md),
              
              AppTextField(controller: _flatController, hintText: "Kapı Numarası (Örn: 14)"),
              const SizedBox(height: AppSpacing.md),

              AppTextField(
                controller: _passwordController,
                hintText: "Şifre (En az 6 hane)",
                obscureText: !_isPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.54)),
                  onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              AppButton.primary(
                text: _isLoading ? "Kaydediliyor..." : "Kayıt Ol",
                isFullWidth: true,
                onPressed: _isLoading ? null : _register,
              ),
            ],
          ),
        ),
      ),
    );
  }
}