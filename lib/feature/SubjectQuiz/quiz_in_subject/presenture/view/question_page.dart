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
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/presenture/bloc/bloc/subject_question_bloc.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/send_answer_for_subject/data/Model/answer.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/send_answer_for_subject/presenture/view/send_answer_page.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../data/model/response_quiz.dart';

String testImage =
    'https://hips.hearstapps.com/hmg-prod/images/lightbulb-moment-royalty-free-image-176565702-1563363264.jpg?crop=0.665xw:1.00xh;0.228xw,0&resize=1200:*';

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
  //a list to initialize and keep question order (stores questionIds)
  List<int> questionOrder = [];

  //map to store question answers { question_id: answer_model }
  Map<int, SentAnswerModel> questionsAnswers = {};
  Map<int, Color> answerColors = {};
  Color color = Lightgreen;
  initQuestionOrder(ResponseQuizAllSubject quiz) {
    for (var p in quiz.problems ?? <ProblemModel>[]) {
      for (var q in p.questions ?? <QuestionModel>[]) {
        questionOrder.add(q.id as int);
      }
    }
    for (var q in quiz.separated_questions) {
      questionOrder.add(q.id as int);
    }
  }

  Map<int, int> selectedAnswers = {};
  storeAnswer(int questionId, int selectedIndex, SentAnswerModel answer) {
    setState(() {
      print("lm");

      selectedAnswers[questionId] = selectedIndex;
      print(color!.value.toString());
      questionsAnswers[answer.questionid!.toInt()] = answer;
    });
  }

  List<SentAnswerModel?> getAnswersList() {
    return questionOrder.map((e) => questionsAnswers[e]).toList();
  }

  List<String> Label = ["أ", "ب", "ج", "د"];
  bool callintialzeanswe = false;
  ValueNotifier<double> percent = ValueNotifier<double>(0.0);
  late Timer timer;

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (mounted) {
        percent.value += 1;
        if (percent.value >= widget.time_limit.toInt()) {
          timer.cancel();
          percent = ValueNotifier<double>(0.0);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("انتهى الوقت")));
        }
      }
    });
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
                initQuestionOrder(state.question_with_answer);
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
                            child: ValueListenableBuilder(
                              valueListenable: percent,
                              builder: (context, value, child) =>
                                  Row(children: [
                                Expanded(
                                    child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                            " ${widget.time_limit - value}"))),
                                Align(
                                  alignment: Alignment.center,
                                  child: Flexible(
                                    child: Container(
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
                                        width: MediaQuery.of(context).size.width *
                                            0.8,
                                        animationDuration: 2500,
                                        lineHeight: 14.0,
                                        percent:
                                            min(1, value / widget.time_limit),
                                        //value >= widget.time_limit
                                        //     ? 1.0 // Ensure it doesn't exceed 1.0
                                        //     : value / widget.time_limit,
                                    
                                        barRadius: const Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          //!container for problem
                          SingleChildScrollView(
                            child: Flexible(
                              child: Container(
                                // width: MediaQuery.of(context).size.width * 0.6,
                                // height: MediaQuery.of(context).size.height * 0.1,
                                decoration: BoxDecoration(
                                    color: babyblue,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Lightgreen,
                                    )),
                                child: Flexible(
                                  child: Column(
                                    children: [
                                      Text(state.question_with_answer
                                          .problems![index].problem_text!),
                                      state
                                                      .question_with_answer
                                                      .problems![index]
                                                      .problem_image
                                                  //testImage
                                                  !=
                                                  null &&
                                              state
                                                  .question_with_answer
                                                  .problems![index]
                                                  .questions![index]
                                                  .question_image!
                                                 
                                                  .isNotEmpty
                                          ? Padding(
                                              padding: EdgeInsets.all(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.01),
                                              child: Image.network(
                                                state
                                                    .question_with_answer
                                                    .problems![index]
                                                    .questions![index]
                                                    .question_image!,
                                                //  testImage,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1,
                                                fit: BoxFit.scaleDown,
                                              ),
                                            )
                                          : const SizedBox(
                                              height: 1,
                                              width: 1,
                                            )
                                    ],
                                  ),
                                ),
                              ),
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
                                return SingleChildScrollView(
                                  child: Column(
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
                                                      .questions![
                                                          indexQuestions]
                                                      .question_image
                                                  //  testImage
                                                  !=
                                                  null &&
                                              state
                                                  .question_with_answer
                                                  .problems![index]
                                                  .questions![indexQuestions]
                                                  .question_image!
                                                  // testImage
                                                  .isNotEmpty
                                          ? Image.network(
                                              state
                                                  .question_with_answer
                                                  .problems![index]
                                                  .questions![indexQuestions]
                                                  .question_image!,
                                              // testImage,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                            )
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
                                              return Padding(
                                                padding: EdgeInsets.all(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.01,
                                                ),
                                                child: AnswerContainer(
                                                    color: selectedAnswers[state
                                                                .question_with_answer
                                                                .problems![
                                                                    index]
                                                                .questions![
                                                                    indexQuestions]
                                                                .id] ==
                                                            indexforanswer
                                                        ? yellow
                                                        : Lightgreen,
                                                    label:
                                                        Label[indexforanswer],
                                                    answerText: state
                                                        .question_with_answer
                                                        .problems![index]
                                                        .questions![
                                                            indexQuestions]
                                                        .answers[indexforanswer]
                                                        .answer_text,
                                                    answerImage:
                                                        // testImage,
                                                        state
                                                            .question_with_answer
                                                            .problems![index]
                                                            .questions![
                                                                indexQuestions]
                                                            .answers[
                                                                indexforanswer]
                                                            .answer_image,
                                                    onTap: () {
                                                      print(
                                                          " Question id  in problem Quiz :${state.question_with_answer.problems![index].questions![indexQuestions].id}");

                                                      storeAnswer(
                                                          state
                                                              .question_with_answer
                                                              .problems![index]
                                                              .questions![
                                                                  indexQuestions]
                                                              .id
                                                              .toInt(),
                                                          indexforanswer,
                                                          SentAnswerModel(
                                                              answer_id: state
                                                                  .question_with_answer
                                                                  .problems![
                                                                      index]
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
                                                                  .problems![
                                                                      index]
                                                                  .questions![
                                                                      indexQuestions]
                                                                  .answers[
                                                                      indexforanswer]
                                                                  .answer_text!,
                                                              questionid: state
                                                                  .question_with_answer
                                                                  .problems![
                                                                      index]
                                                                  .questions![
                                                                      indexQuestions]
                                                                  .id));
                                                    }),
                                              );
                                            }),
                                      )
                                    ],
                                  ),
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
                            Expanded(
                              child: ValueListenableBuilder(
                                valueListenable: percent,
                                builder: (context, value, child) =>
                                    Row(children: [
                                  Expanded(
                                      // fit: BoxFit.contain,
                                      child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            " ${widget.time_limit - value}",
                                          ))),
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
                                        width: MediaQuery.of(context).size.width *
                                            0.8,
                                        animationDuration: 2500,
                                        lineHeight: 14.0,
                                        percent:
                                            min(1, value / widget.time_limit),
                                        barRadius: const Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            //!container for Question for seprated Question
                            Expanded(
                              flex: 2,
                              child: Container(
                                  width: MediaQuery.of(context).size.width * 0.90,
                                  // height:
                                  //     MediaQuery.of(context).size.height * 0.45,
                                  decoration: BoxDecoration(
                                      color: babyblue,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Lightgreen,
                                      )),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Text(state
                                            .question_with_answer
                                            .separated_questions[
                                                sepratedIndex]
                                            .question_text),
                                        state
                                                        .question_with_answer
                                                        .separated_questions[
                                                            sepratedIndex]
                                                        .question_image
                                                    // testImage
                                                    !=
                                                    null &&
                                                state
                                                    .question_with_answer
                                                    .separated_questions[
                                                        sepratedIndex]
                                                    .question_image!
                                                    // testImage
                                                    .isNotEmpty
                                            ? Padding(
                                                padding: EdgeInsets.all(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.01),
                                                child: Image.network(
                                                  // testImage,
                                                  state
                                                      .question_with_answer
                                                      .separated_questions[
                                                          sepratedIndex]
                                                      .question_image!,
                                                  height:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.15,
                                                  width:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.6,
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                            : const SizedBox(
                                                height: 0.001,
                                                width: 0.001,
                                              )
                                      ],
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
//!answers for seprated Question

                            Flexible(
                              flex: 2,
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing:
                                            MediaQuery.of(context).size.height *
                                                0.009,
                                        mainAxisSpacing:
                                            MediaQuery.of(context).size.height *
                                                0.005
                                                
                                                ),
                                itemBuilder:
                                    (context, index_for_seprated_answer) {
                                  return AnswerContainer(
                                    color: selectedAnswers[state
                                                .question_with_answer
                                                .separated_questions[
                                                    sepratedIndex]
                                                .id] ==
                                            index_for_seprated_answer
                                        ? yellow
                                        : Lightgreen,
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
                                      print(
                                          " question id in seprated Q is :${state.question_with_answer.separated_questions[sepratedIndex].id}");
                                      storeAnswer(
                                          state
                                              .question_with_answer
                                              .separated_questions[
                                                  sepratedIndex]
                                              .id
                                              .toInt(),
                                          index_for_seprated_answer,
                                          SentAnswerModel(
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
                                                  index_for_seprated_answer],
                                              questionid: state
                                                  .question_with_answer
                                                  .separated_questions[
                                                      sepratedIndex]
                                                  .id));
                                    },
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
                        final list = getAnswersList();
                        return SendAnswerUI(
                          timer: timer,
                          itemcount: list.length,
                          list: list,
                          result_Id: state.question_with_answer.result_id,
                        );
                      }
                    }
                  });
            } else if (state is SubjectQuestionError) {
              return ErrorUi();
            } else {
              print("last if in  get question ");
              return ErrorUi();
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
  Color? color;
  AnswerContainer(
      {Key? key,
      required this.answerText,
      required this.answerImage,
      required this.label,
      required this.onTap,
      this.color
      // required this.ispressesd,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: MediaQuery.of(context).size.width * 0.1,
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
            color:
                // ispressesd ? greygreen
                babyblue,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: color!,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                answerText != null
                    ? Text(
                        "  $label   $answerText",
                        style: const TextStyle(fontSize: 16),
                      )
                    : Text(""),
                answerImage != null
                    ? Image.network(
                        answerImage!,
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.1,
                      )
                    : SizedBox(
                        height: 0.001,
                        width: 0.001,
                      )
              ],
            ),
          )),
    );
  }
}
//   q id_index >page view builder+>to know when i have to go _aswertext_answer tarqem
//controleeler jump to index page .....
//controller have to pass
///list from new model by index stoarge
///must to color my answer and right answer
///
