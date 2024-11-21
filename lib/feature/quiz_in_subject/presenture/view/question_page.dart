import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
import 'package:ibnhyanfinal/feature/quiz_in_subject/presenture/bloc/bloc/subject_question_bloc.dart';

class QuizSubjectUi extends StatelessWidget {
  const QuizSubjectUi({super.key, required this.id});
  final num id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SubjectQuestionBloc()..add(GetSubjectQuestionEvent(id: id)),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: green,
          ),
          backgroundColor: offwhite,
          body: BlocConsumer<SubjectQuestionBloc, SubjectQuestionState>(
            listener: (context, state) {
              // TODO: implement listener
              print("state is");
              print(state);
            },
            builder: (context, state) {
              if (state is SubjectQuestionSuccess) {
                return PageView.builder(
                    itemCount: state.question_with_answer.problems!.length +
                        state.question_with_answer.separated_questions
                            .length, //   ,
                    itemBuilder: (context, index) {
                      if (index < state.question_with_answer.problems!.length) {
                        return Column(
                          children: [
                            //!container for problem
                            Container(
                              width: MediaQuery.of(context).size.width * 0.90,
                              height: MediaQuery.of(context).size.height * 0.45,
                              decoration: BoxDecoration(
                                  color: babyblue,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Lightgreen,
                                  )),
                              child: Column(
                                children: [
                                  Text(state.question_with_answer
                                      .problems![index].problem_text!),
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
                                      : SizedBox(
                                          height: 1,
                                          width: 1,
                                        )
                                ],
                              ),
                            ),
                            //!container for Question
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int indexQuestions) {
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.90,
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
                                          .problems![index]
                                          .questions![indexQuestions]
                                          .question_text),
                                      state
                                                      .question_with_answer
                                                      .problems![indexQuestions]
                                                      .questions![indexQuestions]
                                                      .question_image !=
                                                  null &&
                                              state
                                                  .question_with_answer
                                                  .problems![indexQuestions]
                                                  .questions![indexQuestions]
                                                  .question_image!
                                                  .isNotEmpty
                                          ? Image.network(state
                                              .question_with_answer
                                              .problems![indexQuestions]
                                              .questions![indexQuestions]
                                              .question_image!)
                                          : SizedBox(
                                              height: 1,
                                              width: 1,
                                            )
                                    ],
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
//!answers
// List.suffle(){}
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    decoration: BoxDecoration(
                                      color: babyblue,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Lightgreen,
                                      ),
                                    ),
                                    child: state
                                                .question_with_answer
                                                .problems![index]
                                                .questions![index]
                                                .answers[0]
                                                .answer_text !=
                                            null
                                        ? Text("أ   " +
                                            state
                                                .question_with_answer
                                                .problems![index]
                                                .questions![index]
                                                .answers[0]
                                                .answer_text!)
                                        : Image.network(state
                                            .question_with_answer
                                            .problems![index]
                                            .questions![index]
                                            .answers[0]
                                            .answer_image!)),
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    decoration: BoxDecoration(
                                      color: babyblue,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Lightgreen,
                                      ),
                                    ),
                                    child: state
                                                .question_with_answer
                                                .problems![index]
                                                .questions![index]
                                                .answers[1]
                                                .answer_text !=
                                            null
                                        ? Text("ب   " +
                                            state
                                                .question_with_answer
                                                .problems![index]
                                                .questions![index]
                                                .answers[1]
                                                .answer_text!)
                                        : Image.network(state
                                            .question_with_answer
                                            .problems![index]
                                            .questions![index]
                                            .answers[1]
                                            .answer_image!))
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    decoration: BoxDecoration(
                                      color: babyblue,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Lightgreen,
                                      ),
                                    ),
                                    child: state
                                                .question_with_answer
                                                .problems![index]
                                                .questions![index]
                                                .answers[2]
                                                .answer_text !=
                                            null
                                        ? Text("ج   " +
                                            state
                                                .question_with_answer
                                                .problems![index]
                                                .questions![index]
                                                .answers[2]
                                                .answer_text!)
                                        : Image.network(state
                                            .question_with_answer
                                            .problems![index]
                                            .questions![index]
                                            .answers[2]
                                            .answer_image!)),
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    decoration: BoxDecoration(
                                      color: babyblue,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Lightgreen,
                                      ),
                                    ),
                                    child: state
                                                .question_with_answer
                                                .problems![index]
                                                .questions![index]
                                                .answers[3]
                                                .answer_text !=
                                            null
                                        ? Text("د   " +
                                            state
                                                .question_with_answer
                                                .problems![index]
                                                .questions![index]
                                                .answers[3]
                                                .answer_text!)
                                        : Image.network(state
                                            .question_with_answer
                                            .problems![index]
                                            .questions![index]
                                            .answers[3]
                                            .answer_image!))
                              ],
                            )
                          ],
                        );
                      } else {
                        //! sperated question
                        return Column(
                          children: [
                            //!container for Question
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
                                        .separated_questions[index]
                                        .question_text),
                                    state
                                                    .question_with_answer
                                                    .separated_questions[index]
                                                    .question_image !=
                                                null &&
                                            state
                                                .question_with_answer
                                                .separated_questions[index]
                                                .question_image!
                                                .isNotEmpty
                                        ? Image.network(state
                                            .question_with_answer
                                            .separated_questions[index]
                                            .question_image!)
                                        : SizedBox(
                                            height: 1,
                                            width: 1,
                                          )
                                  ],
                                )),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
