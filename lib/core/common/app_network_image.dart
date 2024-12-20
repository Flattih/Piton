import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piton/core/common/app_loader.dart';
import 'package:piton/core/constants/image_constants.dart';
import 'package:piton/features/home/repository/book_repository.dart';

/// It will provide to image caching and image loading from network
final class AppNetworkImage extends ConsumerWidget {
  /// The line `const CustomNetworkImage({super.key});` is defining a constructor
  /// for the `CustomNetworkImage` class.
  const AppNetworkImage(
      {super.key,
      this.fileName,
      this.emptyWidget,
      this.boxFit = BoxFit.cover,
      this.loadingWidget,
      this.margin,
      this.padding,
      this.border,
      this.borderRadius,
      this.child,
      this.boxShadow,
      this.size = const Size(double.infinity, 200)});

  ///  Image source address
  final String? fileName;

  /// When image is not available then it will show empty widget
  final Widget? emptyWidget;

  /// When image is loading then it will show loading widget
  final Widget? loadingWidget;

  /// Default value is [BoxFit.cover]
  final BoxFit boxFit;

  /// Image size
  final Size? size;

  /// Margin
  final EdgeInsetsGeometry? margin;

  /// Padding
  final EdgeInsetsGeometry? padding;

  /// Border
  final BoxBorder? border;

  /// Box shadow
  final List<BoxShadow>? boxShadow;

  /// Border radius
  final BorderRadiusGeometry? borderRadius;

  /// Child widget
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getImageOfBookProvider(fileName ?? '')).when(
      data: (imageUrl) {
        return CachedNetworkImage(
          imageBuilder: (context, imageProvider) {
            return Container(
              margin: margin,
              padding: padding,
              decoration: BoxDecoration(
                border: border,
                boxShadow: boxShadow,
                borderRadius: borderRadius ?? BorderRadius.circular(22),
                image: DecorationImage(
                  image: imageProvider,
                  fit: boxFit,
                ),
              ),
              child: child,
            );
          },
          imageUrl: imageUrl,
          fit: boxFit,
          width: size == null ? double.infinity : size?.width,
          height: size?.height,
          errorListener: (value) {
            if (kDebugMode) debugPrint('Error: $value');
          },
          progressIndicatorBuilder: (context, url, progress) {
            return loadingWidget ?? const Loader();
          },
          errorWidget: (context, url, error) {
            return emptyWidget ?? const SizedBox();
          },
        );
      },
      error: (error, stackTrace) {
        return Image.asset(
          Images.logo,
          width: 40,
        );
      },
      loading: () {
        return loadingWidget ?? const Loader();
      },
    );
  }
}
