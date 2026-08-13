import 'package:final_project/features/dashboard/presentation/widgets/admin_dues_section.dart';
import 'package:final_project/features/dashboard/presentation/widgets/admin_expenses_section.dart';
import 'package:final_project/features/expenses/widgets/add_expense_dialog.dart';
import 'package:final_project/features/expenses/widgets/financials_section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:final_project/core/theme/app_colors.dart';
import 'package:final_project/core/theme/app_text_styles.dart';
import 'package:final_project/core/theme/app_spacing.dart';
import 'package:final_project/shared/design_system/atoms/app_button.dart';

import 'package:final_project/features/auth/domain/app_user.dart';
import 'package:final_project/features/auth/presentation/providers/auth_provider.dart';
import 'package:final_project/features/auth/data/auth_repository.dart';
import 'package:final_project/features/dues/data/due_repository.dart';
import 'package:final_project/features/dues/due.dart';
import 'package:final_project/features/dues/presentation/widgets/dues_section.dart';
import 'package:final_project/features/dues/presentation/widgets/add_due_dialog.dart';

class DueTab extends ConsumerWidget {
  final AppUser appUser;

  const DueTab({super.key, required this.appUser});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Hoş Geldin, ${appUser.name}",
            style: AppTextStyles.heading1.copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          Text(
            "Rolün: ${appUser.role.name}",
            style: AppTextStyles.body.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.54)),
          ),
          
          const SizedBox(height: AppSpacing.xl),

          // Sadece Admin ve Manager finansal tabloyu görebilir
          if (appUser.role == UserRole.admin || appUser.role == UserRole.manager) ...[
            const FinancialsSection(),
            const SizedBox(height: AppSpacing.xl),
          ],


          if(appUser.role == UserRole.admin || appUser.role == UserRole.manager) ...[
          const AdminDuesSection(),
          const SizedBox(height: 24,),
          const AdminExpensesSection(),
          ]
          else
          DuesSection(currentUser: appUser),
          
         

                    // SADECE ADMİN VE YÖNETİCİ GÖREBİLİR
          if (appUser.role == UserRole.admin || appUser.role == UserRole.manager)
            Row(
              children: [
                // 1. GELİR (BORÇLANDIRMA) BUTONU
                Expanded(
                  child: AppButton.primary(
                    text: "Ödeme Ata",
                    onPressed: () {
                      showDialog(context: context, builder: (context) => const AddDueDialog());
                    },
                  ),
                ),
                
                const SizedBox(width: AppSpacing.md), // İki buton arası boşluk
                
                // 2. GİDER EKLEME BUTONU (Kırmızı Temalı)
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      showDialog(context: context, builder: (context) => const AddExpenseDialog());
                    },
                    child: const Text("Gider Ekle", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
              ],
            ),

          const SizedBox(height: AppSpacing.xl),

        ],
      ),
    );
  }
}