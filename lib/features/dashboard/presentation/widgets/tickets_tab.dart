import 'package:final_project/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:final_project/core/theme/app_colors.dart';
import 'package:final_project/core/theme/app_spacing.dart';
import 'package:final_project/shared/design_system/atoms/app_button.dart';
import 'package:final_project/features/tickets/presentation/widgets/add_ticket_dialog.dart';

import 'package:final_project/features/auth/presentation/providers/auth_provider.dart';
import 'package:final_project/features/tickets/data/ticket_repository.dart';
import 'package:final_project/features/tickets/domain/ticket.dart';

class TicketsTab extends ConsumerWidget {
  const TicketsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Kullanıcıyı ve Rolünü Bul
    final userState = ref.watch(currentUserProvider);
    final appUser = userState.value;

    final apartmentId = ref.watch(activeApartmentProvider);
    if (apartmentId.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // 2. RADYOYU AÇ (ŞİFRELİ - SADECE BİZİM APARTMAN)
    final ticketsAsync = ref.watch(ticketsStreamProvider(apartmentId));

    return Padding(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          
          AppButton.primary(
            text: "+ Yeni Talep Oluştur",
            onPressed: () {
              // Butona basılınca şikayet kutusunu aç
              if(appUser != null){
                showAddTicketDialog(context, ref, appUser);
              }
            },
          ),
          
          const SizedBox(height: AppSpacing.lg),

          // 3. RADYOYU DİNLE VE EKRANA ÇİZ
          Expanded(
            child: ticketsAsync.when( 
              loading: () => Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)),
              error: (error, stack) => Center(child: Text("Hata: $error", style: const TextStyle(color: Colors.red))),
              data: (tickets) {
                if (tickets.isEmpty) {
                  return Center(child: Text("Henüz hiç talep oluşturulmamış.", style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.54))));
                }

                return ListView.builder(
                  itemCount: tickets.length,
                  itemBuilder: (context, index) {
                    final ticket = tickets[index];

                    return Card(
                      color: Theme.of(context).cardColor,
                      margin: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: ListTile(
                        title: Text(ticket.title, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ticket.description, style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7))),
                            const SizedBox(height: AppSpacing.xs,),
                            Text("${ticket.authorName} tarafından oluşturuldu",style: AppTextStyles.caption.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.24),fontStyle: FontStyle.italic),)
                          ],
                        ),
                        
                        // SAĞ TARAFTAKİ DURUM YAZISI VE BUTONLAR
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            
                            // A) Herkesin Gördüğü Durum Yazısı
                            Text(
                              ticket.status.name.toUpperCase(),
                              style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                            ),
                            
                            // B) Sadece Admin'in Gördüğü İşlem Butonları
                            if(appUser?.role.name == 'admin' || appUser?.role.name == 'manager') ...[
                              const SizedBox(width: 8), // Boşluk
                              
                              // Bekliyor Butonu
                              IconButton(
                                icon: const Icon(Icons.access_time_rounded, color: Colors.orange, size: 24),
                                onPressed: () {
                                  ref.read(ticketRepositoryProvider).updateTicketStatus(ticket.id, TicketStatus.pending);
                                },
                              ),
                              
                              // Çözüldü Butonu
                              IconButton(
                                icon: const Icon(Icons.check_circle, color: Colors.green, size: 24),
                                onPressed: () {
                                  ref.read(ticketRepositoryProvider).updateTicketStatus(ticket.id, TicketStatus.resolved);
                                },
                              ),
                              
                              // Reddedildi Butonu
                              IconButton(
                                icon: const Icon(Icons.cancel, color: Colors.red, size: 24),
                                onPressed: () {
                                  ref.read(ticketRepositoryProvider).updateTicketStatus(ticket.id, TicketStatus.rejected);
                                },
                              ),
                            ]

                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          
        ],
      ),
    );
  }
}