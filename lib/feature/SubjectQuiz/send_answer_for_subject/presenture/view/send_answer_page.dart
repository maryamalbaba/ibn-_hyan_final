//deprecated

// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
import 'package:ibnhyanfinal/core/widgets/tex_text_widget.dart';
import 'package:ibnhyanfinal/core/widgets/useable_green_container.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/send_answer_for_subject/data/Model/answer.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/send_answer_for_subject/presenture/view/bloc/send_answer_bloc.dart';
import 'package:ibnhyanfinal/feature/marks/mark_page.dart';


///Deprecated --
class SendAnswerUI extends StatelessWidget {
  const SendAnswerUI({
    super.key,
    //  this.onTap,
    required this.itemcount,
    required this.list,
    required this.result_Id,
    required this.timer,
  });

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
          return Column(
            children: [
              Expanded(
                flex: 6,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: itemcount,
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        height: 56,
                        decoration: const BoxDecoration(
                            color: babyblue,
                            border: Border(
                                bottom: BorderSide(
                                  color: Lightgreen,
                                ),
                                top: BorderSide(
                                  color: Lightgreen,
                                ))),
                        child: Row(
                          children: [
                            SizedBox(
                                width: 30,
                                child: Center(
                                  child: Text(
                                    "   ${index + 1}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(fontSize: 13, color: darkergreen, fontWeight: FontWeight.w600),
                                  ),
                                )),
                            const verticalDivDer(),
                            SizedBox(
                              width: 30,
                                child: Center(
                                  child: Text("${list[index]?.answer_tarqem ?? ""}-",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 18),
                                      maxLines: 2),
                                )),
                            const verticalDivDer(),
                            Expanded(
                                flex: 8,
                                child: TexTextWidget(list[index]?.answer_text ?? "",
                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                                    // overflow: TextOverflow.clip, maxLines: 2.
                                )),
                          ],
                        ),
                      );
                    }),
              ),
              BlocListener<SendAnswerBloc, SendAnswerState>(
                  listener: (context, state) {
                    print(state);
                    // TODO: implement listener
                    if (state is SendAnswerSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("تم الارسال بنجاح")));
                      Navigator.of(context)
                          .pushNamed("/ResultExamUI", arguments: [result_Id, list]);
                    } else {
                      if (!list.any((element) => element == null)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("يجب الاجابة على كل الاسئلة ")));
                      }
                      print("error in sendig list $list");
                    }
                  },
                  child: InkWell(
                      onTap: () {
                        timer.cancel();
                        context
                            .read<SendAnswerBloc>()
                            .add(SendAnswer(list.nonNulls.toList()));
                      },
                      child:
                          const UseableGreenContainer(text: "تسليم الاختبار"))

                  // ElevatedButton(
                  //     onPressed: () {

                  //     },
                  //     child: const Text("تسليم الاختبار")),
                  ),
            ],
          );
        },
      ),
    );
  }
}
