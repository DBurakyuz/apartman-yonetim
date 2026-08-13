import 'package:flutter/material.dart';

class AppColors {
  // Constructor'ı private yapıyoruz ki bu class'tan obje üretilmesin, 
  // sadece içindeki static değerleri kullanalım.
  AppColors._();

  // Arka plan renkleri
  static const Color backgroundDark = Color(0xFF17171C);
  static const Color cardBackground = Color.fromARGB(255, 56, 53, 212);
  
  // Buton Renkleri
  static const Color buttonPrimary = Color(0xFF2C4364);
  static const Color buttonPrimaryDisabled = Color(0xFF232D3B);
  
  static const Color buttonTextYellow = Color(0xFFD4A35B);
  static const Color buttonTextYellowDisabled = Color(0xFF8A6C3E);

  // Genel Renkler
  static const Color white = Colors.white;
  static const Color white54 = Colors.white54;
  static const Color white24 = Colors.white24;
  static const Color white60 = Colors.white60;
}