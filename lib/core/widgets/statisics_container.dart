// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';

class StatisicsContainer extends StatelessWidget {
  StatisicsContainer({
    Key? key,
    required this.imageUrl,
    required this.Text_quizName,
    required this.Text_SubjectName,
    required this.totalscore,
    required this.myscore,
  }) : super(key: key);
  final String imageUrl;
  final String Text_quizName;
  final String Text_SubjectName;
  final num totalscore;
  final num myscore;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: babyblue,
          border: Border.all(color: greygreen),
          borderRadius: BorderRadius.circular(10)),
      width: MediaQuery.of(context).size.width * 0.8,
      // height: MediaQuery.of(context).size.height * 0.22,
      child: Row(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: Lottie.network(imageUrl),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.loose,
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.04,
                      bottom: MediaQuery.of(context).size.width * 0.005,
                    ),
                    child: Text(
                      Text_quizName,
                      style:
                          const TextStyle(color: green, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(Text_SubjectName,
                      style: const TextStyle(
                        color: green,
                      )),
                  Text(
                    "$totalscore/$myscore",
                    style: TextStyle(color: myscore/(totalscore==0? 1:totalscore) < .5 ? Colors.red : Colors.green),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
