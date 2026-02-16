// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_classes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$classesForDateHash() => r'4af11a3e76cc418323b37d929cd8bde4a0ca3583';

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

/// See also [classesForDate].
@ProviderFor(classesForDate)
const classesForDateProvider = ClassesForDateFamily();

/// See also [classesForDate].
class ClassesForDateFamily extends Family<AsyncValue<List<TimetableSlot>>> {
  /// See also [classesForDate].
  const ClassesForDateFamily();

  /// See also [classesForDate].
  ClassesForDateProvider call(int dateEpoch) {
    return ClassesForDateProvider(dateEpoch);
  }

  @override
  ClassesForDateProvider getProviderOverride(
    covariant ClassesForDateProvider provider,
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
  String? get name => r'classesForDateProvider';
}

/// See also [classesForDate].
class ClassesForDateProvider
    extends AutoDisposeFutureProvider<List<TimetableSlot>> {
  /// See also [classesForDate].
  ClassesForDateProvider(int dateEpoch)
    : this._internal(
        (ref) => classesForDate(ref as ClassesForDateRef, dateEpoch),
        from: classesForDateProvider,
        name: r'classesForDateProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$classesForDateHash,
        dependencies: ClassesForDateFamily._dependencies,
        allTransitiveDependencies:
            ClassesForDateFamily._allTransitiveDependencies,
        dateEpoch: dateEpoch,
      );

  ClassesForDateProvider._internal(
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
  Override overrideWith(
    FutureOr<List<TimetableSlot>> Function(ClassesForDateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ClassesForDateProvider._internal(
        (ref) => create(ref as ClassesForDateRef),
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
  AutoDisposeFutureProviderElement<List<TimetableSlot>> createElement() {
    return _ClassesForDateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ClassesForDateProvider && other.dateEpoch == dateEpoch;
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
mixin ClassesForDateRef on AutoDisposeFutureProviderRef<List<TimetableSlot>> {
  /// The parameter `dateEpoch` of this provider.
  int get dateEpoch;
}

class _ClassesForDateProviderElement
    extends AutoDisposeFutureProviderElement<List<TimetableSlot>>
    with ClassesForDateRef {
  _ClassesForDateProviderElement(super.provider);

  @override
  int get dateEpoch => (origin as ClassesForDateProvider).dateEpoch;
}

String _$todayClassesHash() => r'e2f90f20f454e18c7368d291192ca8cb50028002';

/// See also [todayClasses].
@ProviderFor(todayClasses)
final todayClassesProvider =
    AutoDisposeFutureProvider<List<TimetableSlot>>.internal(
      todayClasses,
      name: r'todayClassesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$todayClassesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodayClassesRef = AutoDisposeFutureProviderRef<List<TimetableSlot>>;
String _$academicDayForDateHash() =>
    r'58ae0e60c14bd7783a7ad87237de81d4f9022707';

/// Provider to get the AcademicDay for a given date epoch.
/// Uses the same lazy generation + DayOrderCalculator logic as classesForDate.
/// This is used by DayCard on the home screen so it refreshes via Riverpod invalidation.
///
/// Copied from [academicDayForDate].
@ProviderFor(academicDayForDate)
const academicDayForDateProvider = AcademicDayForDateFamily();

/// Provider to get the AcademicDay for a given date epoch.
/// Uses the same lazy generation + DayOrderCalculator logic as classesForDate.
/// This is used by DayCard on the home screen so it refreshes via Riverpod invalidation.
///
/// Copied from [academicDayForDate].
class AcademicDayForDateFamily extends Family<AsyncValue<AcademicDay?>> {
  /// Provider to get the AcademicDay for a given date epoch.
  /// Uses the same lazy generation + DayOrderCalculator logic as classesForDate.
  /// This is used by DayCard on the home screen so it refreshes via Riverpod invalidation.
  ///
  /// Copied from [academicDayForDate].
  const AcademicDayForDateFamily();

  /// Provider to get the AcademicDay for a given date epoch.
  /// Uses the same lazy generation + DayOrderCalculator logic as classesForDate.
  /// This is used by DayCard on the home screen so it refreshes via Riverpod invalidation.
  ///
  /// Copied from [academicDayForDate].
  AcademicDayForDateProvider call(int dateEpoch) {
    return AcademicDayForDateProvider(dateEpoch);
  }

  @override
  AcademicDayForDateProvider getProviderOverride(
    covariant AcademicDayForDateProvider provider,
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
  String? get name => r'academicDayForDateProvider';
}

/// Provider to get the AcademicDay for a given date epoch.
/// Uses the same lazy generation + DayOrderCalculator logic as classesForDate.
/// This is used by DayCard on the home screen so it refreshes via Riverpod invalidation.
///
/// Copied from [academicDayForDate].
class AcademicDayForDateProvider
    extends AutoDisposeFutureProvider<AcademicDay?> {
  /// Provider to get the AcademicDay for a given date epoch.
  /// Uses the same lazy generation + DayOrderCalculator logic as classesForDate.
  /// This is used by DayCard on the home screen so it refreshes via Riverpod invalidation.
  ///
  /// Copied from [academicDayForDate].
  AcademicDayForDateProvider(int dateEpoch)
    : this._internal(
        (ref) => academicDayForDate(ref as AcademicDayForDateRef, dateEpoch),
        from: academicDayForDateProvider,
        name: r'academicDayForDateProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$academicDayForDateHash,
        dependencies: AcademicDayForDateFamily._dependencies,
        allTransitiveDependencies:
            AcademicDayForDateFamily._allTransitiveDependencies,
        dateEpoch: dateEpoch,
      );

  AcademicDayForDateProvider._internal(
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
  Override overrideWith(
    FutureOr<AcademicDay?> Function(AcademicDayForDateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AcademicDayForDateProvider._internal(
        (ref) => create(ref as AcademicDayForDateRef),
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
  AutoDisposeFutureProviderElement<AcademicDay?> createElement() {
    return _AcademicDayForDateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AcademicDayForDateProvider && other.dateEpoch == dateEpoch;
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
mixin AcademicDayForDateRef on AutoDisposeFutureProviderRef<AcademicDay?> {
  /// The parameter `dateEpoch` of this provider.
  int get dateEpoch;
}

class _AcademicDayForDateProviderElement
    extends AutoDisposeFutureProviderElement<AcademicDay?>
    with AcademicDayForDateRef {
  _AcademicDayForDateProviderElement(super.provider);

  @override
  int get dateEpoch => (origin as AcademicDayForDateProvider).dateEpoch;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
