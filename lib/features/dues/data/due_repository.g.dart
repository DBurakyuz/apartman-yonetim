// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'due_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dueRepositoryHash() => r'71eb68b31bd11e8ed520d123f3bd6808b7b2dde1';

/// See also [dueRepository].
@ProviderFor(dueRepository)
final dueRepositoryProvider = AutoDisposeProvider<DueRepository>.internal(
  dueRepository,
  name: r'dueRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dueRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DueRepositoryRef = AutoDisposeProviderRef<DueRepository>;
String _$userDuesStreamHash() => r'4c82245ab68b70dc3e377f87dc39551777c7222a';

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

/// See also [userDuesStream].
@ProviderFor(userDuesStream)
const userDuesStreamProvider = UserDuesStreamFamily();

/// See also [userDuesStream].
class UserDuesStreamFamily extends Family<AsyncValue<List<Due>>> {
  /// See also [userDuesStream].
  const UserDuesStreamFamily();

  /// See also [userDuesStream].
  UserDuesStreamProvider call(String residentId) {
    return UserDuesStreamProvider(residentId);
  }

  @override
  UserDuesStreamProvider getProviderOverride(
    covariant UserDuesStreamProvider provider,
  ) {
    return call(provider.residentId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userDuesStreamProvider';
}

/// See also [userDuesStream].
class UserDuesStreamProvider extends AutoDisposeStreamProvider<List<Due>> {
  /// See also [userDuesStream].
  UserDuesStreamProvider(String residentId)
    : this._internal(
        (ref) => userDuesStream(ref as UserDuesStreamRef, residentId),
        from: userDuesStreamProvider,
        name: r'userDuesStreamProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userDuesStreamHash,
        dependencies: UserDuesStreamFamily._dependencies,
        allTransitiveDependencies:
            UserDuesStreamFamily._allTransitiveDependencies,
        residentId: residentId,
      );

  UserDuesStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.residentId,
  }) : super.internal();

  final String residentId;

  @override
  Override overrideWith(
    Stream<List<Due>> Function(UserDuesStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserDuesStreamProvider._internal(
        (ref) => create(ref as UserDuesStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        residentId: residentId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Due>> createElement() {
    return _UserDuesStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserDuesStreamProvider && other.residentId == residentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, residentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserDuesStreamRef on AutoDisposeStreamProviderRef<List<Due>> {
  /// The parameter `residentId` of this provider.
  String get residentId;
}

class _UserDuesStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<Due>>
    with UserDuesStreamRef {
  _UserDuesStreamProviderElement(super.provider);

  @override
  String get residentId => (origin as UserDuesStreamProvider).residentId;
}

String _$allDuesStreamHash() => r'fc2b471621d89c16b0e490d24d2e62c165963cea';

/// See also [allDuesStream].
@ProviderFor(allDuesStream)
const allDuesStreamProvider = AllDuesStreamFamily();

/// See also [allDuesStream].
class AllDuesStreamFamily extends Family<AsyncValue<List<Due>>> {
  /// See also [allDuesStream].
  const AllDuesStreamFamily();

  /// See also [allDuesStream].
  AllDuesStreamProvider call(String apartmentId) {
    return AllDuesStreamProvider(apartmentId);
  }

  @override
  AllDuesStreamProvider getProviderOverride(
    covariant AllDuesStreamProvider provider,
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
  String? get name => r'allDuesStreamProvider';
}

/// See also [allDuesStream].
class AllDuesStreamProvider extends AutoDisposeStreamProvider<List<Due>> {
  /// See also [allDuesStream].
  AllDuesStreamProvider(String apartmentId)
    : this._internal(
        (ref) => allDuesStream(ref as AllDuesStreamRef, apartmentId),
        from: allDuesStreamProvider,
        name: r'allDuesStreamProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$allDuesStreamHash,
        dependencies: AllDuesStreamFamily._dependencies,
        allTransitiveDependencies:
            AllDuesStreamFamily._allTransitiveDependencies,
        apartmentId: apartmentId,
      );

  AllDuesStreamProvider._internal(
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
    Stream<List<Due>> Function(AllDuesStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AllDuesStreamProvider._internal(
        (ref) => create(ref as AllDuesStreamRef),
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
  AutoDisposeStreamProviderElement<List<Due>> createElement() {
    return _AllDuesStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AllDuesStreamProvider && other.apartmentId == apartmentId;
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
mixin AllDuesStreamRef on AutoDisposeStreamProviderRef<List<Due>> {
  /// The parameter `apartmentId` of this provider.
  String get apartmentId;
}

class _AllDuesStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<Due>>
    with AllDuesStreamRef {
  _AllDuesStreamProviderElement(super.provider);

  @override
  String get apartmentId => (origin as AllDuesStreamProvider).apartmentId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
