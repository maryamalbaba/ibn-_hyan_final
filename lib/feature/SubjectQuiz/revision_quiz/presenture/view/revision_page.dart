import 'dart:async';
import 'dart:math';

import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
import 'package:ibnhyanfinal/feature/Failed/Error.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/data/model/answer_model.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/data/model/problem.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/data/model/question_model.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/data/model/response_quiz.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/presenture/bloc/bloc/subject_question_bloc.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/revision_quiz/data/Models/full_res_revivion.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/revision_quiz/presenture/bloc/fullrevision_bloc.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/send_answer_for_subject/data/Model/answer.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/send_answer_for_subject/presenture/view/send_answer_page.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';



class RevisionPage extends StatefulWidget {
  RevisionPage({
    super.key,
    this.id,
    // required this.time_limit,
  }){print("constructure in RevPage UI");}

  final num? id;
  // final num time_limit;

  @override
  State<RevisionPage> createState() => _RevisionPageState();
}

class _RevisionPageState extends State<RevisionPage> {
  //a list to initialize and keep question order (stores questionIds)
  List<int> questionOrder = [];

  //map to store question answers { question_id: answer_model }
  Map<int, SentAnswerModel> questionsAnswers = {};

  initQuestionOrder2(FullResRevivion quiz) {
    for (var p in quiz.problems ?? <ProblemModel>[]) {
      for (var q in p.questions ?? <QuestionModel>[]) {
        questionOrder.add(q.id as int);
      }
    }
    for (var q in quiz.separated_questions) {
      questionOrder.add(q.id as int);
    }
  }

  storeAnswer2(SentAnswerModel answer) {
    setState(() {
      questionsAnswers[answer.questionid!.toInt()] = answer;
    });
  }

  List<SentAnswerModel?> getAnswersList2() {
    return questionOrder.map((e) => questionsAnswers[e]).toList();
  }

  List<String> Label = ["أ", "ب", "ج", "د"];
  bool callintialzeanswe = false;
  ValueNotifier<double> percent = ValueNotifier<double>(0.0);



