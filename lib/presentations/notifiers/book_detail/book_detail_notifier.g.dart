// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getBookDetailHash() => r'8004a92160f420c5c8c9227652651ae363ae2d60';

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

/// See also [getBookDetail].
@ProviderFor(getBookDetail)
const getBookDetailProvider = GetBookDetailFamily();

/// See also [getBookDetail].
class GetBookDetailFamily extends Family<AsyncValue<BookSet?>> {
  /// See also [getBookDetail].
  const GetBookDetailFamily();

  /// See also [getBookDetail].
  GetBookDetailProvider call(
    int bookId,
  ) {
    return GetBookDetailProvider(
      bookId,
    );
  }

  @override
  GetBookDetailProvider getProviderOverride(
    covariant GetBookDetailProvider provider,
  ) {
    return call(
      provider.bookId,
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
  String? get name => r'getBookDetailProvider';
}

/// See also [getBookDetail].
class GetBookDetailProvider extends AutoDisposeFutureProvider<BookSet?> {
  /// See also [getBookDetail].
  GetBookDetailProvider(
    int bookId,
  ) : this._internal(
          (ref) => getBookDetail(
            ref as GetBookDetailRef,
            bookId,
          ),
          from: getBookDetailProvider,
          name: r'getBookDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getBookDetailHash,
          dependencies: GetBookDetailFamily._dependencies,
          allTransitiveDependencies:
              GetBookDetailFamily._allTransitiveDependencies,
          bookId: bookId,
        );

  GetBookDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.bookId,
  }) : super.internal();

  final int bookId;

  @override
  Override overrideWith(
    FutureOr<BookSet?> Function(GetBookDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetBookDetailProvider._internal(
        (ref) => create(ref as GetBookDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        bookId: bookId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<BookSet?> createElement() {
    return _GetBookDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetBookDetailProvider && other.bookId == bookId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, bookId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetBookDetailRef on AutoDisposeFutureProviderRef<BookSet?> {
  /// The parameter `bookId` of this provider.
  int get bookId;
}

class _GetBookDetailProviderElement
    extends AutoDisposeFutureProviderElement<BookSet?> with GetBookDetailRef {
  _GetBookDetailProviderElement(super.provider);

  @override
  int get bookId => (origin as GetBookDetailProvider).bookId;
}

String _$getBookByIdHash() => r'579ee5c1d5e578163f71f6bcb09d26f96535d9f0';

/// See also [getBookById].
@ProviderFor(getBookById)
const getBookByIdProvider = GetBookByIdFamily();

/// See also [getBookById].
class GetBookByIdFamily extends Family<AsyncValue<LibraryItem?>> {
  /// See also [getBookById].
  const GetBookByIdFamily();

  /// See also [getBookById].
  GetBookByIdProvider call(
    int bookId,
  ) {
    return GetBookByIdProvider(
      bookId,
    );
  }

  @override
  GetBookByIdProvider getProviderOverride(
    covariant GetBookByIdProvider provider,
  ) {
    return call(
      provider.bookId,
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
  String? get name => r'getBookByIdProvider';
}

/// See also [getBookById].
class GetBookByIdProvider extends AutoDisposeFutureProvider<LibraryItem?> {
  /// See also [getBookById].
  GetBookByIdProvider(
    int bookId,
  ) : this._internal(
          (ref) => getBookById(
            ref as GetBookByIdRef,
            bookId,
          ),
          from: getBookByIdProvider,
          name: r'getBookByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getBookByIdHash,
          dependencies: GetBookByIdFamily._dependencies,
          allTransitiveDependencies:
              GetBookByIdFamily._allTransitiveDependencies,
          bookId: bookId,
        );

  GetBookByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.bookId,
  }) : super.internal();

  final int bookId;

  @override
  Override overrideWith(
    FutureOr<LibraryItem?> Function(GetBookByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetBookByIdProvider._internal(
        (ref) => create(ref as GetBookByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        bookId: bookId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LibraryItem?> createElement() {
    return _GetBookByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetBookByIdProvider && other.bookId == bookId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, bookId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetBookByIdRef on AutoDisposeFutureProviderRef<LibraryItem?> {
  /// The parameter `bookId` of this provider.
  int get bookId;
}

class _GetBookByIdProviderElement
    extends AutoDisposeFutureProviderElement<LibraryItem?> with GetBookByIdRef {
  _GetBookByIdProviderElement(super.provider);

  @override
  int get bookId => (origin as GetBookByIdProvider).bookId;
}

String _$insertItemHash() => r'18482ac81d0bc2ea2d968aeaf16b9e294bb6d5bb';

/// See also [InsertItem].
@ProviderFor(InsertItem)
final insertItemProvider =
    AutoDisposeAsyncNotifierProvider<InsertItem, void>.internal(
  InsertItem.new,
  name: r'insertItemProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$insertItemHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$InsertItem = AutoDisposeAsyncNotifier<void>;
String _$downloadNotifierHash() => r'23ead8e64ef991ee7d01dedc461d9ec31c34a6d0';

/// See also [DownloadNotifier].
@ProviderFor(DownloadNotifier)
final downloadNotifierProvider =
    AutoDisposeNotifierProvider<DownloadNotifier, double>.internal(
  DownloadNotifier.new,
  name: r'downloadNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$downloadNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DownloadNotifier = AutoDisposeNotifier<double>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
