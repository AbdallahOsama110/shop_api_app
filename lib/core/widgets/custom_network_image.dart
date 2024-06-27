import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../utils/consts.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      errorWidget: (context, url, error) => Container(
        color: Colors.white,
        child: const Icon(
          Icons.error,
          size: 30,
          color: scaffoldBackgroundColorDark,
        ),
      ),
    );
  }
}
