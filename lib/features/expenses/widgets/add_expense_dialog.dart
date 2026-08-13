import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:final_project/core/theme/app_colors.dart';
import 'package:final_project/core/theme/app_spacing.dart';
import 'package:final_project/features/expenses/domain/expense.dart';
import 'package:final_project/features/expenses/data/expense_repository.dart';
import 'package:final_project/features/auth/presentation/providers/auth_provider.dart';

class AddExpenseDialog extends ConsumerStatefulWidget {
  const AddExpenseDialog({super.key});

  @override
  ConsumerState<AddExpenseDialog> createState() => _AddExpenseDialogState();
}

class _AddExpenseDialogState extends ConsumerState<AddExpenseDialog> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submit() async {
    final title = _titleController.text.trim();
    final amountText = _amountController.text.trim();

    if (title.isEmpty || amountText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen açıklama ve tutar girin!")),
      );
      return;
    }

    final amount = double.tryParse(amountText);
    if (amount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Geçersiz tutar girdiniz! Sadece sayı kullanın.")),
      );
      return;
    }

    setState(() => _isLoading = true);

        try {
      // 1. Seçili apartmanı çekiyoruz
      final activeApt = ref.read(activeApartmentProvider);
      if (activeApt.isEmpty) {
        throw Exception("Seçili apartman bilgisi bulunamadı!");
      }

      // 2. Yeni Gideri (Expense) oluştururken seçili apartman şifremizi basıyoruz!
      final newExpense = Expense(
        id: '',
        title: title,
        apartmentId: activeApt,
        amount: amount,
        createdAt: DateTime.now(),
      );

      // Yazdığımız repository'deki fonksiyonu çağırıp Firebase'e yolluyoruz
      await ref.read(expenseRepositoryProvider).addExpense(newExpense);

      if (mounted) {
        Navigator.of(context).pop(); 
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gider başarıyla kasaya işlendi!", style: TextStyle(color: Colors.green))),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Hata oluştu: $e", style: const TextStyle(color: Colors.red))),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.buttonPrimary,
      title: const Text("Yeni Gider Ekle", style: TextStyle(color: Colors.redAccent)),
      
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            style: const TextStyle(color: AppColors.white),
            decoration: const InputDecoration(
              labelText: "Harcama Nedeni (Örn: Çatı Tamiri)",
              labelStyle: TextStyle(color: AppColors.white54),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.white24)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
            ),
          ),
          
          const SizedBox(height: AppSpacing.md),
          
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(color: AppColors.white),
            decoration: const InputDecoration(
              labelText: "Tutar (TL)",
              labelStyle: TextStyle(color: AppColors.white54),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.white24)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
            ),
          ),
        ],
      ),
      
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text("İptal", style: TextStyle(color: AppColors.white54)),
        ),
        
        _isLoading
            ? const CircularProgressIndicator(color: Colors.redAccent)
            : ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                onPressed: _submit,
                child: const Text("Kasadan Düş", style: TextStyle(color: Colors.white)),
              ),
      ],
    );
  }
}