import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/presenture/bloc/bloc/subject_question_bloc.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/send_answer_for_subject/data/Model/answer.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/send_answer_for_subject/presenture/view/send_answer_page.dart';

class QuizSubjectUi extends StatefulWidget {
   QuizSubjectUi({super.key, this.id,});
  final num? id;
  @override
  State<QuizSubjectUi> createState() => _QuizSubjectUiState();
}

class _QuizSubjectUiState extends State<QuizSubjectUi> {
  List<SentAnswerModel> selectedAnswers = [];
  List <String> Label=["أ","ب","ج","د"];
  bool callintialzeanswe=false;

  void initializeAnswers(int totalQuestions) {
    selectedAnswers = List.generate(
      totalQuestions,
      (index) => SentAnswerModel(
        answer_id: 0,
        result_id: 0,
        questionid: 0,
        index: index,
        answer_text: "  ",
        answer_tarqem: "  ",
      ),
    );
  }

  void storeAnswer(num questionId, num answerId, num resultId, num index,
      String answer_text, String answer_tarqem) {
setState(() {
    int existingIndex =
        selectedAnswers.indexWhere((answer) => answer.answer_id == answerId);
  
    if (existingIndex != -1) {
      selectedAnswers[existingIndex] = SentAnswerModel(
          answer_id: answerId,
          result_id: resultId,
          questionid: questionId,
          index: index,
          answer_text: answer_text,
          answer_tarqem: answer_tarqem);
    } else {
      selectedAnswers.removeWhere((answer) => answer.questionid == questionId);

      selectedAnswers.add(SentAnswerModel(
          answer_id: answerId,
          result_id: resultId,
          index: index,
          answer_text: answer_text,
          answer_tarqem: answer_tarqem));
    }

    print(selectedAnswers);
});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SubjectQuestionBloc()..add(GetSubjectQuestionEvent(id: widget.id!)),
      child: Builder(builder: (context) {
        return
            
            BlocConsumer<SubjectQuestionBloc, SubjectQuestionState>(
          listener: (context, state) {
            // TODO: implement listener
            print("state is");
            print(state);
if (state is SubjectQuestionSuccess && !callintialzeanswe) {
      setState(() {
        callintialzeanswe = true;
        int totalQuestions = state.question_with_answer.problems!.length +
            state.question_with_answer.separated_questions.length;

        initializeAnswers(totalQuestions);
      });}

          },
          builder: (context, state) {
            if (state is SubjectQuestionSuccess) {
           

              return PageView.builder(
                  itemCount: state.question_with_answer.problems!.length +
                      state.question_with_answer.separated_questions.length +
                      1,
                  itemBuilder: (context, index) {
                    if (index < state.question_with_answer.problems!.length) {
                      return Column(
                        children: [
                          //!container for problem
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.03,
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
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: state.question_with_answer
                                .problems![index].questions!.length,
                            itemBuilder:
                                (BuildContext context, int indexQuestions) {
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
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
                                            height: 1,
                                            width: 1,
                                          ),

//!answers

                                    Row(
                                      children: [
                                        AnswerContainer(
                                            label: "أ",
                                            answerText: state
                                                .question_with_answer
                                                .problems![index]
                                                .questions![indexQuestions]
                                                .answers[0]
                                                .answer_text,
                                            answerImage: state
                                                .question_with_answer
                                                .problems![index]
                                                .questions![indexQuestions]
                                                .answers[0]
                                                .answer_image,
                                            onTap: () {
                                              
                                                storeAnswer(
                                                  state.question_with_answer.id,
                                                  state
                                                      .question_with_answer
                                                      .problems![index]
                                                      .questions![index]
                                                      .answers[index]
                                                      .id!,
                                                  state.question_with_answer
                                                      .result_id,
                                                  index,
                                                  state
                                                      .question_with_answer
                                                      .problems![index]
                                                      .questions![
                                                          indexQuestions]
                                                      .answers[0]
                                                      .answer_text!,
                                                  "أ",
                                                );
                                              })
                                            ,
                                        AnswerContainer(
                                          label: "ب",
                                          answerText: state
                                              .question_with_answer
                                              .problems![index]
                                              .questions![indexQuestions]
                                              .answers[1]
                                              .answer_text,
                                          answerImage: state
                                              .question_with_answer
                                              .problems![index]
                                              .questions![indexQuestions]
                                              .answers[1]
                                              .answer_image,
                                          onTap: () {
                                            
                                              storeAnswer(
                                                  state.question_with_answer.id,
                                                  state
                                                      .question_with_answer
                                                      .problems![index]
                                                      .questions![index]
                                                      .answers[index]
                                                      .id!,
                                                  state.question_with_answer
                                                      .result_id,
                                                  index,
                                                  state
                                                      .question_with_answer
                                                      .problems![index]
                                                      .questions![
                                                          indexQuestions]
                                                      .answers[1]
                                                      .answer_text!,"ب"
                                              );
                                            },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        AnswerContainer(
                                          label: "ج",
                                          answerText: state
                                              .question_with_answer
                                              .problems![index]
                                              .questions![indexQuestions]
                                              .answers[2]
                                              .answer_text,
                                          answerImage: state
                                              .question_with_answer
                                              .problems![index]
                                              .questions![indexQuestions]
                                              .answers[2]
                                              .answer_image,
                                          onTap: () {
                                           
                                              storeAnswer(
                                                  state.question_with_answer.id,
                                                  state
                                                      .question_with_answer
                                                      .problems![index]
                                                      .questions![index]
                                                      .answers[index]
                                                      .id!,
                                                  state.question_with_answer
                                                      .result_id,
                                                  index,
                                                  state
                                                      .question_with_answer
                                                      .problems![index]
                                                      .questions![
                                                          indexQuestions]
                                                      .answers[2]
                                                      .answer_text!,
                                                  "ج");
                                          
                                          },
                                        ),
                                        AnswerContainer(
                                          label: "د",
                                          answerText: state
                                              .question_with_answer
                                              .problems![index]
                                              .questions![indexQuestions]
                                              .answers[3]
                                              .answer_text,
                                          answerImage: state
                                              .question_with_answer
                                              .problems![index]
                                              .questions![indexQuestions]
                                              .answers[3]
                                              .answer_image,
                                          onTap: () {
                                          
                                              storeAnswer(
                                                  state.question_with_answer.id,
                                                  state
                                                      .question_with_answer
                                                      .problems![index]
                                                      .questions![index]
                                                      .answers[index]
                                                      .id!,
                                                  state.question_with_answer
                                                      .result_id,
                                                  index,
                                                  state
                                                      .question_with_answer
                                                      .problems![index]
                                                      .questions![
                                                          indexQuestions]
                                                      .answers[3]
                                                      .answer_text!,
                                                  "د");
                                           
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
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
                      if (index < totalindex - 1) {
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
for(int i=0;i<4;i+2)
Row(
  children: [
    for(int j=i;j<i+2;j++)
         AnswerContainer(
                                  label: Label[j],
                                  answerText: state
                                      .question_with_answer
                                      .separated_questions[sepratedIndex]
                                      .answers[j]
                                      .answer_text,
                                  answerImage: state
                                      .question_with_answer
                                      .separated_questions[sepratedIndex]
                                      .answers[j]
                                      .answer_image,
                                  onTap: () {
                                   
                                      storeAnswer(
                                          state.question_with_answer.id,
                                          state
                                              .question_with_answer
                                              .separated_questions[
                                                  sepratedIndex]
                                              .answers[j]
                                              .id!,
                                          state.question_with_answer.result_id,
                                          index,
                                          state
                                              .question_with_answer
                                              .separated_questions[
                                                  sepratedIndex]
                                              .answers[j]
                                              .answer_text!,
                                          Label[j]);
                                   
                                  },
                                ),
  ]
),


                            // ////////////
                            // Row(
                            //   children: [
                            //     AnswerContainer(
                            //       label: "أ",
                            //       answerText: state
                            //           .question_with_answer
                            //           .separated_questions[sepratedIndex]
                            //           .answers[0]
                            //           .answer_text,
                            //       answerImage: state
                            //           .question_with_answer
                            //           .separated_questions[sepratedIndex]
                            //           .answers[0]
                            //           .answer_image,
                            //       onTap: () {
                                   
                            //           storeAnswer(
                            //               state.question_with_answer.id,
                            //               state
                            //                   .question_with_answer
                            //                   .separated_questions[
                            //                       sepratedIndex]
                            //                   .answers[0]
                            //                   .id!,
                            //               state.question_with_answer.result_id,
                            //               index,
                            //               state
                            //                   .question_with_answer
                            //                   .separated_questions[
                            //                       sepratedIndex]
                            //                   .answers[0]
                            //                   .answer_text!,
                            //               "أ");
                                   
                            //       },
                            //     ),
                            //     AnswerContainer(
                            //       label: "ب",
                            //       answerText: state
                            //           .question_with_answer
                            //           .separated_questions[sepratedIndex]
                            //           .answers[1]
                            //           .answer_text,
                            //       answerImage: state
                            //           .question_with_answer
                            //           .separated_questions[sepratedIndex]
                            //           .answers[1]
                            //           .answer_image,
                            //       onTap: () {
                                   
                            //           storeAnswer(
                            //               state.question_with_answer.id,
                            //               state
                            //                   .question_with_answer
                            //                   .separated_questions[
                            //                       sepratedIndex]
                            //                   .answers[1]
                            //                   .id!,
                            //               state.question_with_answer.result_id,
                            //               index,
                            //               state
                            //                   .question_with_answer
                            //                   .separated_questions[
                            //                       sepratedIndex]
                            //                   .answers[1]
                            //                   .answer_text!,
                            //               "ب");
                            //                                         },
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   children: [
                            //     AnswerContainer(
                            //       label: "ج",
                            //       answerText: state
                            //           .question_with_answer
                            //           .separated_questions[sepratedIndex]
                            //           .answers[2]
                            //           .answer_text,
                            //       answerImage: state
                            //           .question_with_answer
                            //           .separated_questions[sepratedIndex]
                            //           .answers[2]
                            //           .answer_image,
                            //       onTap: () {
                                   
                            //           storeAnswer(
                            //               state.question_with_answer.id,
                            //               state
                            //                   .question_with_answer
                            //                   .separated_questions[
                            //                       sepratedIndex]
                            //                   .answers[2]
                            //                   .id!,
                            //               state.question_with_answer.result_id,
                            //               index,
                            //               state
                            //                   .question_with_answer
                            //                   .separated_questions[
                            //                       sepratedIndex]
                            //                   .answers[2]
                            //                   .answer_text!,
                            //               "ج");
                                   
                            //       },
                            //     ),
                            //     AnswerContainer(
                            //       label: "د",
                            //       answerText: state
                            //           .question_with_answer
                            //           .separated_questions[sepratedIndex]
                            //           .answers[3]
                            //           .answer_text,
                            //       answerImage: state
                            //           .question_with_answer
                            //           .separated_questions[sepratedIndex]
                            //           .answers[3]
                            //           .answer_image,
                            //       onTap: () {
                                   
                            //           storeAnswer(
                            //               state.question_with_answer.id,
                            //               state
                            //                   .question_with_answer
                            //                   .separated_questions[
                            //                       sepratedIndex]
                            //                   .answers[3]
                            //                   .id!,
                            //               state.question_with_answer.result_id,
                            //               index,
                            //               state
                            //                   .question_with_answer
                            //                   .separated_questions[
                            //                       sepratedIndex]
                            //                   .answers[3]
                            //                   .answer_text!,
                            //               "د");
                                   
                            //       },
                            //     ),
                            //   ],
                            // ),
                          ],
                        );
                      } else {
                        return SendAnswerUI(
                          onTap: () {
                            print("ops");
                            print(selectedAnswers);
                          },
                          itemcount:
                              state.question_with_answer.problems!.length +
                                  state.question_with_answer.separated_questions
                                      .length,
                          list: selectedAnswers,
                        );
                      }
                    }
                  });
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
  const AnswerContainer({
    Key? key,
    required this.answerText,
    required this.answerImage,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.1,
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          color: babyblue,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Lightgreen,
          ),
        ),
        child: answerText != null
            ? Text(
                "$label   $answerText",
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