import 'package:flutter/material.dart';

import '../resourses/colors_manager.dart';

class InteractiveImage extends StatelessWidget {
  const InteractiveImage({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          border: Border.all(color: green, width: 3)),
      child: InteractiveViewer(
          minScale: .1,
          maxScale: 5,
          child: Image.network(
            image,
            fit: BoxFit.contain,
          )),
    );
  }
}
