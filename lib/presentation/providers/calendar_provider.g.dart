// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$monthCalendarHash() => r'64c0e2af5f2ce45ad6abbe68ff42612b7844abd9';

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

/// See also [monthCalendar].
@ProviderFor(monthCalendar)
const monthCalendarProvider = MonthCalendarFamily();

/// See also [monthCalendar].
class MonthCalendarFamily extends Family<AsyncValue<List<CalendarDayState>>> {
  /// See also [monthCalendar].
  const MonthCalendarFamily();

  /// See also [monthCalendar].
  MonthCalendarProvider call(DateTime month) {
    return MonthCalendarProvider(month);
  }

  @override
  MonthCalendarProvider getProviderOverride(
    covariant MonthCalendarProvider provider,
  ) {
    return call(provider.month);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'monthCalendarProvider';
}

/// See also [monthCalendar].
class MonthCalendarProvider
    extends AutoDisposeFutureProvider<List<CalendarDayState>> {
  /// See also [monthCalendar].
  MonthCalendarProvider(DateTime month)
    : this._internal(
        (ref) => monthCalendar(ref as MonthCalendarRef, month),
        from: monthCalendarProvider,
        name: r'monthCalendarProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$monthCalendarHash,
        dependencies: MonthCalendarFamily._dependencies,
        allTransitiveDependencies:
            MonthCalendarFamily._allTransitiveDependencies,
        month: month,
      );

  MonthCalendarProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.month,
  }) : super.internal();

  final DateTime month;

  @override
  Override overrideWith(
    FutureOr<List<CalendarDayState>> Function(MonthCalendarRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MonthCalendarProvider._internal(
        (ref) => create(ref as MonthCalendarRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        month: month,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CalendarDayState>> createElement() {
    return _MonthCalendarProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MonthCalendarProvider && other.month == month;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, month.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MonthCalendarRef on AutoDisposeFutureProviderRef<List<CalendarDayState>> {
  /// The parameter `month` of this provider.
  DateTime get month;
}

class _MonthCalendarProviderElement
    extends AutoDisposeFutureProviderElement<List<CalendarDayState>>
    with MonthCalendarRef {
  _MonthCalendarProviderElement(super.provider);

  @override
  DateTime get month => (origin as MonthCalendarProvider).month;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
