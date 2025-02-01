import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';


class MainFilledButton extends StatelessWidget {
  const MainFilledButton({
    super.key,
    required this.onTap,
    this.color,
    this.child,
    this.text,
    this.height = 35,
    this.width = 75,
    this.borderRadius = const BorderRadius.all(Radius.circular(7)),
    this.enabled = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 15,vertical: 2),
  });
  final void Function() onTap;
  final Color? color;
  final Widget? child;
  final String? text;
  final double height;
  final double width;
  final EdgeInsets padding;
  final bool enabled;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: borderRadius,
      onTap: onTap,
      child: Material(
        borderRadius: borderRadius,
        color: Colors.transparent,
        child: Container(
          // height: height,
          // constraints: BoxConstraints(minWidth: width, maxWidth: 200),
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: enabled
                ? color ?? green
                : Colors.grey,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              child ?? Text(text ?? "", style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
