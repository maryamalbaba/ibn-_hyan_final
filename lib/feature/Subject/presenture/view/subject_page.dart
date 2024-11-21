import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnhyanfinal/core/resourses/assets_manager.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
import 'package:ibnhyanfinal/feature/Subject/presenture/bloc/bloc/subject_bloc.dart';

import 'package:ibnhyanfinal/feature/subject_details_quiz/presenture/view/subject_page.dart';

class SubjectPage extends StatelessWidget {
  const SubjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubjectBloc()..add(GetAllSubject()),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: offwhite,
          appBar: AppBar(
            title: const Text("subjects").tr(),
            leading: Image.asset(user_image),
          ),
          body: BlocBuilder<SubjectBloc, SubjectState>(
            builder: (context, state) {
              if (state is SuucessGetSubject) {
                return ListView.builder(
                    itemCount: state.subjects.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {

                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SubjectdetailsQuizPage(id: state.subjects[index].id)));
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(state.subjects[index].name),
                            leading: Image.network(state.subjects[index].image),
                          ),
                        ),
                      );
                    });
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        );
      }),
    );
  }
}
