import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  // Büyük başlıklar için (Örn: Ekran isimleri)
  static TextStyle heading1 = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    
  );

    static TextStyle heading2 = GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  // Standart okunabilir metinler için
  static TextStyle body = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  // Butonların içindeki yazılar için
  static TextStyle button = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600, // Yarı kalın
  );
  
  // Küçük bilgilendirme yazıları için
  static TextStyle caption = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}