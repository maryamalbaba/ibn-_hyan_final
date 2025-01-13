import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';

class UseableGreenContainer extends StatelessWidget {
  const UseableGreenContainer({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical:  MediaQuery.of(context).size.width * 0.02, horizontal: 20),
      child: Container(
        // width:
        height: 60,
        decoration: BoxDecoration(
          gradient: const LinearGradient(begin: Alignment.bottomCenter,end: Alignment.topCenter, colors: [
            green,
            lighterGreen
          ]),
          borderRadius: BorderRadius.circular(10),
        ),

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
