import 'package:flutter/material.dart';

class MainOutlineButton extends StatelessWidget {
  const MainOutlineButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.color,
  });

  final void Function() onTap;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
