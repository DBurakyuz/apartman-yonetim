import 'package:flutter/material.dart';
import 'package:final_project/core/theme/app_colors.dart';
import 'package:final_project/core/theme/app_text_styles.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions; 
  final PreferredSizeWidget? bottom;  

  const AppAppBar({
    super.key,
    required this.title,
    this.actions,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 54, 53, 104), 
      elevation: 0,
      centerTitle: true,
      
      // Yazıyı tekrar standart heading2 yaptık ve padding'i kaldırdık
      title: Text(
        title,
        style: AppTextStyles.heading2.copyWith(color: AppColors.white),
      ),
      
      actions: actions,
      bottom: bottom,
      iconTheme: const IconThemeData(color: AppColors.white), 
    );
  }

  // Yüksekliği standart ayarlara geri döndürdük
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));
}