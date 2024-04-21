// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'window.p.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$totalTabsHash() => r'b376488700d6332e076b37b3447a7a12a71ec62e';

/// See also [TotalTabs].
@ProviderFor(TotalTabs)
final totalTabsProvider = AutoDisposeNotifierProvider<TotalTabs, int>.internal(
  TotalTabs.new,
  name: r'totalTabsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$totalTabsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TotalTabs = AutoDisposeNotifier<int>;
String _$winSizeHash() => r'dc4d7a6f5dfc4c7119f3f563ce5f7d8fd3ae216b';

/// See also [WinSize].
@ProviderFor(WinSize)
final winSizeProvider =
    AutoDisposeAsyncNotifierProvider<WinSize, Size>.internal(
  WinSize.new,
  name: r'winSizeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$winSizeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WinSize = AutoDisposeAsyncNotifier<Size>;
String _$tabSizeHash() => r'8a12a1e425c8f238d69d3c6ad8ad25a11f6bc90e';

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

abstract class _$TabSize extends BuildlessAutoDisposeAsyncNotifier<Size> {
  late final int i;

  FutureOr<Size> build(
    int i,
  );
}

/// See also [TabSize].
@ProviderFor(TabSize)
const tabSizeProvider = TabSizeFamily();

/// See also [TabSize].
class TabSizeFamily extends Family<AsyncValue<Size>> {
  /// See also [TabSize].
  const TabSizeFamily();

  /// See also [TabSize].
  TabSizeProvider call(
    int i,
  ) {
    return TabSizeProvider(
      i,
    );
  }

  @override
  TabSizeProvider getProviderOverride(
    covariant TabSizeProvider provider,
  ) {
    return call(
      provider.i,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'tabSizeProvider';
}

/// See also [TabSize].
class TabSizeProvider
    extends AutoDisposeAsyncNotifierProviderImpl<TabSize, Size> {
  /// See also [TabSize].
  TabSizeProvider(
    int i,
  ) : this._internal(
          () => TabSize()..i = i,
          from: tabSizeProvider,
          name: r'tabSizeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tabSizeHash,
          dependencies: TabSizeFamily._dependencies,
          allTransitiveDependencies: TabSizeFamily._allTransitiveDependencies,
          i: i,
        );

  TabSizeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.i,
  }) : super.internal();

  final int i;

  @override
  FutureOr<Size> runNotifierBuild(
    covariant TabSize notifier,
  ) {
    return notifier.build(
      i,
    );
  }

  @override
  Override overrideWith(TabSize Function() create) {
    return ProviderOverride(
      origin: this,
      override: TabSizeProvider._internal(
        () => create()..i = i,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        i: i,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<TabSize, Size> createElement() {
    return _TabSizeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TabSizeProvider && other.i == i;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, i.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TabSizeRef on AutoDisposeAsyncNotifierProviderRef<Size> {
  /// The parameter `i` of this provider.
  int get i;
}

class _TabSizeProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TabSize, Size>
    with TabSizeRef {
  _TabSizeProviderElement(super.provider);

  @override
  int get i => (origin as TabSizeProvider).i;
}

String _$separatorPositionHash() => r'a97a0b99290670e0f6b0e0b8c0b354efddbffe75';

abstract class _$SeparatorPosition
    extends BuildlessAutoDisposeNotifier<double?> {
  late final int i;

  double? build(
    int i,
  );
}

/// See also [SeparatorPosition].
@ProviderFor(SeparatorPosition)
const separatorPositionProvider = SeparatorPositionFamily();

/// See also [SeparatorPosition].
class SeparatorPositionFamily extends Family<double?> {
  /// See also [SeparatorPosition].
  const SeparatorPositionFamily();

  /// See also [SeparatorPosition].
  SeparatorPositionProvider call(
    int i,
  ) {
    return SeparatorPositionProvider(
      i,
    );
  }

  @override
  SeparatorPositionProvider getProviderOverride(
    covariant SeparatorPositionProvider provider,
  ) {
    return call(
      provider.i,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'separatorPositionProvider';
}

/// See also [SeparatorPosition].
class SeparatorPositionProvider
    extends AutoDisposeNotifierProviderImpl<SeparatorPosition, double?> {
  /// See also [SeparatorPosition].
  SeparatorPositionProvider(
    int i,
  ) : this._internal(
          () => SeparatorPosition()..i = i,
          from: separatorPositionProvider,
          name: r'separatorPositionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$separatorPositionHash,
          dependencies: SeparatorPositionFamily._dependencies,
          allTransitiveDependencies:
              SeparatorPositionFamily._allTransitiveDependencies,
          i: i,
        );

  SeparatorPositionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.i,
  }) : super.internal();

  final int i;

  @override
  double? runNotifierBuild(
    covariant SeparatorPosition notifier,
  ) {
    return notifier.build(
      i,
    );
  }

  @override
  Override overrideWith(SeparatorPosition Function() create) {
    return ProviderOverride(
      origin: this,
      override: SeparatorPositionProvider._internal(
        () => create()..i = i,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        i: i,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<SeparatorPosition, double?>
      createElement() {
    return _SeparatorPositionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SeparatorPositionProvider && other.i == i;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, i.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SeparatorPositionRef on AutoDisposeNotifierProviderRef<double?> {
  /// The parameter `i` of this provider.
  int get i;
}

class _SeparatorPositionProviderElement
    extends AutoDisposeNotifierProviderElement<SeparatorPosition, double?>
    with SeparatorPositionRef {
  _SeparatorPositionProviderElement(super.provider);

  @override
  int get i => (origin as SeparatorPositionProvider).i;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
