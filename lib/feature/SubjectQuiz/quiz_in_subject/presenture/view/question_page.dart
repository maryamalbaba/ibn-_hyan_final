import 'dart:async';
import 'dart:math';

import 'package:ibnhyanfinal/core/widgets/confirm_dialog.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/presenture/view/problem_card.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/presenture/view/problem_view.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/presenture/view/question_view.dart';

import '../../../../../core/widgets/useable_green_container.dart';
import '../../../send_answer_for_subject/presenture/view/bloc/send_answer_bloc.dart';
import '../../data/model/answer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
import 'package:ibnhyanfinal/feature/Failed/Error.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/data/model/problem.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/data/model/question_model.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/presenture/bloc/bloc/subject_question_bloc.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/send_answer_for_subject/data/Model/answer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../data/model/response_quiz.dart';

String testImage =
    'https://hips.hearstapps.com/hmg-prod/images/lightbulb-moment-royalty-free-image-176565702-1563363264.jpg?crop=0.665xw:1.00xh;0.228xw,0&resize=1200:*';

class QuizSubjectUi extends StatefulWidget {
  const QuizSubjectUi({
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

  void storeAnswer(int questionId, int selectedIndex, SentAnswerModel answer) {
    setState(() {
      selectedAnswers[questionId] = selectedIndex;
      print(color.value.toString());
      questionsAnswers[answer.questionid!.toInt()] = answer;
    });
  }

  List<SentAnswerModel?> getAnswersList() {
    return questionOrder.map((e) => questionsAnswers[e]).toList();
  }

  // List<String> Label = ["أ", "ب", "ج", "د"];
  bool callintialzeanswe = false;
  ValueNotifier<double> percent = ValueNotifier<double>(0.0);
  late Timer timer;

  startTimer() {
    timer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (mounted) {
        percent.value += 1;
        if (percent.value >= widget.time_limit.toInt()) {
          timer.cancel();
          percent = ValueNotifier<double>(0.0);
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("انتهى الوقت")));
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => SubjectQuestionBloc()
              ..add(GetSubjectQuestionEvent(id: widget.id!))),
        BlocProvider(create: (context) => SendAnswerBloc()),
      ],
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
              return Column(
                children: [
                  // const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: ValueListenableBuilder(
                      valueListenable: percent,
                      builder: (context, value, child) => Row(children: [
                        FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              " ${widget.time_limit - value}",
                            )),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      spreadRadius: 0.1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 1))
                                ],
                              ),
                              child: LinearPercentIndicator(
                                padding: EdgeInsets.zero,
                                backgroundColor: Colors.white,
                                progressColor: yellow,
                                animationDuration: 2500,
                                lineHeight: 14.0,
                                percent: min(1, value / widget.time_limit),
                                barRadius: const Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  ValueListenableBuilder(
                      valueListenable: state.pinnedProblem,
                      builder: (context, value, child) {
                        if (value == null) {
                          return const SizedBox();
                        }
                        return ProblemCard(pinned: true, problem: value);
                      }),
                  Expanded(
                    child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        itemCount:
                            state.question_with_answer.problems!.length +
                                state.question_with_answer.separated_questions
                                    .length +
                                1,
                        itemBuilder: (context, index) {
                          //send button
                          if (index ==
                              state.question_with_answer.problems!.length +
                                  state.question_with_answer
                                      .separated_questions.length) {
                            return BlocListener<SendAnswerBloc,
                                SendAnswerState>(
                              listener: (context, sendState) {
                                final list = getAnswersList();
                                // TODO: implement listener
                                if (sendState is SendAnswerSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("تم الارسال بنجاح")));
                                  Navigator.of(context)
                                      .pushNamed("/ResultExamUI", arguments: [
                                    state.question_with_answer.result_id
                                        .toInt(),
                                    list
                                  ]);
                                }
                                // else {
                                //   if (!list.any((element) => element == null)) {
                                //     ScaffoldMessenger.of(context).showSnackBar(
                                //         const SnackBar(
                                //             content: Text(
                                //                 "يجب الاجابة على كل الاسئلة ")));
                                //   }
                                // }
                              },
                              child: InkWell(
                                  onTap: () {
                                    final list = getAnswersList();
                                    final nullList = [];
                                    for (int j = 0; j < list.length; j++) {
                                      if (list[j] == null) {
                                        nullList.add(j + 1);
                                      }
                                    }
                                    showDialog(
                                        context: context,
                                        builder: (_) => ConfirmDialog(
                                              title: "من تسليم الاختبار",
                                              onConfirm: nullList.isNotEmpty
                                                  ? null
                                                  : () async {
                                                      timer.cancel();
                                                      context
                                                          .read<
                                                              SendAnswerBloc>()
                                                          .add(SendAnswer(list
                                                              .nonNulls
                                                              .toList()));
                                                    },
                                              child: nullList.isNotEmpty
                                                  ? Text(
                                                      "الأسئلة: ${nullList.join("-")} لم يتم الإجابة عنها")
                                                  : null,
                                            ));
                                  },
                                  child: const UseableGreenContainer(
                                      text: "تسليم الاختبار")),
                            );
                          }
                          if (index <
                              state.question_with_answer.problems!.length) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                //!container for problem
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: ProblemView(
                                    questionOrder: questionOrder,
                                    problem: state.question_with_answer
                                        .problems![index],
                                    selected: (question) {
                                      return selectedAnswers[question.id];
                                    },
                                    onAnswer: (QuestionModel question,
                                        int answer_index,
                                        AnswerModel answer) {
                                      storeAnswer(
                                          question.id.toInt(),
                                          answer_index,
                                          SentAnswerModel(
                                              answer_id: answer.id!,
                                              result_id: state
                                                  .question_with_answer
                                                  .result_id
                                                  .toInt(),
                                              answer_tarqem: QuestionView
                                                  .label[answer_index],
                                              answer_text:
                                                  answer.answer_text!,
                                              questionid: question.id));
                                    },
                                  ),
                                ),
                              ],
                            );
                          } else {
                            //! sperated question
                            int sepratedIndex = index -
                                state.question_with_answer.problems!.length;
                            return Column(
                              children: [
                                QuestionView(
                                  index: questionOrder.indexOf(state
                                      .question_with_answer
                                      .separated_questions[sepratedIndex]
                                      .id
                                      .toInt()),
                                  question: state.question_with_answer
                                      .separated_questions[sepratedIndex],
                                  selected: selectedAnswers[state
                                      .question_with_answer
                                      .separated_questions[sepratedIndex]
                                      .id],
                                  onAnswer: (question, answer_index, answer) {
                                    storeAnswer(
                                      question.id.toInt(),
                                      answer_index,
                                      SentAnswerModel(
                                        answer_id: question
                                            .answers[answer_index].id!,
                                        result_id: state
                                            .question_with_answer.result_id
                                            .toInt(),
                                        answer_text: question
                                            .answers[answer_index]
                                            .answer_text!,
                                        answer_tarqem:
                                            QuestionView.label[answer_index],
                                        questionid: question.id,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 8),
                                const Divider(color: green),
                              ],
                            );
                          }
                        }),
                  ),
                ],
              );
            } else if (state is SubjectQuestionError) {
              return ErrorUi();
            } else {
              print(state);
              return const Center(
                  child: CircularProgressIndicator(color: green));
            }
          },
        );
      }),
    );
  }
}

//   q id_index >page view builder+>to know when i have to go _aswertext_answer tarqem
//controleeler jump to index page .....
//controller have to pass
///list from new model by index stoarge
///must to color my answer and right answer
///
