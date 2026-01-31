// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seed_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$seedDatabaseHash() => r'583865d97885384e0463cdc82c399d12ce6357c7';

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

/// See also [seedDatabase].
@ProviderFor(seedDatabase)
const seedDatabaseProvider = SeedDatabaseFamily();

/// See also [seedDatabase].
class SeedDatabaseFamily extends Family<AsyncValue<void>> {
  /// See also [seedDatabase].
  const SeedDatabaseFamily();

  /// See also [seedDatabase].
  SeedDatabaseProvider call(int semesterId) {
    return SeedDatabaseProvider(semesterId);
  }

  @override
  SeedDatabaseProvider getProviderOverride(
    covariant SeedDatabaseProvider provider,
  ) {
    return call(provider.semesterId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'seedDatabaseProvider';
}

/// See also [seedDatabase].
class SeedDatabaseProvider extends AutoDisposeFutureProvider<void> {
  /// See also [seedDatabase].
  SeedDatabaseProvider(int semesterId)
    : this._internal(
        (ref) => seedDatabase(ref as SeedDatabaseRef, semesterId),
        from: seedDatabaseProvider,
        name: r'seedDatabaseProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$seedDatabaseHash,
        dependencies: SeedDatabaseFamily._dependencies,
        allTransitiveDependencies:
            SeedDatabaseFamily._allTransitiveDependencies,
        semesterId: semesterId,
      );

  SeedDatabaseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.semesterId,
  }) : super.internal();

  final int semesterId;

  @override
  Override overrideWith(
    FutureOr<void> Function(SeedDatabaseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SeedDatabaseProvider._internal(
        (ref) => create(ref as SeedDatabaseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        semesterId: semesterId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _SeedDatabaseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SeedDatabaseProvider && other.semesterId == semesterId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, semesterId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SeedDatabaseRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `semesterId` of this provider.
  int get semesterId;
}

class _SeedDatabaseProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with SeedDatabaseRef {
  _SeedDatabaseProviderElement(super.provider);

  @override
  int get semesterId => (origin as SeedDatabaseProvider).semesterId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
