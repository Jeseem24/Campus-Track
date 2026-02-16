// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_attendance_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$monthlyAttendanceStatusHash() =>
    r'eed916bcbb49c570c53340c4fd4d9591eecc92f0';

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

/// See also [monthlyAttendanceStatus].
@ProviderFor(monthlyAttendanceStatus)
const monthlyAttendanceStatusProvider = MonthlyAttendanceStatusFamily();

/// See also [monthlyAttendanceStatus].
class MonthlyAttendanceStatusFamily
    extends Family<AsyncValue<Map<int, DayAttendanceStatus>>> {
  /// See also [monthlyAttendanceStatus].
  const MonthlyAttendanceStatusFamily();

  /// See also [monthlyAttendanceStatus].
  MonthlyAttendanceStatusProvider call(DateTime monthKey) {
    return MonthlyAttendanceStatusProvider(monthKey);
  }

  @override
  MonthlyAttendanceStatusProvider getProviderOverride(
    covariant MonthlyAttendanceStatusProvider provider,
  ) {
    return call(provider.monthKey);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'monthlyAttendanceStatusProvider';
}

/// See also [monthlyAttendanceStatus].
class MonthlyAttendanceStatusProvider
    extends AutoDisposeFutureProvider<Map<int, DayAttendanceStatus>> {
  /// See also [monthlyAttendanceStatus].
  MonthlyAttendanceStatusProvider(DateTime monthKey)
    : this._internal(
        (ref) => monthlyAttendanceStatus(
          ref as MonthlyAttendanceStatusRef,
          monthKey,
        ),
        from: monthlyAttendanceStatusProvider,
        name: r'monthlyAttendanceStatusProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$monthlyAttendanceStatusHash,
        dependencies: MonthlyAttendanceStatusFamily._dependencies,
        allTransitiveDependencies:
            MonthlyAttendanceStatusFamily._allTransitiveDependencies,
        monthKey: monthKey,
      );

  MonthlyAttendanceStatusProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.monthKey,
  }) : super.internal();

  final DateTime monthKey;

  @override
  Override overrideWith(
    FutureOr<Map<int, DayAttendanceStatus>> Function(
      MonthlyAttendanceStatusRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MonthlyAttendanceStatusProvider._internal(
        (ref) => create(ref as MonthlyAttendanceStatusRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        monthKey: monthKey,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<int, DayAttendanceStatus>>
  createElement() {
    return _MonthlyAttendanceStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MonthlyAttendanceStatusProvider &&
        other.monthKey == monthKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, monthKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MonthlyAttendanceStatusRef
    on AutoDisposeFutureProviderRef<Map<int, DayAttendanceStatus>> {
  /// The parameter `monthKey` of this provider.
  DateTime get monthKey;
}

class _MonthlyAttendanceStatusProviderElement
    extends AutoDisposeFutureProviderElement<Map<int, DayAttendanceStatus>>
    with MonthlyAttendanceStatusRef {
  _MonthlyAttendanceStatusProviderElement(super.provider);

  @override
  DateTime get monthKey => (origin as MonthlyAttendanceStatusProvider).monthKey;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
