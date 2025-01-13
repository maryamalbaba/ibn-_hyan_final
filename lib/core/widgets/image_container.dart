import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../resourses/colors_manager.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {

    return CachedNetworkImage(
      height: 40,
      width: 40,
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) =>
          Image(image: imageProvider),
      placeholder: (context, url) =>
      const CircularProgressIndicator(
        color: green,
      ),
      errorWidget: (context, url, error) =>
      const Icon(Icons.error, color: Colors.green),
    );
  }
}
