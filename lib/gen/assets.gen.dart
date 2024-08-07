/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsDrawableGen {
  const $AssetsDrawableGen();

  /// File path: assets/drawable/about_screen_bg.jpg
  AssetGenImage get aboutScreenBg =>
      const AssetGenImage('assets/drawable/about_screen_bg.jpg');

  /// File path: assets/drawable/book_details_bg.jpg
  AssetGenImage get bookDetailsBg =>
      const AssetGenImage('assets/drawable/book_details_bg.jpg');

  /// File path: assets/drawable/book_reader_bg.jpg
  AssetGenImage get bookReaderBg =>
      const AssetGenImage('assets/drawable/book_reader_bg.jpg');

  /// File path: assets/drawable/github_pfp.jpg
  AssetGenImage get githubPfp =>
      const AssetGenImage('assets/drawable/github_pfp.jpg');

  /// File path: assets/drawable/ic_nav_categories.svg
  String get icNavCategories => 'assets/drawable/ic_nav_categories.svg';

  /// File path: assets/drawable/ic_nav_home.svg
  String get icNavHome => 'assets/drawable/ic_nav_home.svg';

  /// File path: assets/drawable/ic_nav_library.svg
  String get icNavLibrary => 'assets/drawable/ic_nav_library.svg';

  /// File path: assets/drawable/ic_nav_settings.svg
  String get icNavSettings => 'assets/drawable/ic_nav_settings.svg';

  /// File path: assets/drawable/ic_search.svg
  String get icSearch => 'assets/drawable/ic_search.svg';

  /// File path: assets/drawable/placeholder_cat.jpeg
  AssetGenImage get placeholderCat =>
      const AssetGenImage('assets/drawable/placeholder_cat.jpeg');

  /// List of all assets
  List<dynamic> get values => [
        aboutScreenBg,
        bookDetailsBg,
        bookReaderBg,
        githubPfp,
        icNavCategories,
        icNavHome,
        icNavLibrary,
        icNavSettings,
        icSearch,
        placeholderCat
      ];
}

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/figerona_black.otf
  String get figeronaBlack => 'assets/fonts/figerona_black.otf';

  /// File path: assets/fonts/figerona_bold.otf
  String get figeronaBold => 'assets/fonts/figerona_bold.otf';

  /// File path: assets/fonts/figerona_extrabold.otf
  String get figeronaExtrabold => 'assets/fonts/figerona_extrabold.otf';

  /// File path: assets/fonts/figerona_extralight.otf
  String get figeronaExtralight => 'assets/fonts/figerona_extralight.otf';

  /// File path: assets/fonts/figerona_light.otf
  String get figeronaLight => 'assets/fonts/figerona_light.otf';

  /// File path: assets/fonts/figerona_medium.otf
  String get figeronaMedium => 'assets/fonts/figerona_medium.otf';

  /// File path: assets/fonts/figerona_regular.otf
  String get figeronaRegular => 'assets/fonts/figerona_regular.otf';

  /// File path: assets/fonts/figerona_semibold.otf
  String get figeronaSemibold => 'assets/fonts/figerona_semibold.otf';

  /// File path: assets/fonts/figerona_thin.otf
  String get figeronaThin => 'assets/fonts/figerona_thin.otf';

  /// File path: assets/fonts/pacifico_regular.ttf
  String get pacificoRegular => 'assets/fonts/pacifico_regular.ttf';

  /// List of all assets
  List<String> get values => [
        figeronaBlack,
        figeronaBold,
        figeronaExtrabold,
        figeronaExtralight,
        figeronaLight,
        figeronaMedium,
        figeronaRegular,
        figeronaSemibold,
        figeronaThin,
        pacificoRegular
      ];
}

class $AssetsRawsGen {
  const $AssetsRawsGen();

  /// File path: assets/raws/no_internet_lottie.json
  String get noInternetLottie => 'assets/raws/no_internet_lottie.json';

  /// File path: assets/raws/no_library_items_lottie.json
  String get noLibraryItemsLottie => 'assets/raws/no_library_items_lottie.json';

  /// File path: assets/raws/synopis_not_found_lottie.json
  String get synopisNotFoundLottie =>
      'assets/raws/synopis_not_found_lottie.json';

  /// File path: assets/raws/welcome_lottie.json
  String get welcomeLottie => 'assets/raws/welcome_lottie.json';

  /// List of all assets
  List<String> get values => [
        noInternetLottie,
        noLibraryItemsLottie,
        synopisNotFoundLottie,
        welcomeLottie
      ];
}

class Assets {
  Assets._();

  static const $AssetsDrawableGen drawable = $AssetsDrawableGen();
  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsRawsGen raws = $AssetsRawsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
