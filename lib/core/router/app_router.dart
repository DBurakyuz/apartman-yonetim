import 'package:final_project/features/auth/presentation/register_page.dart';
import 'package:final_project/features/dashboard/presentation/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// İlgili sayfalar ve Provider'larımızı içeri alıyoruz
import 'package:final_project/features/auth/presentation/login_page.dart';

import 'package:final_project/shared/gallery/button_gallery_page.dart';
import 'package:final_project/features/auth/presentation/providers/auth_provider.dart';

part 'app_router.g.dart'; // Yine otomatik üretim için

// go_router'ı artık bir Provider (Sağlayıcı) olarak oluşturuyoruz ki 
// o da diğer sağlayıcıları (AuthNotifier gibi) dinleyebilsin.
@riverpod
GoRouter router(RouterRef ref) {
  // 1. KULAKLIĞI TAKTIK: AuthNotifier'ı dinliyoruz!
  // Radyo yayını her değiştiğinde bu satır sayesinde go_router otomatik tetiklenecek.
   final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/login',
    
    // 2. BEKÇİ MANTIĞI (Redirect): Her sayfa geçişinde burası çalışır
     redirect: (context, state) {
      // Kullanıcı Login veya Register sayfalarından birine mi gidiyor?
      final isGoingToAuth = state.matchedLocation == '/login' || state.matchedLocation == '/register';
      
      final isLoggedIn = authState.value != null;
      // Durum 1: Giriş YAPMAMIŞ birisi bu iki sayfa HARİCİ bir yere gitmeye çalışıyorsa
      if (!isLoggedIn && !isGoingToAuth) {
        return '/login'; // Onu Login'e yolla
      }
      // Durum 2: Giriş YAPMIŞ birisi Login veya Register'a gitmeye çalışıyorsa
      if (isLoggedIn && isGoingToAuth) {
        return '/dashboard'; // Zaten giriş yapmış, içeri yolla
      }
      return null; // Her şey yolundaysa müdahale etme
    },
    
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/dashboard', builder: (context, state) => const DashboardPage()),
      GoRoute(path: '/sandbox', builder: (context, state) => const ButtonGalleryPage()),
       GoRoute(path: '/register', builder: (context, state) => const RegisterPage()),
    ],
  );
}