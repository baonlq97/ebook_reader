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

String _$insertIntoDBHash() => r'910c3a73adb76a7c165205105c75c8119bc4ea00';

/// See also [insertIntoDB].
@ProviderFor(insertIntoDB)
final insertIntoDBProvider = AutoDisposeProvider<void>.internal(
  insertIntoDB,
  name: r'insertIntoDBProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$insertIntoDBHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef InsertIntoDBRef = AutoDisposeProviderRef<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
