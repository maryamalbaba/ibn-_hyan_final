// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ibnhyanfinal/core/resourses/assets_manager.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
import 'package:ibnhyanfinal/core/widgets/container_page_subj.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/presenture/view/question_page.dart';

import 'package:ibnhyanfinal/feature/SubjectQuiz/subject_details_quiz/presenture/bloc/bloc/subject_bloc.dart';

class SubjectdetailsQuizPage extends StatelessWidget {
  const SubjectdetailsQuizPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final num id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            SubjectdetailsBloc()..add((GetAllSubjectDetailsQuiz(id: id))),
        child: Builder(builder: (context) {
          return BlocBuilder<SubjectdetailsBloc, SubjectdetailsQuizState>(
            builder: (context, state) {
              if (state is SuucessGetSubjectDetailsQuiz) {
                return ListView.builder(
                    itemCount: state.subjects.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            "/QuizSubjectUi",
                            arguments: [state.subjects[index].id, state.subjects[index].time_limit],
                            
                          );
                        },
                        child: ContainerSubject(
                            widget: Directionality(
                          textDirection: TextDirection.ltr,
                          child: ListTile(
                            trailing: Text(state.subjects[index].name),
                            title: Row(
                              children: [
                                Text(state.subjects[index].time_limit.toString()+"دقيقة"+":"
                                    ),
                                 Image.asset(clock),
                              
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Image.asset(questionmark),
                                Text(state.subjects[index].question_count
                                    .toString()),
                              ],
                            ),
                          ),
                        )),
                      );
                    });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        }));
  }
}
