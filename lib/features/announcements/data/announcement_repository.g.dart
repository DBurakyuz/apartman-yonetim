// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$announcementRepositoryHash() =>
    r'7202c606fa537b59608b3710a327064a8d3e7620';

/// See also [announcementRepository].
@ProviderFor(announcementRepository)
final announcementRepositoryProvider =
    AutoDisposeProvider<AnnouncementRepository>.internal(
      announcementRepository,
      name: r'announcementRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$announcementRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AnnouncementRepositoryRef =
    AutoDisposeProviderRef<AnnouncementRepository>;
String _$announcementsStreamHash() =>
    r'9c7db5e44b441a0c36a0d96d7af2632fb63867a0';

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

/// See also [announcementsStream].
@ProviderFor(announcementsStream)
const announcementsStreamProvider = AnnouncementsStreamFamily();

/// See also [announcementsStream].
class AnnouncementsStreamFamily extends Family<AsyncValue<List<Announcement>>> {
  /// See also [announcementsStream].
  const AnnouncementsStreamFamily();

  /// See also [announcementsStream].
  AnnouncementsStreamProvider call(String apartmentId) {
    return AnnouncementsStreamProvider(apartmentId);
  }

  @override
  AnnouncementsStreamProvider getProviderOverride(
    covariant AnnouncementsStreamProvider provider,
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
  String? get name => r'announcementsStreamProvider';
}

/// See also [announcementsStream].
class AnnouncementsStreamProvider
    extends AutoDisposeStreamProvider<List<Announcement>> {
  /// See also [announcementsStream].
  AnnouncementsStreamProvider(String apartmentId)
    : this._internal(
        (ref) =>
            announcementsStream(ref as AnnouncementsStreamRef, apartmentId),
        from: announcementsStreamProvider,
        name: r'announcementsStreamProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$announcementsStreamHash,
        dependencies: AnnouncementsStreamFamily._dependencies,
        allTransitiveDependencies:
            AnnouncementsStreamFamily._allTransitiveDependencies,
        apartmentId: apartmentId,
      );

  AnnouncementsStreamProvider._internal(
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
    Stream<List<Announcement>> Function(AnnouncementsStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AnnouncementsStreamProvider._internal(
        (ref) => create(ref as AnnouncementsStreamRef),
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
  AutoDisposeStreamProviderElement<List<Announcement>> createElement() {
    return _AnnouncementsStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AnnouncementsStreamProvider &&
        other.apartmentId == apartmentId;
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
mixin AnnouncementsStreamRef
    on AutoDisposeStreamProviderRef<List<Announcement>> {
  /// The parameter `apartmentId` of this provider.
  String get apartmentId;
}

class _AnnouncementsStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<Announcement>>
    with AnnouncementsStreamRef {
  _AnnouncementsStreamProviderElement(super.provider);

  @override
  String get apartmentId => (origin as AnnouncementsStreamProvider).apartmentId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
