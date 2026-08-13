import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  // Temel ölçü birimlerimiz (Figma/Tasarım sistemlerinde genelde 4'ün katları kullanılır)
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;

  // Sık kullanılan Hazır Padding'ler
  /// Tüm sayfalarda kullanılacak standart dış kenar boşluğu
  static const EdgeInsets pagePadding = EdgeInsets.all(lg); 
  
  /// İç kartlarda veya küçük formlarda kullanılacak boşluk
  static const EdgeInsets cardPadding = EdgeInsets.all(md); 
  
  /// Sadece yatayda boşluk vermek için
  static const EdgeInsets horizontalPadding = EdgeInsets.symmetric(horizontal: lg);
}