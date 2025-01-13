import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';


class UseableGreenContainer extends StatelessWidget {
  const UseableGreenContainer({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      child: Container(
        // width:
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
            color: green, borderRadius: BorderRadius.circular(10)),

        child: Center(
            child: Text(
          text,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
        )),
      ),
    );
  }
}
