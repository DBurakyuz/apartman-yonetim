import 'package:final_project/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:final_project/core/theme/app_colors.dart';
import 'package:final_project/core/theme/app_spacing.dart';
import 'package:final_project/shared/design_system/atoms/app_button.dart';
import 'package:final_project/shared/design_system/atoms/app_text_field.dart';
import 'package:final_project/features/auth/domain/app_user.dart';
import 'package:final_project/features/announcements/domain/announcement.dart';
import 'package:final_project/features/announcements/data/announcement_repository.dart';

import 'package:final_project/core/services/onesignal_service.dart';

void showAddAnnouncementDialog(
  BuildContext context,
  WidgetRef ref,
  AppUser currentUser,
) {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
          "Yeni Duyuru",
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(
              controller: titleController,
              hintText: "Duyuru Başlığı",
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              controller: contentController,
              hintText: "Duyuru İçeriği",
              maxLines: 4, 
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); 
            },
            child: Text("İptal", style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.54))),
          ),
          AppButton.primary(
            text: "Yayınla",
            onPressed: () async {
              if (titleController.text.trim().isEmpty || contentController.text.trim().isEmpty) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Lütfen başlık ve içerik alanlarını doldurun.")),
                  );
                }
                return;
              }

              final activeApt = ref.read(activeApartmentProvider);
              final newAnnouncement = Announcement(
                id: '',
                title: titleController.text.trim(),
                content: contentController.text.trim(),
                apartmentId: activeApt.isEmpty ? 'Bilinmiyor' : activeApt,
                createdAt: DateTime.now(),
                authorName: currentUser.name,
              );

              await ref.read(announcementRepositoryProvider).addAnnouncement(newAnnouncement);
              
              // Hedefli Bildirim Gönder (Sadece o apartmandakilere)
              OneSignalService.sendTargetedNotification(
                title: "📢 " + titleController.text.trim(),
                message: contentController.text.trim(),
                targetApartmentId: activeApt,
              );
              
              if (context.mounted) {
                Navigator.pop(context); 
              }
            },
          )
        ],
      );
    },
  );
}