import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';



class Useable_Green_container extends StatelessWidget {
  const Useable_Green_container({super.key, required this.text});
final String text;
  @override
  Widget build(BuildContext context) {
    return  Container(
                width: MediaQuery.of(context).size.width*0.75,
                height: 50,
                decoration: BoxDecoration(color: green,
              borderRadius: BorderRadius.circular(10)),
              
              child: Center(child: Text(text,style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,color: Colors.white),)),);
            
  }
}