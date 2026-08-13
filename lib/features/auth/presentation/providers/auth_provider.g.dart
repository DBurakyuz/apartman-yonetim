// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authStateHash() => r'5679ad46c6700b93bf3b8032631f182c8cfbad1d';

/// See also [authState].
@ProviderFor(authState)
final authStateProvider = AutoDisposeStreamProvider<User?>.internal(
  authState,
  name: r'authStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthStateRef = AutoDisposeStreamProviderRef<User?>;
String _$currentUserHash() => r'b70bdeda98843dd2e7b1f69f54f185ecbcad531d';

/// See also [currentUser].
@ProviderFor(currentUser)
final currentUserProvider = AutoDisposeStreamProvider<AppUser?>.internal(
  currentUser,
  name: r'currentUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserRef = AutoDisposeStreamProviderRef<AppUser?>;
String _$uniqueApartmentsHash() => r'52f9b14c6a7f7154ade515bf5fd57fba9287ed1a';

/// See also [uniqueApartments].
@ProviderFor(uniqueApartments)
final uniqueApartmentsProvider =
    AutoDisposeFutureProvider<List<String>>.internal(
      uniqueApartments,
      name: r'uniqueApartmentsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$uniqueApartmentsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UniqueApartmentsRef = AutoDisposeFutureProviderRef<List<String>>;
String _$activeApartmentHash() => r'e9a703e974dd1a5a12c12710529a1be4d7a897ff';

/// See also [activeApartment].
@ProviderFor(activeApartment)
final activeApartmentProvider = AutoDisposeProvider<String>.internal(
  activeApartment,
  name: r'activeApartmentProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeApartmentHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActiveApartmentRef = AutoDisposeProviderRef<String>;
String _$selectedApartmentHash() => r'7ccb45f6fec628c4ee3dc01e7ac9dcc49c318a4c';

/// See also [SelectedApartment].
@ProviderFor(SelectedApartment)
final selectedApartmentProvider =
    AutoDisposeNotifierProvider<SelectedApartment, String?>.internal(
      SelectedApartment.new,
      name: r'selectedApartmentProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$selectedApartmentHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedApartment = AutoDisposeNotifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
