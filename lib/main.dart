import 'package:final_project/core/router/app_router.dart';
import 'package:final_project/features/auth/presentation/login_page.dart';
import 'package:final_project/shared/gallery/button_gallery_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:final_project/firebase_options.dart';
import 'package:final_project/core/theme/app_theme.dart';
import 'package:final_project/core/theme/theme_provider.dart';


void main() async {
  // 1. Flutter motorunun tam olarak başlatıldığından emin ol
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Firebase'i başlat (İleride Firebase CLI ile firebase_options.dart eklendiğinde burası güncellenecek)
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  // 3. Uygulamayı ProviderScope ile sarmalayarak Riverpod'u aktif et
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Router 
    final myRouter = ref.watch(routerProvider);
    
    //Tema Hafızasını dinle (Aydınlık mı Karanlık mı?)
    final currentThemeMode = ref.watch(themeNotifierProvider);

    return MaterialApp.router(
      title: 'Site Yönetim',
      
     
      theme: AppTheme.lightTheme,      
      darkTheme: AppTheme.darkTheme,   
      
      // (Sağlayıcıdan gelen değer)
      themeMode: currentThemeMode,
      
      routerConfig: myRouter,
    );
  }
}