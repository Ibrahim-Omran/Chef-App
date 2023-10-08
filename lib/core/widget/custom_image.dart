import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.imgPath,
    this.height,
    this.width,
    this.fit = BoxFit.fill,
  });

  final String imgPath;
  final double? height;
  final double? width;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imgPath,
      height: height,
      width: width,
      fit: fit,
    );
  }
}
