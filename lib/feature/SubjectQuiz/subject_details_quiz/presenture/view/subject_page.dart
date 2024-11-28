// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ibnhyanfinal/core/resourses/assets_manager.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
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
        return Scaffold(
          backgroundColor: offwhite,
          appBar: AppBar(
            backgroundColor: green,
            title: const Text("اختبارات"),
            leading: Image.asset(user_image),
          ),
          body: BlocBuilder<SubjectdetailsBloc, SubjectdetailsQuizState>(
            builder: (context, state) {
              if (state is SuucessGetSubjectDetailsQuiz) {
                return ListView.builder(
                    itemCount: state.subjects.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizSubjectUi(id: state.subjects[index].id,)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.80,
                                height:MediaQuery.of(context).size.height*0.10,
                                decoration: BoxDecoration(
                                color: babyblue,
                                  borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                  color: Lightgreen,
                                )),
                            child: ListTile(
                                title: Text(state.subjects[index].name),
                                leading: Text(state.subjects[index].description)),
                          ),
                        ),
                      );
                    });
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        );
      }),
    );
  }
}