  @override
  void initState() {
    super.initState();
 //   startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FullrevisionBloc()..add(GetSubjecRevEvent(id: widget.id!)),
      child: Builder(builder: (context) {
        print("heerree");
        return BlocConsumer<FullrevisionBloc, FullrevisionState>(
          listener: (context, state) {

            // TODO: implement listener
            print("state is :::::::::");
            print(state);
            if (state is SubjectRevSuccess) {
              setState(() {
                callintialzeanswe = true;
                initQuestionOrder2(state.question_with_answer);
              });
            }
          },
          builder: (context, state) {
            if (state is SubjectRevSuccess) {
              print("count");
              print(state.question_with_answer.problems!.length+
                  state.question_with_answer.separated_questions.length);
              return PageView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: state.question_with_answer.problems!.length +
                      state.question_with_answer.separated_questions.length +
                      1,
                  itemBuilder: (context, index) {
                    if (index < state.question_with_answer.problems!.length) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Padding(
                          //   padding: EdgeInsets.all(
                          //       MediaQuery.of(context).size.height * 0.01),
                          //   child: ValueListenableBuilder(
                          //     valueListenable: percent,
                          //     builder: (context, value, child) =>
                          //         Row(children: [
                          //      // Text("${widget.time_limit - value}"),
                          //       Align(
                          //         alignment: Alignment.center,
                          //         child: Container(
                          //           // padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.01),
                          //           decoration: BoxDecoration(
                          //             borderRadius:
                          //                 BorderRadius.all(Radius.circular(10)),
                          //             boxShadow: [
                          //               BoxShadow(
                          //                 color: Colors.grey.withOpacity(0.6),
                          //                 spreadRadius: 0.001,
                          //                 blurRadius: 10,
                          //               )
                          //             ],
                          //           ),
                          //           child: LinearPercentIndicator(
                          //             backgroundColor: Colors.white,
                          //             progressColor: yellow,
                          //             width: MediaQuery.of(context).size.width *
                          //                 0.8,
                          //             animationDuration: 2500,
                          //             lineHeight: 14.0,
                          //             percent:
                          //                 min(100, value / widget.time_limit),
                          //             barRadius: const Radius.circular(10),
                          //           ),
                          //         ),
                          //       ),
                          //     ]),
                          //   ),
                          // ),
                          //!container for problem
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                                color: babyblue,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Lightgreen,
                                )),
                            child: Column(
                              children: [
                                Text(state.question_with_answer.problems![index]
                                    .problem_text!),
                                state.question_with_answer.problems![index]
                                                .problem_image !=
                                            null &&
                                        state
                                            .question_with_answer
                                            .problems![index]
                                            .questions![index]
                                            .question_image!
                                            .isNotEmpty
                                    ? Image.network(state
                                        .question_with_answer
                                        .problems![index]
                                        .questions![index]
                                        .question_image!)
                                    : const SizedBox(
                                        height: 1,
                                        width: 1,
                                      )
                              ],
                            ),
                          ),
                          //!container for Questions the problems
                          Flexible(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: state.question_with_answer
                                  .problems![index].questions!.length,
                              itemBuilder:
                                  (BuildContext context, int indexQuestions) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(state
                                        .question_with_answer
                                        .problems![index]
                                        .questions![indexQuestions]
                                        .question_text),
                                    state
                                                    .question_with_answer
                                                    .problems![index]
                                                    .questions![indexQuestions]
                                                    .question_image !=
                                                null &&
                                            state
                                                .question_with_answer
                                                .problems![index]
                                                .questions![indexQuestions]
                                                .question_image!
                                                .isNotEmpty
                                        ? Image.network(state
                                            .question_with_answer
                                            .problems![index]
                                            .questions![indexQuestions]
                                            .question_image!)
                                        : const SizedBox(
                                            height: 5,
                                            width: 5,
                                          ),

                                    //!answers
                                    Flexible(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: state
                                              .question_with_answer
                                              .problems![index]
                                              .questions![indexQuestions]
                                              .answers
                                              .length,
                                          itemBuilder:
                                              (contxt, indexforanswer) {
                                            List<bool> isPressedList =
                                                List.filled(
                                                    state
                                                        .question_with_answer
                                                        .problems![index]
                                                        .questions![indexQuestions]
                                                        .answers
                                                        .length,
                                                    false);
                                            return Padding(
                                              padding: EdgeInsets.all(
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                              ),
                                              child: AnswerContainer(
                                                  label: Label[indexforanswer],
                                                  answerText: state
                                                      .question_with_answer
                                                      .problems![index]
                                                      .questions![
                                                          indexQuestions]
                                                      .answers[indexforanswer]
                                                      .answer_text,
                                                  answerImage: state
                                                      .question_with_answer
                                                      .problems![index]
                                                      .questions![
                                                          indexQuestions]
                                                      .answers[indexforanswer]
                                                      .answer_image,
                                                  onTap: () {
                                                   print(" Question id  in problem Quiz :${ state
                                                            .question_with_answer
                                                            .problems![index]
                                                            .questions![indexQuestions]
                                                            .id}");
                                                        
                                                    storeAnswer2(SentAnswerModel(
                                                        answer_id: state
                                                            .question_with_answer
                                                            .problems![index]
                                                            .questions![
                                                                indexQuestions]
                                                            .answers[
                                                                indexforanswer]
                                                            .id!,
                                                        result_id: state
                                                            .question_with_answer.result_score
                                                            .result_id
                                                            .toInt(),
                                                        answer_tarqem: Label[
                                                            indexforanswer],
                                                        answer_text: state
                                                            .question_with_answer
                                                            .problems![index]
                                                            .questions![
                                                                indexQuestions]
                                                            .answers[
                                                                indexforanswer]
                                                            .answer_text!,
                                                        questionid: state
                                                            .question_with_answer
                                                            .problems![index]
                                                            .questions![indexQuestions]
                                                            .id));
                                                  }),
                                            );
                                          }),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                        ],
                      );
                    } else {
                      //! sperated question
                      int totalindex = state
                              .question_with_answer.problems!.length +
                          state.question_with_answer.separated_questions.length;
                      int sepratedIndex =
                          index - state.question_with_answer.problems!.length;
                      if (index < totalindex) {
                        return Column(
                          children: [
                           
                            //!container for Question for seprated Question
                            Container(
                                width: MediaQuery.of(context).size.width * 0.90,
                                height:
                                    MediaQuery.of(context).size.height * 0.45,
                                decoration: BoxDecoration(
                                    color: babyblue,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Lightgreen,
                                    )),
                                child: Column(
                                  children: [
                                    Text(state
                                        .question_with_answer
                                        .separated_questions[sepratedIndex]
                                        .question_text),
                                    state
                                                    .question_with_answer
                                                    .separated_questions[
                                                        sepratedIndex]
                                                    .question_image !=
                                                null &&
                                            state
                                                .question_with_answer
                                                .separated_questions[
                                                    sepratedIndex]
                                                .question_image!
                                                .isNotEmpty
                                        ? Image.network(state
                                            .question_with_answer
                                            .separated_questions[sepratedIndex]
                                            .question_image!)
                                        : const SizedBox(
                                            height: 1,
                                            width: 1,
                                          )
                                  ],
                                )),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
//!answers for seprated Question

                            Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 50,
                                        mainAxisSpacing: 30),
                                itemBuilder:
                                    (context, index_for_seprated_answer) {
                                  return AnswerContainer(
                                    label: Label[index_for_seprated_answer],
                                    answerText: state
                                        .question_with_answer
                                        .separated_questions[sepratedIndex]
                                        .answers[index_for_seprated_answer]
                                        .answer_text,
                                    answerImage: state
                                        .question_with_answer
                                        .separated_questions[sepratedIndex]
                                        .answers[index_for_seprated_answer]
                                        .answer_image,
                                    onTap: () {
                                      print(" question id in seprated Q is :${state
                                              .question_with_answer
                                              .separated_questions[sepratedIndex].id}");
                                      storeAnswer2(SentAnswerModel(
                                          answer_id: state
                                              .question_with_answer
                                              .separated_questions[
                                                  sepratedIndex]
                                              .answers[
                                                  index_for_seprated_answer]
                                              .id!,
                                          result_id: state
                                              .question_with_answer.result_score.result_id
                                              .toInt(),
                                          answer_text: state
                                              .question_with_answer
                                              .separated_questions[
                                                  sepratedIndex]
                                              .answers[
                                                  index_for_seprated_answer]
                                              .answer_text!,
                                          answer_tarqem:
                                              Label[index_for_seprated_answer],
                                          questionid:
                                          state
                                              .question_with_answer
                                              .separated_questions[sepratedIndex].id
                                            
                                            //  state.question_with_answer.id
                                              ));
                                    },
                                    // ispressesd: ispresse,
                                  );
                                },
                                itemCount: state
                                    .question_with_answer
                                    .separated_questions[sepratedIndex]
                                    .answers
                                    .length,
                              ),
                            ),
                            ////////////
                          ],
                        );
                      } 
                    }
                  });
            } else if (state is SubjectRevError) {
              return ErrorUi();
            } else {
              print("else in ui in RevPage");
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      }),
    );
  }
}

class AnswerContainer extends StatelessWidget {
  final String? answerText;
  final String? answerImage;
  final String label;
  final VoidCallback onTap;

  const AnswerContainer({
    Key? key,
    required this.answerText,
    required this.answerImage,
    required this.label,
    required this.onTap,
    // required this.ispressesd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.1,
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          color:
              // ispressesd ? greygreen
              babyblue,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Lightgreen,
          ),
        ),
        child: answerText != null
            ? Text(
                "  $label   $answerText",
                style: const TextStyle(fontSize: 16),
              )
            : Image.network(answerImage!),
      ),
    );
  }
}
//   q id_index >page view builder+>to know when i have to go _aswertext_answer tarqem
//controleeler jump to index page .....
//controller have to pass
///list from new model by index stoarge
///must to color my answer and right answer
///
