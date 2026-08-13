import 'package:freezed_annotation/freezed_annotation.dart';

// Freezed ve JSON ajanlarının birazdan bizim için üreteceği gizli dosyalar
part 'expense.freezed.dart';
part 'expense.g.dart';

@freezed
class Expense with _$Expense {
  const factory Expense({
    required String id,          // Harcamanın benzersiz kimliği
    required String title,       // Neye para harcadık? (Örn: Asansör Bakımı)
    required double amount,      // Ne kadar harcadık? (Örn: 2500.0)
    required DateTime createdAt, // Ne zaman harcadık?
     required String apartmentId,
  }) = _Expense;

  // Firebase'den gelen karmaşık JSON verisini bu şık modele çeviren motor
  factory Expense.fromJson(Map<String, dynamic> json) => _$ExpenseFromJson(json);
}