//!answers
// List.suffle(){}
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    decoration: BoxDecoration(
                                      color: babyblue,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Lightgreen,
                                      ),
                                    ),
                                    child: state
                                                .question_with_answer
                                                .separated_questions[index]
                                                .answers[0]
                                                .answer_text !=
                                            null
                                        ? Text("أ   " +
                                            state
                                                .question_with_answer
                                                .separated_questions[index]
                                                .answers[0]
                                                .answer_text!)
                                        : Image.network(state
                                            .question_with_answer
                                            .separated_questions[index]
                                            .answers[0]
                                            .answer_image!)),
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    decoration: BoxDecoration(
                                      color: babyblue,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Lightgreen,
                                      ),
                                    ),
                                    child: state
                                                .question_with_answer
                                                .separated_questions[index]
                                                .answers[1]
                                                .answer_text !=
                                            null
                                        ? Text("ب   " +
                                            state
                                                .question_with_answer
                                                .separated_questions[index]
                                                .answers[1]
                                                .answer_text!)
                                        : Image.network(state
                                            .question_with_answer
                                            .separated_questions[index]
                                            .answers[1]
                                            .answer_image!))
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    decoration: BoxDecoration(
                                      color: babyblue,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Lightgreen,
                                      ),
                                    ),
                                    child: state
                                                .question_with_answer
                                                .separated_questions[index]
                                                .answers[2]
                                                .answer_text !=
                                            null
                                        ? Text("ج   " +
                                            state
                                                .question_with_answer
                                                .separated_questions[index]
                                                .answers[2]
                                                .answer_text!)
                                        : Image.network(state
                                            .question_with_answer
                                            .separated_questions[index]
                                            .answers[2]
                                            .answer_image!)),
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    decoration: BoxDecoration(
                                      color: babyblue,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Lightgreen,
                                      ),
                                    ),
                                    child: state
                                                .question_with_answer
                                                .separated_questions[index]
                                                .answers[3]
                                                .answer_text !=
                                            null
                                        ? Text("د   " +
                                            state
                                                .question_with_answer
                                                .separated_questions[index]
                                                .answers[3]
                                                .answer_text!)
                                        : Image.network(state
                                            .question_with_answer
                                            .separated_questions[index]
                                            .answers[3]
                                            .answer_image!))
                              ],
                            )
                          ],
                        );
                      }
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        );
      }),
    );
  }
}
