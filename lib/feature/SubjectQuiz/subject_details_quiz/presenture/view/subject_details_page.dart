// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ibnhyanfinal/core/resourses/assets_manager.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
import 'package:ibnhyanfinal/core/widgets/container_page_subj.dart';
import 'package:ibnhyanfinal/core/widgets/empty_list_msg.dart';
import 'package:ibnhyanfinal/core/widgets/useable_green_container.dart';
import 'package:ibnhyanfinal/feature/Failed/Error.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/presenture/view/question_page.dart';

import 'package:ibnhyanfinal/feature/SubjectQuiz/subject_details_quiz/presenture/bloc/bloc/subject_bloc.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/subject_details_quiz/presenture/view/subject_quiz_card.dart';

enum QuizPageType { subject, unit, lesson }

class SubjectQuizzesPage extends StatelessWidget {
  const SubjectQuizzesPage({
    super.key,
    required this.id,
    required this.type,
  });

  final num id;
  final QuizPageType type;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SubjectdetailsBloc()
          ..add((GetAllSubjectDetailsQuiz(id: id, type: type))),
        child: Builder(builder: (context) {
          return BlocBuilder<SubjectdetailsBloc, SubjectdetailsQuizState>(
            builder: (context, state) {
              if (state is SuucessGetSubjectDetailsQuiz) {
                if (state.quizzes.isEmpty) {
                  return const EmptyListMsg();
                }
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: state.quizzes.length,
                          itemBuilder: (context, index) {
                            // print(index);
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  "/QuizSubjectUi",
                                  arguments: [
                                    state.quizzes[index].id,
                                    state.quizzes[index].time_limit,
                                  ],
                                );
                              },
                              child: QuizCard(quiz: state.quizzes[index]),
                              // ? start
                              // child: Padding(
                              //     padding: EdgeInsets.all(
                              //         MediaQuery.of(context).size.width * 0.02),
                              //     child: Container(
                              //         height:
                              //             MediaQuery.of(context).size.width * 0.3,
                              //         decoration: BoxDecoration(
                              //             boxShadow: [
                              //               BoxShadow(
                              //                   color:
                              //                       Colors.black.withOpacity(0.1),
                              //                   spreadRadius: 2,
                              //                   blurRadius: 6,
                              //                   offset: Offset(2, 2))
                              //             ],
                              //             color: whitegreen,
                              //             borderRadius: const BorderRadius.all(
                              //                 Radius.circular(8)),
                              //             border: Border.all(color: Lightgreen)),
                              //         child: Column(
                              //           children: [
                              //             Text(
                              //               state.subjects[index].name,
                              //               overflow: TextOverflow.ellipsis,
                              //             ),
                              //             FittedBox(
                              //               fit: BoxFit.fill,
                              //               child: Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment.spaceAround,
                              //                 // crossAxisAlignment: CrossAxisAlignment.start,
                              //                 children: [
                              //                   Padding(
                              //                     padding: EdgeInsets.symmetric(
                              //                       horizontal:
                              //                           MediaQuery.of(context)
                              //                                   .size
                              //                                   .width *
                              //                               0.09,
                              //                     ),
                              //                     child: Container(
                              //                       child: Row(
                              //                         children: [
                              //                           Image.asset(clock),
                              //                           Text(": " +
                              //                               state.subjects[index]
                              //                                   .time_limit
                              //                                   .toString() +
                              //                               "دقيقة")
                              //                         ],
                              //                       ),
                              //                     ),
                              //                   ),

                              //                   //SizedBox(width:  MediaQuery.of(context).size.width * 0.01,) ,// Responsive width

                              //                   Container(
                              //                     child: Row(
                              //                       children: [
                              //                         Image.asset(questionmark),
                              //                         Text(": " +
                              //                             state.subjects[index]
                              //                                 .question_count
                              //                                 .toString() +
                              //                             "سؤال"),
                              //                       ],
                              //                     ),
                              //                   )
                              //                 ],
                              //               ),
                              //             )
                              //           ],
                              //         )))
                              // ? end
                              //  ContainerSubject(
                              //     widget: Directionality(
                              //   textDirection: TextDirection.ltr,
                              //   child: ListTile(
                              //     trailing: Text(state.subjects[index].name),
                              //     title: Row(
                              //       children: [
                              //         Text(state.subjects[index].time_limit.toString()+"دقيقة"+":"
                              //             ),
                              //          Image.asset(clock),

                              //       ],
                              //     ),
                              //     subtitle: Row(
                              //       children: [
                              //         Image.asset(questionmark),
                              //         Text(state.subjects[index].question_count
                              //             .toString()),
                              //       ],
                              //     ),
                              //   ),
                              // )),
                            );
                          }),
                    ),
                    // UseableGreenContainer(
                    //   text: 'اختبار شامل للمادة',
                    // ),
                  ],
                );
              } else if (state is ErrorGetSubjectDetailsQuiz) {
                return ErrorUi();
              } else {
                return const Center(
                    child: CircularProgressIndicator(
                  color: green,
                ));
              }
            },
          );
        }));
  }
}
