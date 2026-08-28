import 'package:final_project/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:final_project/core/services/onesignal_service.dart';
import 'package:final_project/core/theme/app_colors.dart';
import 'package:final_project/core/theme/app_spacing.dart';
import 'package:final_project/shared/design_system/atoms/app_button.dart';

import 'package:final_project/features/auth/domain/app_user.dart';
import 'package:final_project/features/tickets/domain/ticket.dart';
import 'package:final_project/features/tickets/data/ticket_repository.dart';

// Dışarıdan kolayca çağırabilmemiz için pratik bir fonksiyon
void showAddTicketDialog(BuildContext context, WidgetRef ref, AppUser appUser) {
  showDialog(
    context: context,
    builder: (context) => _AddTicketDialog(ref: ref, appUser: appUser),
  );
}

class _AddTicketDialog extends StatefulWidget {
  final WidgetRef ref;
  final AppUser appUser;

  const _AddTicketDialog({required this.ref, required this.appUser});

  @override
  State<_AddTicketDialog> createState() => _AddTicketDialogState();
}

class _AddTicketDialogState extends State<_AddTicketDialog> {
 
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  Future<void> _submitTicket() async {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();

    if (title.isEmpty || desc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen başlık ve detay kısımlarını doldurun.")),
      );
      return;
    }

   
      final activeApt = widget.ref.read(activeApartmentProvider);
      final newTicket = Ticket(
      id: '', 
      residentId: widget.appUser.id,
      apartmentId: activeApt.isEmpty ? 'Bilinmiyor' : activeApt,
      authorName: widget.appUser.name,
      title: title,
      description: desc,
      status: TicketStatus.pending, 
      createdAt: DateTime.now(),
    );

  
    await widget.ref.read(ticketRepositoryProvider).addTicket(newTicket);
        // --- YENİ EKLENEN KOD: Sadece Yöneticilere Bildirim At ---
    OneSignalService.sendNotificationToRole(
      title: "🛠️ Yeni Talep: $title",
      message: "${widget.appUser.name} yeni bir talep/şikayet oluşturdu.",
      targetApartmentId: activeApt.isEmpty ? 'Bilinmiyor' : activeApt,
      targetRole: "manager", // SİHİRLİ KELİME: Sadece Yöneticilere Gider!
    );
    // ---------------------------------------------------------

  
    if (mounted) {
      Navigator.pop(context); // Dialog'u kapat
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Talebiniz yönetime iletildi.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      title: Text("Yeni Talep Oluştur", style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            decoration: InputDecoration(
              labelText: "Konu Başlığı (Örn: Asansör)",
              labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.54)),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _descController,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            maxLines: 3, // Uzun mesajlar için büyük kutu
            decoration: InputDecoration(
              labelText: "Talebinizin Detayları",
              labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.54)),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // İptal edip kapatır
          child: const Text("İptal", style: TextStyle(color: Colors.grey)),
        ),
        AppButton.primary(
          text: "Gönder",
          onPressed: _submitTicket, // Tıklanınca yukarıdaki gönderme fonksiyonu çalışır
        ),
      ],
    );
  }
}