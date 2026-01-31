// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$attendanceControllerHash() =>
    r'eee0effe9ed1716e55078b67f26110a04c93d786';

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

abstract class _$AttendanceController
    extends BuildlessAutoDisposeAsyncNotifier<Map<int, AttendanceLog>> {
  late final int dateEpoch;

  FutureOr<Map<int, AttendanceLog>> build(int dateEpoch);
}

/// See also [AttendanceController].
@ProviderFor(AttendanceController)
const attendanceControllerProvider = AttendanceControllerFamily();

/// See also [AttendanceController].
class AttendanceControllerFamily
    extends Family<AsyncValue<Map<int, AttendanceLog>>> {
  /// See also [AttendanceController].
  const AttendanceControllerFamily();

  /// See also [AttendanceController].
  AttendanceControllerProvider call(int dateEpoch) {
    return AttendanceControllerProvider(dateEpoch);
  }

  @override
  AttendanceControllerProvider getProviderOverride(
    covariant AttendanceControllerProvider provider,
  ) {
    return call(provider.dateEpoch);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'attendanceControllerProvider';
}

/// See also [AttendanceController].
class AttendanceControllerProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          AttendanceController,
          Map<int, AttendanceLog>
        > {
  /// See also [AttendanceController].
  AttendanceControllerProvider(int dateEpoch)
    : this._internal(
        () => AttendanceController()..dateEpoch = dateEpoch,
        from: attendanceControllerProvider,
        name: r'attendanceControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$attendanceControllerHash,
        dependencies: AttendanceControllerFamily._dependencies,
        allTransitiveDependencies:
            AttendanceControllerFamily._allTransitiveDependencies,
        dateEpoch: dateEpoch,
      );

  AttendanceControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dateEpoch,
  }) : super.internal();

  final int dateEpoch;

  @override
  FutureOr<Map<int, AttendanceLog>> runNotifierBuild(
    covariant AttendanceController notifier,
  ) {
    return notifier.build(dateEpoch);
  }

  @override
  Override overrideWith(AttendanceController Function() create) {
    return ProviderOverride(
      origin: this,
      override: AttendanceControllerProvider._internal(
        () => create()..dateEpoch = dateEpoch,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        dateEpoch: dateEpoch,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    AttendanceController,
    Map<int, AttendanceLog>
  >
  createElement() {
    return _AttendanceControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AttendanceControllerProvider &&
        other.dateEpoch == dateEpoch;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dateEpoch.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AttendanceControllerRef
    on AutoDisposeAsyncNotifierProviderRef<Map<int, AttendanceLog>> {
  /// The parameter `dateEpoch` of this provider.
  int get dateEpoch;
}

class _AttendanceControllerProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          AttendanceController,
          Map<int, AttendanceLog>
        >
    with AttendanceControllerRef {
  _AttendanceControllerProviderElement(super.provider);

  @override
  int get dateEpoch => (origin as AttendanceControllerProvider).dateEpoch;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
