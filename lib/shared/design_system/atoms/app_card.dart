import 'package:flutter/material.dart';
import 'package:final_project/core/theme/app_colors.dart';
import 'package:final_project/core/theme/app_spacing.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const AppCard({
    super.key,
    required this.child,
    this.backgroundColor,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor ?? Theme.of(context).cardColor, // Material 3'ün grileştirme efektini ezer
      margin: margin ?? const EdgeInsets.only(bottom: AppSpacing.md),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(AppSpacing.md),
        child: child,
      ),
    );
  }
}
