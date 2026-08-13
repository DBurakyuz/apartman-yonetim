import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

// Temayı hafızada (Aydınlık mı Karanlık mı?) tutan Sağlayıcımız (Motor)
@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  ThemeMode build() {
    // Uygulama ilk açıldığında Koyu Tema (veya telefonun kendi ayarı) ile başlasın
    return ThemeMode.dark; 
  }

  // Güneş/Ay butonuna basınca burası çalışacak ve temayı tersine çevirecek
  void toggleTheme() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}