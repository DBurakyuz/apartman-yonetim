import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:final_project/features/expenses/domain/expense.dart';

part 'expense_repository.g.dart';

class ExpenseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 1. YENİ GİDER EKLEME (Sadece Yönetici Kullanacak)
  Future<void> addExpense(Expense expense) async {
    final data = expense.toJson();
    data.remove('id'); // Firebase ID'yi kendisi otomatik versin diye siliyoruz
    data['createdAt'] = FieldValue.serverTimestamp(); // Firebase'in saatini basıyoruz

    await _firestore.collection('expenses').add(data);
  }

  // 2. TÜM GİDERLERİ GETİR (Grafik Çizmek İçin Radyo Yayını)
   Stream<List<Expense>> getAllExpenses(String apartmentId) { // <-- Şifre istedik
    return _firestore
        .collection('expenses')
        .where('apartmentId', isEqualTo: apartmentId) // <-- FİLTRE EKLENDİ (orderBy SİLİNDİ)
        .snapshots()
        .map((snapshot) {
          
      final list = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        
        if (data['createdAt'] is Timestamp) {
           data['createdAt'] = (data['createdAt'] as Timestamp).toDate().toIso8601String();
        }
        return Expense.fromJson(data);
      }).toList();
      
      // Sıralamayı Firebase yerine Dart (Telefon) üzerinde yapıyoruz ki hata vermesin!
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return list;
    });
  }
}
// --- SAĞLAYICILAR (Provider'lar) ---
@riverpod
ExpenseRepository expenseRepository(ExpenseRepositoryRef ref) {
  return ExpenseRepository();
}
// Pasta grafiğin dinleyeceği canlı harcama yayını (ŞİFREYİ İÇERİYOR)
@riverpod
Stream<List<Expense>> expensesStream(ExpensesStreamRef ref, String apartmentId) { // <-- Şifre istedik
  return ref.watch(expenseRepositoryProvider).getAllExpenses(apartmentId);
}