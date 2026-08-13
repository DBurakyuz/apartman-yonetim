import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:final_project/features/expenses/data/expense_repository.dart';
import 'package:final_project/shared/design_system/atoms/app_card.dart';

import 'package:final_project/features/auth/presentation/providers/auth_provider.dart';

class AdminExpensesSection extends ConsumerWidget {
  const AdminExpensesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apartmentId = ref.watch(activeApartmentProvider);

    if (apartmentId.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // Giderleri canlı dinleyen radyo frekansı (ŞİFRELİ)
    final expensesAsync = ref.watch(expensesStreamProvider(apartmentId));

    return expensesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Hata: $e'),
      data: (expensesList) {
        
        if (expensesList.isEmpty) {
          return const Text('Sistemde henüz hiç gider kaydı bulunmuyor.');
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Apartman Gider Tablosu',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(height: 16),
            
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: expensesList.length,
              itemBuilder: (context, index) {
                final expense = expensesList[index];
                
                return AppCard(
                  padding: EdgeInsets.zero,
                  child: ListTile(
                    leading: const Icon(Icons.money_off, color: Colors.red),
                    title: Text(expense.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text('Tarih: ${expense.createdAt.day}/${expense.createdAt.month}/${expense.createdAt.year}'),
                    trailing: Text(
                      '-${expense.amount} TL',
                      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            )
          ],
        );
      },
    );
  }
}