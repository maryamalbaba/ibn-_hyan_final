// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnhyanfinal/feature/Failed/Error.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/send_answer_for_subject/data/Model/answer.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/send_answer_for_subject/presenture/view/bloc/send_answer_bloc.dart';

class SendAnswerUI extends StatelessWidget {
  const SendAnswerUI({
    Key? key,
    //  this.onTap,
    required this.itemcount,
    required this.list,
    required this.result_Id,
    required this.timer,
  }) : super(key: key);
  //  VoidCallback? onTap;
  final Timer timer;
  final int? itemcount;
  final List<SentAnswerModel?> list;
  final num result_Id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SendAnswerBloc(),
      child: BlocBuilder<SendAnswerBloc, SendAnswerState>(
        builder: (context, state) {
          return Scaffold(
            body: Column(
              children: [
                BlocListener<SendAnswerBloc, SendAnswerState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is SendAnswerSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("success sending")));
                        Navigator.of(context).pushNamed( "/ResultExamUI",
                          arguments: result_Id);
                    } else {
                      print("error in sendig list $list");
                    }
                  },
                  child: ElevatedButton(
                      onPressed: () {
                        timer.cancel();
                        context
                            .read<SendAnswerBloc>()
                            .add(SendAnswer(list.nonNulls.toList()));
                      },
                      child: const Text("تسليم الاختبار")),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: itemcount,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(list[index]?.answer_text ?? ""),
                          leading: Text(list[index]?.answer_tarqem ?? "----"),
                          trailing: Text(index.toString()),
                        );
                      }),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
