import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
import 'package:ibnhyanfinal/feature/Failed/Error.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/data/model/problem.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/data/model/question_model.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/presenture/view/problem_view.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/presenture/view/question_view.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/revision_quiz/data/Models/full_res_revivion.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/revision_quiz/presenture/bloc/fullrevision_bloc.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/send_answer_for_subject/data/Model/answer.dart';

import '../../../quiz_in_subject/presenture/view/answer_container.dart';

class RevisionPage extends StatefulWidget {
  RevisionPage({
    super.key,
    this.id,
    required this.list,
    // required this.time_limit,
  }) {
    print("constructure in RevPage UI");
  }

  final num? id;
  final List<SentAnswerModel?> list;

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

  // storeAnswer2(SentAnswerModel answer) {
  //   setState(() {
  //     questionsAnswers[answer.questionid!.toInt()] = answer;
  //   });
  // }

  List<SentAnswerModel?> getAnswersList2() {
    return questionOrder.map((e) => questionsAnswers[e]).toList();
  }

  List<String> Label = ["أ", "ب", "ج", "د"];
  bool callintialzeanswe = false;
  ValueNotifier<double> percent = ValueNotifier<double>(0.0);
  Color color = Colors.red;

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
              print(state.question_with_answer.problems!.length +
                  state.question_with_answer.separated_questions.length);
              return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: state.question_with_answer.problems!.length +
                      state.question_with_answer.separated_questions.length,
                  itemBuilder: (context, index) {
                    if (index < state.question_with_answer.problems!.length) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ProblemView(
                          problem: state.question_with_answer.problems![index],
                          selected: (question) {
                            return widget.list
                                .firstWhere((element) =>
                                    element?.questionid == question.id)
                                ?.answer_id
                                .toInt();
                          },
                          result: true,
                          onAnswer: (question, answer_index, answer) {},
                        ),
                      );
                      // return Column(
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: [
                      //     //!container for problem
                      //     Container(
                      //       width: MediaQuery.of(context).size.width * 0.6,
                      //       height: MediaQuery.of(context).size.height * 0.1,
                      //       decoration: BoxDecoration(
                      //           color: babyblue,
                      //           borderRadius: BorderRadius.circular(10),
                      //           border: Border.all(
                      //             color: Lightgreen,
                      //           )),
                      //       child: Column(
                      //         children: [
                      //           Text(state.question_with_answer.problems![index]
                      //               .problem_text!),
                      //           state.question_with_answer.problems![index]
                      //                           .problem_image !=
                      //                       null &&
                      //                   state
                      //                       .question_with_answer
                      //                       .problems![index]
                      //                       .questions![index]
                      //                       .question_image!
                      //                       .isNotEmpty
                      //               ? Image.network(state
                      //                   .question_with_answer
                      //                   .problems![index]
                      //                   .questions![index]
                      //                   .question_image!)
                      //               : const SizedBox(
                      //                   height: 1,
                      //                   width: 1,
                      //                 )
                      //         ],
                      //       ),
                      //     ),
                      //     //!container for Questions the problems
                      //     Flexible(
                      //       child: ListView.builder(
                      //         scrollDirection: Axis.vertical,
                      //         itemCount: state.question_with_answer
                      //             .problems![index].questions!.length,
                      //         itemBuilder:
                      //             (BuildContext context, int indexQuestions) {
                      //           return Column(
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: [
                      //               Text(state
                      //                   .question_with_answer
                      //                   .problems![index]
                      //                   .questions![indexQuestions]
                      //                   .question_text),
                      //               state
                      //                               .question_with_answer
                      //                               .problems![index]
                      //                               .questions![indexQuestions]
                      //                               .question_image !=
                      //                           null &&
                      //                       state
                      //                           .question_with_answer
                      //                           .problems![index]
                      //                           .questions![indexQuestions]
                      //                           .question_image!
                      //                           .isNotEmpty
                      //                   ? Image.network(state
                      //                       .question_with_answer
                      //                       .problems![index]
                      //                       .questions![indexQuestions]
                      //                       .question_image!)
                      //                   : const SizedBox(
                      //                       height: 5,
                      //                       width: 5,
                      //                     ),
                      //
                      //               //!answers
                      //               Flexible(
                      //                 child: ListView.builder(
                      //                     shrinkWrap: true,
                      //                     itemCount: state
                      //                         .question_with_answer
                      //                         .problems![index]
                      //                         .questions![indexQuestions]
                      //                         .answers
                      //                         .length,
                      //                     itemBuilder:
                      //                         (contxt, indexforanswer) {
                      //                       List<bool> isPressedList =
                      //                           List.filled(
                      //                               state
                      //                                   .question_with_answer
                      //                                   .problems![index]
                      //                                   .questions![
                      //                                       indexQuestions]
                      //                                   .answers
                      //                                   .length,
                      //                               false);
                      //
                      //                       return Padding(
                      //                         padding: EdgeInsets.all(
                      //                           MediaQuery.of(context)
                      //                                   .size
                      //                                   .height *
                      //                               0.01,
                      //                         ),
                      //                         child: Builder(
                      //                           builder: (context) {
                      //                             Color color = (state
                      //                                         .question_with_answer
                      //                                         .problems![index]
                      //                                         .questions![
                      //                                             indexQuestions]
                      //                                         .answers[
                      //                                             indexforanswer]
                      //                                         .is_correct ==
                      //                                     1)
                      //                                 ? Colors.green
                      //                                 : Colors.red;
                      //
                      //                             return AnswerContainer(
                      //                               label:
                      //                                   Label[indexforanswer],
                      //                               answerText: state
                      //                                   .question_with_answer
                      //                                   .problems![index]
                      //                                   .questions![
                      //                                       indexQuestions]
                      //                                   .answers[indexforanswer]
                      //                                   .answer_text,
                      //                               answerImage: state
                      //                                   .question_with_answer
                      //                                   .problems![index]
                      //                                   .questions![
                      //                                       indexQuestions]
                      //                                   .answers[indexforanswer]
                      //                                   .answer_image,
                      //                               onTap: () {
                      //                                 // print(
                      //                                 //     "Question id in problem Quiz : ${state.question_with_answer.problems![index].questions![indexQuestions].id}");
                      //                                 // storeAnswer2(
                      //                                 //     SentAnswerModel(
                      //                                 //   answer_id: state
                      //                                 //       .question_with_answer
                      //                                 //       .problems![index]
                      //                                 //       .questions![
                      //                                 //           indexQuestions]
                      //                                 //       .answers[
                      //                                 //           indexforanswer]
                      //                                 //       .id!,
                      //                                 //   result_id: state
                      //                                 //       .question_with_answer
                      //                                 //       .result_score
                      //                                 //       .result_id
                      //                                 //       .toInt(),
                      //                                 //   answer_tarqem: Label[
                      //                                 //       indexforanswer],
                      //                                 //   answer_text: state
                      //                                 //       .question_with_answer
                      //                                 //       .problems![index]
                      //                                 //       .questions![
                      //                                 //           indexQuestions]
                      //                                 //       .answers[
                      //                                 //           indexforanswer]
                      //                                 //       .answer_text!,
                      //                                 //   questionid: state
                      //                                 //       .question_with_answer
                      //                                 //       .problems![index]
                      //                                 //       .questions![
                      //                                 //           indexQuestions]
                      //                                 //       .id,
                      //                                 // ));
                      //                               },
                      //                               color: color,
                      //                             );
                      //                           },
                      //                         ),
                      //                       );
                      //                     }),
                      //               )
                      //             ],
                      //           );
                      //         },
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       height: MediaQuery.of(context).size.height * 0.1,
                      //     ),
                      //   ],
                      // );
                    } else {
                      //! sperated question
                      int sepratedIndex =
                          index - state.question_with_answer.problems!.length;
                      final question = state.question_with_answer
                          .separated_questions[sepratedIndex];
                      return QuestionView(
                        question: question,
                        result: true,
                        selected: widget.list
                            .firstWhere(
                                (element) => element?.questionid == question.id)
                            ?.answer_id
                            .toInt(),
                        onAnswer: (question, answer_index, answer) {},
                      );
//                       return Column(
//                         children: [
//                           //!container for Question for seprated Question
//                           Container(
//                               width: MediaQuery.of(context).size.width * 0.90,
//                               height: MediaQuery.of(context).size.height * 0.45,
//                               decoration: BoxDecoration(
//                                   color: babyblue,
//                                   borderRadius: BorderRadius.circular(10),
//                                   border: Border.all(
//                                     color: Lightgreen,
//                                   )),
//                               child: Column(
//                                 children: [
//                                   Text(state
//                                       .question_with_answer
//                                       .separated_questions[sepratedIndex]
//                                       .question_text),
//                                   state
//                                                   .question_with_answer
//                                                   .separated_questions[
//                                                       sepratedIndex]
//                                                   .question_image !=
//                                               null &&
//                                           state
//                                               .question_with_answer
//                                               .separated_questions[
//                                                   sepratedIndex]
//                                               .question_image!
//                                               .isNotEmpty
//                                       ? Image.network(state
//                                           .question_with_answer
//                                           .separated_questions[sepratedIndex]
//                                           .question_image!)
//                                       : const SizedBox(
//                                           height: 1,
//                                           width: 1,
//                                         )
//                                 ],
//                               )),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.1,
//                           ),
// //!answers for seprated Question
//
//                           Expanded(
//                             child: GridView.builder(
//                               gridDelegate:
//                                   SliverGridDelegateWithFixedCrossAxisCount(
//                                       crossAxisCount: 2,
//                                       crossAxisSpacing: 50,
//                                       mainAxisSpacing: 30),
//                               itemBuilder:
//                                   (context, index_for_seprated_answer) {
//                                 return Builder(builder: (context) {
//                                   Color color = (state
//                                               .question_with_answer
//                                               .separated_questions[
//                                                   sepratedIndex]
//                                               .answers[
//                                                   index_for_seprated_answer]
//                                               .is_correct ==
//                                           1)
//                                       ? Colors.green
//                                       : Colors.red;
//                                   return AnswerContainer(
//                                     color: color,
//                                     label: Label[index_for_seprated_answer],
//                                     answerText: state
//                                         .question_with_answer
//                                         .separated_questions[sepratedIndex]
//                                         .answers[index_for_seprated_answer]
//                                         .answer_text,
//                                     answerImage: state
//                                         .question_with_answer
//                                         .separated_questions[sepratedIndex]
//                                         .answers[index_for_seprated_answer]
//                                         .answer_image,
//                                     onTap: () {
//                                       // print(
//                                       //     " question id in seprated Q is :${state.question_with_answer.separated_questions[sepratedIndex].id}");
//                                       // storeAnswer2(SentAnswerModel(
//                                       //     answer_id: state
//                                       //         .question_with_answer
//                                       //         .separated_questions[
//                                       //             sepratedIndex]
//                                       //         .answers[
//                                       //             index_for_seprated_answer]
//                                       //         .id!,
//                                       //     result_id: state
//                                       //         .question_with_answer
//                                       //         .result_score
//                                       //         .result_id
//                                       //         .toInt(),
//                                       //     answer_text: state
//                                       //         .question_with_answer
//                                       //         .separated_questions[
//                                       //             sepratedIndex]
//                                       //         .answers[
//                                       //             index_for_seprated_answer]
//                                       //         .answer_text!,
//                                       //     answer_tarqem: Label[
//                                       //         index_for_seprated_answer],
//                                       //     questionid: state
//                                       //         .question_with_answer
//                                       //         .separated_questions[
//                                       //             sepratedIndex]
//                                       //         .id
//                                       //
//                                       //     //  state.question_with_answer.id
//                                       //     ));
//                                     },
//                                     // ispressesd: ispresse,
//                                   );
//                                 });
//                               },
//                               itemCount: state
//                                   .question_with_answer
//                                   .separated_questions[sepratedIndex]
//                                   .answers
//                                   .length,
//                             ),
//                           ),
//                           ////////////
//                         ],
//                       );
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
