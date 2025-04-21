/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/accountenq.png
  AssetGenImage get accountenq =>
      const AssetGenImage('assets/images/accountenq.png');

  /// File path: assets/images/bag.png
  AssetGenImage get bag => const AssetGenImage('assets/images/bag.png');

  /// File path: assets/images/bgbill.png
  AssetGenImage get bgbill => const AssetGenImage('assets/images/bgbill.png');

  /// File path: assets/images/bgbottomcurved.png
  AssetGenImage get bgbottomcurved =>
      const AssetGenImage('assets/images/bgbottomcurved.png');

  /// File path: assets/images/bgelectric.png
  AssetGenImage get bgelectric =>
      const AssetGenImage('assets/images/bgelectric.png');

  /// File path: assets/images/billpay.png
  AssetGenImage get billpay => const AssetGenImage('assets/images/billpay.png');

  /// File path: assets/images/integra.png
  AssetGenImage get integra => const AssetGenImage('assets/images/integra.png');

  /// File path: assets/images/kescobill.png
  AssetGenImage get kescobill =>
      const AssetGenImage('assets/images/kescobill.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/mini.png
  AssetGenImage get mini => const AssetGenImage('assets/images/mini.png');

  /// File path: assets/images/otplogo.png
  AssetGenImage get otplogo => const AssetGenImage('assets/images/otplogo.png');

  /// File path: assets/images/transaction.png
  AssetGenImage get transaction =>
      const AssetGenImage('assets/images/transaction.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        accountenq,
        bag,
        bgbill,
        bgbottomcurved,
        bgelectric,
        billpay,
        integra,
        kescobill,
        logo,
        mini,
        otplogo,
        transaction
      ];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/en.json
  String get en => 'assets/translations/en.json';

  /// File path: assets/translations/hi.json.dart
  String get hiJson => 'assets/translations/hi.json.dart';

  /// List of all assets
  List<String> get values => [en, hiJson];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

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
