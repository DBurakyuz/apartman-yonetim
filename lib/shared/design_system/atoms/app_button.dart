import 'package:final_project/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum ButtonVariant { primary, secondary, text }
enum ButtonSize { medium, small }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
  });

  // Kullanımı kolaylaştırmak için Factory Constructor'lar (Senior Pratiği)
  factory AppButton.primary({
    required String text,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? icon,
    ButtonSize size = ButtonSize.medium,
  }) => AppButton(text: text, onPressed: onPressed, variant: ButtonVariant.primary, isLoading: isLoading, isFullWidth: isFullWidth, icon: icon, size: size);

  factory AppButton.secondary({
    required String text,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? icon,
    ButtonSize size = ButtonSize.medium,
  }) => AppButton(text: text, onPressed: onPressed, variant: ButtonVariant.secondary, isLoading: isLoading, isFullWidth: isFullWidth, icon: icon, size: size);

    factory AppButton.text({
    required String text,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? icon,
    ButtonSize size = ButtonSize.medium,
  }) => AppButton(
        text: text, 
        onPressed: onPressed, 
        variant: ButtonVariant.text, 
        isLoading: isLoading, 
        isFullWidth: isFullWidth, 
        icon: icon, 
        size: size
      );


  @override
  Widget build(BuildContext context) {
    // Görseldeki yükseklik (48px ve 40px) ayarı
    final double buttonHeight = size == ButtonSize.medium ? 48.0 : 40.0;

    // Loading veya Disabled (onPressed null) ise tıklanmayı kapat
    final bool isDisabled = isLoading || onPressed == null;

    // İçerik: İkon, Spinner ve Metin yerleşimi
    Widget buttonContent = Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.white),
          ),
          const SizedBox(width: 8),
        ] else if (icon != null) ...[
          Icon(icon, size: 20),
          const SizedBox(width: 8),
        ],
        Text(text),
      ],
    );

    // Ana yapıyı sarmalayan buton
    Widget button;
    
     switch (variant) {
      case ButtonVariant.primary:
        button = ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(isFullWidth ? double.infinity : 0, buttonHeight),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white, // Mavi üstüne her zaman beyaz yazı
            disabledBackgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
            disabledForegroundColor: Colors.white54,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0, 
          ),
          child: buttonContent,
        );
        break;
      case ButtonVariant.secondary:
        button = OutlinedButton(
          onPressed: isDisabled ? null : onPressed,
          style: OutlinedButton.styleFrom(
            minimumSize: Size(isFullWidth ? double.infinity : 0, buttonHeight),
            foregroundColor: Theme.of(context).colorScheme.onSurface,
            disabledForegroundColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            side: BorderSide(
              color: isDisabled ? Theme.of(context).dividerColor : Theme.of(context).colorScheme.onSurface.withOpacity(0.6), 
              width: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: buttonContent,
        );
        break;
      case ButtonVariant.text:
        button = TextButton(
          onPressed: isDisabled ? null : onPressed,
          style: TextButton.styleFrom(
            minimumSize: Size(isFullWidth ? double.infinity : 0, buttonHeight),
            foregroundColor: Theme.of(context).primaryColor, 
            disabledForegroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: buttonContent,
        );
        break;
    }

    return button;
  }
}