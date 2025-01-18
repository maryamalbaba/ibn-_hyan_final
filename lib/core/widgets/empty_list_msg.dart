import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';

class EmptyListMsg extends StatelessWidget {
  const EmptyListMsg({super.key, this.name ="نتائج" });
  final String? name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.line_style_outlined, size: 60, color: green),
          const SizedBox(height: 40),
          Text("لا يوجد $name بعد", style: const TextStyle(fontSize: 32)),
        ],
      ),
    );
  }
}
