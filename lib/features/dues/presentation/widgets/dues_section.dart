import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:final_project/core/theme/app_colors.dart';
import 'package:final_project/core/theme/app_spacing.dart';
import 'package:final_project/features/auth/domain/app_user.dart';
import 'package:final_project/shared/design_system/atoms/app_card.dart';
import 'package:final_project/features/dues/data/due_repository.dart';
import 'package:final_project/core/services/onesignal_service.dart';

class DuesSection extends ConsumerWidget {
  final AppUser currentUser;
  
  const DuesSection({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duesAsync = ref.watch(userDuesStreamProvider(currentUser.id));

    return duesAsync.when(
      loading: () => Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)),
      error: (e, st) => Text("Hata: $e", style: const TextStyle(color: Colors.red)),
      data: (dues) {
        if (dues.isEmpty) {
          return const Text("Ödenmemiş borcunuz yok.", style: TextStyle(color: Colors.green, fontSize: 16));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Aidat Durumum", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: AppSpacing.sm),
            
               ...dues.map((due) {
              return AppCard(
                padding: EdgeInsets.zero, 
                child: ListTile(
                  title: Text(due.title, style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
                  subtitle: Text("${due.amount} TL", style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
                  trailing: due.isPaid 
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : (currentUser.role == UserRole.resident)
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          onPressed: () async {
                            try {
                              await ref.read(dueRepositoryProvider).markAsPaid(due.id);
                              
                              // 1. Yöneticiye Giden Bildirim (Daire x, aidatını ödedi)
                              OneSignalService.sendNotificationToRole(
                                title: "💰 Ödeme Alındı",
                                message: "${currentUser.name} (Daire ${currentUser.flatNumber ?? '?'}), '${due.title}' ödemesini gerçekleştirdi.",
                                targetApartmentId: currentUser.apartmentId ?? 'Bilinmiyor',
                                targetRole: "manager", // Sadece Yöneticilere
                              );

                              // 2. Ödeyen Kişiye Giden Teşekkür Bildirimi (Kişiye Özel Makbuz)
                              OneSignalService.sendNotificationToUser(
                                title: "✅ Ödemeniz Onaylandı",
                                message: "${due.amount} TL tutarındaki '${due.title}' ödemeniz alınmıştır. Teşekkür ederiz.",
                                targetUserId: currentUser.id, // Sadece ödeyen sakine
                              );

                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Firebase Hatası: $e"), backgroundColor: Colors.red),
                                );
                              }
                            }
                          },
                          child: const Text("Öde", style: TextStyle(color: Colors.white)),
                        )
                      : const Text("Ödenmedi", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}