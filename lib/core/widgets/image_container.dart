import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../resourses/colors_manager.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer(
      {super.key,
      required this.imageUrl,
      this.height,
      this.width});

  final String imageUrl;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Image(image: imageProvider),
      placeholder: (context, url) => const CircularProgressIndicator(
        color: green,
      ),
      errorWidget: (context, url, error) =>
          Container(color: greygreen, child: const Center(child: Icon(Icons.error, color: Colors.green))),
    );
  }
}
