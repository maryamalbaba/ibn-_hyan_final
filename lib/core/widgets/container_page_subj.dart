import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';

class ContainerSubject extends StatelessWidget {
  const ContainerSubject({super.key, required this.widget, this.height = 130});
  final Widget widget;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 6,
                offset: const Offset(2, 2))
          ],
          color: whitegreen,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              8,
            ),
          ),
          border: Border.all(color: Lightgreen),
        ),
        child: widget,
      ),
    );
  }
}
