import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';

class ContainerSubject extends StatelessWidget {
   ContainerSubject({super.key, required this.widget});
final  Widget widget;
  @override
  Widget build(BuildContext context) {
    return  Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.02),
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                boxShadow: [
                                 BoxShadow(
                                  color:Colors.black.withOpacity(0.1),
                                  spreadRadius : 2,
                                  blurRadius: 6,
                                   offset :Offset(2,2)
                                 )
                                ],
                                  color: whitegreen,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  border: Border.all(color: Lightgreen)),
                          child: widget,
                            ));
  }
}