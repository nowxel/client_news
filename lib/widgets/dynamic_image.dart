import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:transparent_image/transparent_image.dart';

import 'empty_page.dart';

class DynamicImage extends StatefulWidget {
  final bool? withPinchZoom;
  final File? file;
  final String? imagePath;
  final String? imageUrl;
  final String? assetFolder;
  final Widget? customErrorWidget;
  final double? borderRadius;
  final double? height;
  final double? width;
  final BoxFit? boxFit;

  const DynamicImage({Key? key,
    this.imagePath,
    this.height,
    this.width,
    this.assetFolder,
    this.customErrorWidget,
    this.borderRadius,
    this.file,
    this.withPinchZoom,
    this.imageUrl,
    this.boxFit})
      : assert (imagePath != null && imageUrl == null ||
      imageUrl != null && imagePath == null, "Assert issue: imagePath and imageUrl were declared together");

  @override
  State<DynamicImage> createState() => _DynamicImageState();
}

class _DynamicImageState extends State<DynamicImage> {
  // late Image _image;
  late final _image;

  BorderRadius get _borderRadius => BorderRadius.circular(widget.borderRadius ?? 10);

  Widget get _errorWidget {
    if (widget.customErrorWidget == null) {
      return EmptyPage(text: "No image provided");
    }
    return widget.customErrorWidget!;
  }

  @override
  void initState() {
    if(widget.imagePath != null) {
      _image = Image.asset("${widget.assetFolder}${widget.imagePath}");
    } else if(widget.imageUrl != null) {
      _image = Image.network(widget.imageUrl!);
    } else if(widget.file != null) {
      _image = ClipRRect(
        borderRadius: _borderRadius,
        child: FadeInImage(
          image: Image.file(widget.file!).image,
          fit: BoxFit.fill,
          placeholder: MemoryImage(kTransparentImage),
        ),
      );
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(_image.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return PinchZoom(
        zoomEnabled: widget.withPinchZoom == null ? false : true,
        zoomedBackgroundColor: Colors.transparent,
        image: ClipRRect(
          borderRadius: _borderRadius,
          child: FadeInImage(
            fit: widget.boxFit ?? BoxFit.cover,
            height: widget.height,
            width: widget.width,
            placeholder: MemoryImage(kTransparentImage),
            imageErrorBuilder: (context, url, error) =>
                Image.asset('${widget.assetFolder}${widget.imagePath}', errorBuilder: (_, __, ___) {
                  return _errorWidget;
                }, fit: BoxFit.cover),
            image: _image.image,
          ),
        ));
  }
}