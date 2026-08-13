import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:final_project/core/theme/app_colors.dart';
import 'package:final_project/core/theme/app_text_styles.dart';
import 'package:final_project/core/theme/app_spacing.dart';
import 'package:final_project/shared/design_system/atoms/app_card.dart';

import 'package:final_project/features/announcements/data/announcement_repository.dart';

import 'package:final_project/features/auth/presentation/providers/auth_provider.dart';

class AnnouncementsTab extends ConsumerWidget {
  const AnnouncementsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Aktif apartmanı al
    final apartmentId = ref.watch(activeApartmentProvider);

    if (apartmentId.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // Duyuruları canlı olarak dinleyen radyo (ŞİFRELİ)
    final announcementsAsync = ref.watch(announcementsStreamProvider(apartmentId));

    return Padding(
      padding: AppSpacing.pagePadding,
      child: announcementsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.buttonTextYellow),
        ),
        error: (error, stack) => Center(
          child: Text("Hata: $error", style: const TextStyle(color: Colors.red)),
        ),
        data: (announcements) {
          if (announcements.isEmpty) {
            return const Center(
              child: Text("Henüz hiç duyuru yayınlanmamış.", style: TextStyle(color: AppColors.white54)),
            );
          }

          return ListView.builder(
            itemCount: announcements.length,
            itemBuilder: (context, index) {
              final announcement = announcements[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: AppCard(
                  child: ListTile(
                    title: Text(
                      announcement.title,
                      style: AppTextStyles.heading2,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          announcement.content,
                          style: AppTextStyles.body,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                       Text( "${announcement.authorName} - ${announcement.createdAt.day}/${announcement.createdAt.month}/${announcement.createdAt.year}",
                              style: const TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}