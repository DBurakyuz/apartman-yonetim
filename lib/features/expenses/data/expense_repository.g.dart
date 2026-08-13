// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$expenseRepositoryHash() => r'0c0e6d8572ec7e1cd9823c9758305f21ea90efc0';

/// See also [expenseRepository].
@ProviderFor(expenseRepository)
final expenseRepositoryProvider =
    AutoDisposeProvider<ExpenseRepository>.internal(
      expenseRepository,
      name: r'expenseRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$expenseRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ExpenseRepositoryRef = AutoDisposeProviderRef<ExpenseRepository>;
String _$expensesStreamHash() => r'9bd547b954f978063a431b099e222e23e47024b0';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [expensesStream].
@ProviderFor(expensesStream)
const expensesStreamProvider = ExpensesStreamFamily();

/// See also [expensesStream].
class ExpensesStreamFamily extends Family<AsyncValue<List<Expense>>> {
  /// See also [expensesStream].
  const ExpensesStreamFamily();

  /// See also [expensesStream].
  ExpensesStreamProvider call(String apartmentId) {
    return ExpensesStreamProvider(apartmentId);
  }

  @override
  ExpensesStreamProvider getProviderOverride(
    covariant ExpensesStreamProvider provider,
  ) {
    return call(provider.apartmentId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'expensesStreamProvider';
}

/// See also [expensesStream].
class ExpensesStreamProvider extends AutoDisposeStreamProvider<List<Expense>> {
  /// See also [expensesStream].
  ExpensesStreamProvider(String apartmentId)
    : this._internal(
        (ref) => expensesStream(ref as ExpensesStreamRef, apartmentId),
        from: expensesStreamProvider,
        name: r'expensesStreamProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$expensesStreamHash,
        dependencies: ExpensesStreamFamily._dependencies,
        allTransitiveDependencies:
            ExpensesStreamFamily._allTransitiveDependencies,
        apartmentId: apartmentId,
      );

  ExpensesStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.apartmentId,
  }) : super.internal();

  final String apartmentId;

  @override
  Override overrideWith(
    Stream<List<Expense>> Function(ExpensesStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ExpensesStreamProvider._internal(
        (ref) => create(ref as ExpensesStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        apartmentId: apartmentId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Expense>> createElement() {
    return _ExpensesStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExpensesStreamProvider && other.apartmentId == apartmentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, apartmentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ExpensesStreamRef on AutoDisposeStreamProviderRef<List<Expense>> {
  /// The parameter `apartmentId` of this provider.
  String get apartmentId;
}

class _ExpensesStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<Expense>>
    with ExpensesStreamRef {
  _ExpensesStreamProviderElement(super.provider);

  @override
  String get apartmentId => (origin as ExpensesStreamProvider).apartmentId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
