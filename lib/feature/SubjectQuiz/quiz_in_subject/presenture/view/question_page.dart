import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
import 'package:ibnhyanfinal/feature/Failed/Error.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/data/model/answer_model.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/presenture/bloc/bloc/subject_question_bloc.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/send_answer_for_subject/data/Model/answer.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/send_answer_for_subject/presenture/view/send_answer_page.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class QuizSubjectUi extends StatefulWidget {
  QuizSubjectUi({
    super.key,
    this.id,
    required this.time_limit,
  });
  final num? id;
  final num time_limit;

  @override
  State<QuizSubjectUi> createState() => _QuizSubjectUiState();
}

class _QuizSubjectUiState extends State<QuizSubjectUi> {
  List<SentAnswerModel> selectedAnswers = [];
  List<SentAnswerModel> ListSepratedAnswer1 = [];
  List<SentAnswerModel> ListSepratedAnswer2 = [];
  List<String> Label = ["أ", "ب", "ج", "د"];
  bool callintialzeanswe = false;
  double percent = 0.0;
  bool ispresse = false;
   late List<bool> isPressedList ;
  late Timer timer;
  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (mounted)
        setState(() {
          percent += 1;
          if (percent >= widget.time_limit.toInt()) {
            timer.cancel();
            // percent=0.0;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("انتهى الوقت")));
          }
        });
    });
  }
  

  void store1answerList(
      {length, index, required SentAnswerModel answerQuestioninSepratedQ}) {
    setState(() {
      ListSepratedAnswer1 = List.generate(
          length,
          (index) => (SentAnswerModel(
              answer_id: answerQuestioninSepratedQ.answer_id,
              result_id: answerQuestioninSepratedQ.result_id,
              answer_tarqem: answerQuestioninSepratedQ.answer_tarqem,
              answer_text: answerQuestioninSepratedQ.answer_text)));

      print("List1 $ListSepratedAnswer1");
    });
  }

  void store2answerList(
      {length, index, required SentAnswerModel answerQuestioninSepratedQ}) {
    setState(() {
      final existingSnswerId = ListSepratedAnswer2.indexWhere((answer) =>
          answer.questionid == answerQuestioninSepratedQ.questionid);
      if (existingSnswerId != -1) {
        ListSepratedAnswer2[existingSnswerId] = answerQuestioninSepratedQ;
      } else {
        ListSepratedAnswer2.add(SentAnswerModel(
            answer_id: answerQuestioninSepratedQ.answer_id,
            result_id: answerQuestioninSepratedQ.result_id,
            answer_tarqem: answerQuestioninSepratedQ.answer_tarqem,
            answer_text: answerQuestioninSepratedQ.answer_text));
      }
      print("List2 $ListSepratedAnswer2");
    });
  }

  List<SentAnswerModel> mergeAnswers() {
    List<SentAnswerModel> allAnswers = [];

    allAnswers = ListSepratedAnswer1 + ListSepratedAnswer2;

    print("list mearge $allAnswers");
    return allAnswers;
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SubjectQuestionBloc()..add(GetSubjectQuestionEvent(id: widget.id!)),
      child: Builder(builder: (context) {
        return BlocConsumer<SubjectQuestionBloc, SubjectQuestionState>(
          listener: (context, state) {
            // TODO: implement listener
            print("state is");
            print(state);
            if (state is SubjectQuestionSuccess) {
              setState(() {
                callintialzeanswe = true;
                int totalQuestions =
                    state.question_with_answer.problems!.length +
                        state.question_with_answer.separated_questions.length;
              });
            }
          },
          builder: (context, state) {
            if (state is SubjectQuestionSuccess) {
              print("count");
              print(state.question_with_answer.problems!.length +
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
                          Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.height * 0.01),
                            child: Row(children: [
                              Text(widget.time_limit.toString() + ":00"),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  // padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.01),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.6),
                                        spreadRadius: 0.001,
                                        blurRadius: 10,
                                      )
                                    ],
                                  ),
                                  child: LinearPercentIndicator(
                                    backgroundColor: Colors.white,
                                    progressColor: yellow,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    animationDuration: 2500,
                                    lineHeight: 14.0,
                                    percent: percent / widget.time_limit,
                                    barRadius: Radius.circular(10),
                                    onPercentValue: (val) {
                                      val = percent;
                                      print(percent);
                                    },
                                  ),
                                ),
                              ),
                            ]),
                          ),
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
                                              .questions![index]
                                              .answers
                                              .length,
                                          itemBuilder:
                                              (contxt, indexforanswer) {
                                                List<bool> isPressedList =List.filled(state
                                              .question_with_answer
                                              .problems![index]
                                              .questions![index]
                                              .answers
                                              .length, false);
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
                                                    .questions![indexQuestions]
                                                    .answers[indexforanswer]
                                                    .answer_text,
                                                answerImage: state
                                                    .question_with_answer
                                                    .problems![index]
                                                    .questions![indexQuestions]
                                                    .answers[indexforanswer]
                                                    .answer_image,
                                                onTap: () {
                                                  setState(() {
                                                     isPressedList = List<bool>.filled(state
                                              .question_with_answer
                                              .problems![index]
                                              .questions![index]
                                              .answers
                                              .length, false);
                                                    isPressedList[index]=true;
                                                    store1answerList(
                                                        answerQuestioninSepratedQ:
                                                            SentAnswerModel(
                                                          answer_id: state
                                                              .question_with_answer
                                                              .problems![index]
                                                              .questions![
                                                                  indexQuestions]
                                                              .answers[
                                                                  indexforanswer]
                                                              .id!,
                                                          result_id: state
                                                              .question_with_answer
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
                                                        ),
                                                        length: state
                                                            .question_with_answer
                                                            .problems![index]
                                                            .questions!
                                                            .length,
                                                        index: index);
                                                  });
                                                },
                                                ispressesd: isPressedList[index],
                                              ),
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
                            Row(
                              children: [
                                Text(widget.time_limit.toString() + ":00"),
                                Container(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.height *
                                          0.01),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.6),
                                        spreadRadius: 0.01,
                                        blurRadius: 10,
                                      )
                                    ],
                                  ),
                                  child: LinearPercentIndicator(
                                    backgroundColor: Colors.white,
                                    progressColor: yellow,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    animationDuration: 2500,
                                    lineHeight: 14.0,
                                    percent: percent / widget.time_limit,
                                    barRadius: Radius.circular(10),
                                    onPercentValue: (val) {
                                      val = percent;
                                      print(percent);
                                    },
                                  ),
                                ),
                              ],
                            ),
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
                                      setState(() {
                                        ispresse = true;

                                        store2answerList(
                                            index: index_for_seprated_answer,
                                            length: state.question_with_answer
                                                .separated_questions.length,
                                            answerQuestioninSepratedQ: SentAnswerModel(
                                                answer_id: state
                                                    .question_with_answer
                                                    .separated_questions[
                                                        sepratedIndex]
                                                    .answers[
                                                        index_for_seprated_answer]
                                                    .id!,
                                                result_id: state
                                                    .question_with_answer
                                                    .result_id
                                                    .toInt(),
                                                answer_text: state
                                                    .question_with_answer
                                                    .separated_questions[
                                                        sepratedIndex]
                                                    .answers[
                                                        index_for_seprated_answer]
                                                    .answer_text!,
                                                answer_tarqem: Label[
                                                    index_for_seprated_answer]));
                                      });
                                    },
                                    ispressesd: ispresse,
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
                      } else {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.of(context)
                              .pushNamed("/SendAnswerUI", arguments: [
                            mergeAnswers().length,
                            mergeAnswers(),
                            state.question_with_answer.result_id,
                          ]);
                        });
                      }
                    }
                  });
            } else if (state is SubjectQuestionError) {
              return MyWidget();
            } else {
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
  final bool ispressesd;
  const AnswerContainer({
    Key? key,
    required this.answerText,
    required this.answerImage,
    required this.label,
    required this.onTap,
    required this.ispressesd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.1,
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          color: ispressesd ? greygreen : babyblue,
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


















