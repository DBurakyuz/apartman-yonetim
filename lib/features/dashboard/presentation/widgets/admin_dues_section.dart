import 'package:final_project/features/auth/data/auth_repository.dart';
import 'package:final_project/features/dues/data/due_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:final_project/features/auth/presentation/providers/auth_provider.dart';
import 'package:final_project/features/auth/domain/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/core/services/onesignal_service.dart';

class AdminDuesSection extends ConsumerWidget {
  const AdminDuesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apartmentId = ref.watch(activeApartmentProvider);

    if (apartmentId.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // 1. Aidatları dinle
    final allDuesAsync = ref.watch(
      allDuesStreamProvider(apartmentId),
    );

    // 2. Kullanıcıları dinle
    final allUsersAsync = ref.watch(allUsersProvider);
    final usersList = allUsersAsync.value ?? [];

    return allDuesAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (e, st) => Text('Hata: $e'),
      data: (allDues) {
        if (allDues.isEmpty) {
          return const Text('Kayıt Bulunamadı');
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Tüm Apartmanın Aidat Durumu',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 16),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: usersList.length,
              itemBuilder: (context, index) {
                final user = usersList[index];

                final userDues = allDues
                    .where((due) => due.residentId == user.id)
                    .toList();

                final unPaid = userDues.any(
                  (due) => due.isPaid == false,
                );

                final cardColor = unPaid
                    ? Colors.red.withOpacity(0.1)
                    : (userDues.isEmpty
                        ? Colors.grey.withOpacity(0.1)
                        : Colors.green.withOpacity(0.1));

                final statusText = unPaid
                    ? 'Borcu Var'
                    : (userDues.isEmpty ? 'Fatura Yok' : 'Borcu Yok');

                final statusColor = unPaid
                    ? Colors.red
                    : (userDues.isEmpty ? Colors.grey : Colors.green);

                final statusIcon = unPaid
                    ? Icons.cancel
                    : (userDues.isEmpty
                        ? Icons.help_outline
                        : Icons.check_circle);

                return Card(
                  color: cardColor,
                  elevation: 0,
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                      color: statusColor,
                    ),

                    title: Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Row(
                      children: [
                        Text(
                          'Daire: ${user.flatNumber ?? "?"} | ',
                        ),

                        Text(
                          user.role == UserRole.manager
                              ? "YÖNETİCİ"
                              : "Daire Sakini",
                          style: TextStyle(
                            color: user.role == UserRole.manager
                                ? Colors.purple
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // Admin'e dokunulamaz
                        if (user.role != UserRole.admin)
                          InkWell(
                            onTap: () async {
                              // Sistemi kullanan kişi
                              final currentUser =
                                  ref.read(currentUserProvider).value;

                              if (currentUser == null) return;

                              // Yeni rol
                              final newRole =
                                  user.role == UserRole.manager
                                      ? UserRole.resident
                                      : UserRole.manager;

                              // Onay penceresi
                              final bool? confirm =
                                  await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text(
                                    "Yetki Değişimi",
                                  ),
                                  content: Text(
                                    (currentUser.role ==
                                                UserRole.manager &&
                                            newRole ==
                                                UserRole.manager)
                                        ? "Yöneticilik yetkinizi "
                                            "${user.name} isimli kişiye "
                                            "devretmek üzeresiniz. "
                                            "İşlem sonrasında sizin "
                                            "yetkiniz alınacak ve SAKİN "
                                            "olacaksınız. Onaylıyor musunuz?"
                                        : "${user.name} isimli kişinin "
                                            "statüsünü "
                                            "${newRole == UserRole.manager ? 'YÖNETİCİ' : 'DAİRE SAKİNİ'} "
                                            "olarak değiştirmek istediğinize "
                                            "emin misiniz?",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: const Text("İptal"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      child: const Text(
                                        "Onayla",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );

                              // İptal edildiyse çık
                              if (confirm != true) return;

                              // Karşı tarafın rolünü değiştir
                              await ref
                                  .read(authRepositoryProvider)
                                  .updateUserRole(
                                    user.id,
                                    newRole,
                                  );

                              // Yönetici yetkisini devrettiyse
                              // kendisini sakin yap
                              if (currentUser.role ==
                                      UserRole.manager &&
                                  newRole == UserRole.manager) {
                                await ref
                                    .read(authRepositoryProvider)
                                    .updateUserRole(
                                      currentUser.id,
                                      UserRole.resident,
                                    );
                              }
                              // --- YENİ EKLENEN KOD: Doğrudan Hedef Kişiye Özel Bildirim At ---
                              final String rolAdi = (newRole == UserRole.manager) ? "YÖNETİCİ" : "Daire Sakini";
                              
                              OneSignalService.sendNotificationToUser(
                              title: "👑 Yetkileriniz Güncellendi",
                              message: "Apartmandaki rolünüz '$rolAdi' olarak değiştirildi.",
                              targetUserId: user.id, // VURUCU NOKTA: Sadece işlem yapılan kişiye gider!
);
// -----------------------------------------------------------------

                              // Verileri yenile
                              ref.invalidate(currentUserProvider);

                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Yetki işlemi başarıyla tamamlandı!"),
                                  ),
                                );
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Icon(
                                Icons.admin_panel_settings,
                                size: 20,
                              ),
                            ),
                          ),
                          
                        // --- YENİ EKLENEN KOD: KİŞİYİ SİLME (ÇIKARMA) BUTONU ---
                        if (user.role != UserRole.admin)
                          InkWell(
                            onTap: () async {
                              final bool? confirm = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Kişiyi Çıkar"),
                                  content: Text("${user.name} isimli kişiyi apartmandan tamamen silmek istediğinize emin misiniz? Bu işlem geri alınamaz."),
                                  actions: [
                                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("İptal")),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                      onPressed: () => Navigator.pop(context, true),
                                      child: const Text("Sil", style: TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                ),
                              );
                              
                              if (confirm == true) {
                                // 1. Veritabanından Acımasızca Sil!
                                await FirebaseFirestore.instance.collection('users').doc(user.id).delete();
                                
                                // 2. Tüm Apartmana Dedikoduyu (Bildirimi) Sal!
                                OneSignalService.sendTargetedNotification(
                                  title: "🚪 Ayrılık",
                                  message: "${user.name}, apartmanımızdan ayrılmıştır.",
                                  targetApartmentId: apartmentId,
                                );
                                
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Kişi başarıyla apartmandan silindi.")));
                                }
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Icon(Icons.delete_outline, size: 20, color: Colors.red),
                            ),
                          ),
                        // --------------------------------------------------------
                      ],
                    ),

                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          statusIcon,
                          color: statusColor,
                          size: 20,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          statusText,
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    // Aidat detaylarını göster
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              '${user.name} - Ödeme Detayı',
                            ),
                            content: SizedBox(
                              width: double.maxFinite,
                              child: userDues.isEmpty
                                  ? const Text(
                                      'Bu kişiye ait hiçbir fatura '
                                      'kaydı bulunamadı.',
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: userDues.length,
                                      itemBuilder: (context, i) {
                                        final due = userDues[i];

                                        return ListTile(
                                          title: Text(due.title),
                                          subtitle: Text(
                                            '${due.amount} TL',
                                          ),
                                          trailing: due.isPaid
                                              ? const Icon(
                                                  Icons.check_circle,
                                                  color: Colors.green,
                                                )
                                              : const Icon(
                                                  Icons.cancel,
                                                  color: Colors.red,
                                                ),
                                        );
                                      },
                                    ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(),
                                child: const Text('Kapat'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

// Tüm kullanıcıların listesini çeken provider
// Sadece seçili apartmandaki kullanıcıları getirir.
// Tüm kullanıcıların listesini CANLI çeken provider (Stream)
final allUsersProvider = StreamProvider<List<AppUser>>((ref) {
  final activeApt = ref.watch(activeApartmentProvider);

  if (activeApt.isEmpty) {
    return Stream.value([]); // Apartman seçili değilse boş liste döner
  }

  // get() yerine snapshots() kullanarak canlı yayına geçiyoruz!
  return FirebaseFirestore.instance
      .collection('users')
      .where('apartmentId', isEqualTo: activeApt)
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return AppUser.fromJson(data);
    }).toList();
  });
});