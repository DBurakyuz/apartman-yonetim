import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart'; // <--- İşte Sihir Burada!
import 'package:final_project/core/theme/app_colors.dart';
import 'package:final_project/core/theme/app_spacing.dart';
import 'package:final_project/features/dues/data/due_repository.dart';
import 'package:final_project/features/expenses/data/expense_repository.dart';

import 'package:final_project/features/auth/presentation/providers/auth_provider.dart';

class FinancialsSection extends ConsumerWidget {
  const FinancialsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apartmentId = ref.watch(activeApartmentProvider);

    if (apartmentId.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // 1. Kasa (Tüm Aidatlar)
    final allDuesAsync = ref.watch(allDuesStreamProvider(apartmentId));
    // 2. Tüm Giderler
    final expensesAsync = ref.watch(expensesStreamProvider(apartmentId));

    // İki radyo da yükleniyorsa çark göster
    if (allDuesAsync.isLoading || expensesAsync.isLoading) {
      return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor));
    }

    // Toplam Gelir ve Gideri hesaplıyoruz
    double totalIncome = 0;
    if (allDuesAsync.hasValue) {
      // SADECE 'Ödenmiş' olan aidatları kasaya ekle (Ödenmeyen para kasaya girmemiştir!)
      for (var due in allDuesAsync.value!) {
        if (due.isPaid) totalIncome += due.amount;
      }
    }

    double totalExpense = 0;
    if (expensesAsync.hasValue) {
      for (var exp in expensesAsync.value!) {
        totalExpense += exp.amount;
      }
    }
    
    // Kalan Net Bütçe
    double netBudget = totalIncome - totalExpense;

    return Container(
      padding: AppSpacing.pagePadding,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Apartman Kasası", style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: AppSpacing.md),
          
          // --- PASTA GRAFİĞİ ---
          SizedBox(
            height: 200, // Grafiğin boyu
            child: (totalIncome == 0 && totalExpense == 0) 
              ? Center(child: Text("Kasa tamamen boş.", style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.54))))
              : PieChart(
                  PieChartData(
                    sectionsSpace: 4,      // Dilimler arası boşluk
                    centerSpaceRadius: 40, // Ortası delik olsun (Şık bir Donut görünümü)
                    sections: [
                      // GELİR DİLİMİ (YEŞİL)
                      PieChartSectionData(
                        color: Colors.green,
                        value: totalIncome,
                        title: "${totalIncome.toStringAsFixed(0)} ₺",
                        radius: 50, // Dilim kalınlığı
                        titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      // GİDER DİLİMİ (KIRMIZI)
                      PieChartSectionData(
                        color: Colors.redAccent,
                        value: totalExpense,
                        title: "${totalExpense.toStringAsFixed(0)} ₺",
                        radius: 50,
                        titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
          ),
          
          const SizedBox(height: AppSpacing.lg),
          
          // ÖZET YAZILAR (ALTTAN ÇIKAN RENKLİ BİLGİLER)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLegendRow(context, Colors.green, "Toplam Gelir", totalIncome),
              _buildLegendRow(context, Colors.redAccent, "Toplam Gider", totalExpense),
            ],
          ),
          
          Divider(color: Theme.of(context).dividerColor, height: 24), // İnce bir çizgi çek
          
          Text(
            "Kasadaki Net Bütçe: ${netBudget.toStringAsFixed(2)} ₺",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              // Eğer kasa eksiye düştüyse kırmızı, artıdaysa yeşil yanar!
              color: netBudget >= 0 ? Colors.greenAccent : Colors.redAccent,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  // Renkli yuvarlak ve yazıları çizen minik yardımcı
  Widget _buildLegendRow(BuildContext context, Color color, String text, double amount) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text("$text: ${amount.toStringAsFixed(0)} ₺", style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7))),
      ],
    );
  }
}