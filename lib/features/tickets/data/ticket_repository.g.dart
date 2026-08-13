// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ticketRepositoryHash() => r'9759c5cb720d870319539dd81cd8daa6dc09fa65';

/// See also [ticketRepository].
@ProviderFor(ticketRepository)
final ticketRepositoryProvider = AutoDisposeProvider<TicketRepository>.internal(
  ticketRepository,
  name: r'ticketRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ticketRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TicketRepositoryRef = AutoDisposeProviderRef<TicketRepository>;
String _$ticketsStreamHash() => r'75643423c3dfa3feb02408bf79b2f52e11910af3';

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

/// See also [ticketsStream].
@ProviderFor(ticketsStream)
const ticketsStreamProvider = TicketsStreamFamily();

/// See also [ticketsStream].
class TicketsStreamFamily extends Family<AsyncValue<List<Ticket>>> {
  /// See also [ticketsStream].
  const TicketsStreamFamily();

  /// See also [ticketsStream].
  TicketsStreamProvider call(String apartmentId, {String? residentId}) {
    return TicketsStreamProvider(apartmentId, residentId: residentId);
  }

  @override
  TicketsStreamProvider getProviderOverride(
    covariant TicketsStreamProvider provider,
  ) {
    return call(provider.apartmentId, residentId: provider.residentId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'ticketsStreamProvider';
}

/// See also [ticketsStream].
class TicketsStreamProvider extends AutoDisposeStreamProvider<List<Ticket>> {
  /// See also [ticketsStream].
  TicketsStreamProvider(String apartmentId, {String? residentId})
    : this._internal(
        (ref) => ticketsStream(
          ref as TicketsStreamRef,
          apartmentId,
          residentId: residentId,
        ),
        from: ticketsStreamProvider,
        name: r'ticketsStreamProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$ticketsStreamHash,
        dependencies: TicketsStreamFamily._dependencies,
        allTransitiveDependencies:
            TicketsStreamFamily._allTransitiveDependencies,
        apartmentId: apartmentId,
        residentId: residentId,
      );

  TicketsStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.apartmentId,
    required this.residentId,
  }) : super.internal();

  final String apartmentId;
  final String? residentId;

  @override
  Override overrideWith(
    Stream<List<Ticket>> Function(TicketsStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TicketsStreamProvider._internal(
        (ref) => create(ref as TicketsStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        apartmentId: apartmentId,
        residentId: residentId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Ticket>> createElement() {
    return _TicketsStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TicketsStreamProvider &&
        other.apartmentId == apartmentId &&
        other.residentId == residentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, apartmentId.hashCode);
    hash = _SystemHash.combine(hash, residentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TicketsStreamRef on AutoDisposeStreamProviderRef<List<Ticket>> {
  /// The parameter `apartmentId` of this provider.
  String get apartmentId;

  /// The parameter `residentId` of this provider.
  String? get residentId;
}

class _TicketsStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<Ticket>>
    with TicketsStreamRef {
  _TicketsStreamProviderElement(super.provider);

  @override
  String get apartmentId => (origin as TicketsStreamProvider).apartmentId;
  @override
  String? get residentId => (origin as TicketsStreamProvider).residentId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
