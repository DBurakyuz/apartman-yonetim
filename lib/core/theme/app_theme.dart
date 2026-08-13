import 'package:flutter/material.dart';

class AppTheme {
 
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF2F2F7), // Apple tarzı tatlı bir gri-beyaz (Göz yormaz)
    cardColor: Colors.white, // Kartlar bembeyaz olacak
    primaryColor: const Color(0xFF007AFF), // Modern Parlak Mavi (Butonlar için)
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF007AFF),
      secondary: Color(0xFF5856D6), // İkincil tatlı bir Mor
      surface: Colors.white,
      onSurface: Color(0xFF1C1C1E), // Yazı rengi (Koyu Gri - Siyahtan daha moderndir)
    ),
    dividerColor: Colors.grey.withOpacity(0.2),
  );

 
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF000000), // Tam Siyah (OLED ekranlar için mükemmel)
    cardColor: const Color(0xFF1C1C1E), // Kartlar hafif gri (Derinlik hissi verir)
    primaryColor: const Color(0xFF0A84FF), // Gece modunda parlayan Neon Mavi
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF0A84FF),
      secondary: Color(0xFF5E5CE6),
      surface: Color(0xFF1C1C1E),
      onSurface: Colors.white, // Yazı rengi Bembeyaz
    ),
    dividerColor: Colors.white.withOpacity(0.1),
  );
}