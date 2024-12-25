
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ibnhyanfinal/core/resourses/styles_manager.dart';
import 'package:ibnhyanfinal/core/widgets/container_page_subj.dart';
import 'package:ibnhyanfinal/feature/Failed/Error.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/ShowSubject/presenture/bloc/bloc/subject_bloc.dart';


class SubjectPage extends StatelessWidget {
  const SubjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubjectBloc()..add(GetAllSubject()),
      child: Builder(builder: (context) {
        return
          
            BlocBuilder<SubjectBloc, SubjectState>(
          builder: (context, state) {
            if (state is SuucessGetSubject) {
              return Column(
                
                children: [  SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                 
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: state.subjects.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                           
                            Navigator.of(context).pushNamed(
                                "/SubjectdetailsQuizPage",
                                arguments: state.subjects[index].id);
                          },
                          child:ContainerSubject(
                              widget: 
                               Center(
                                 child: ListTile(
                                    title: Text(state.subjects[index].name,
                                        style: style_subject_word),
                                    leading: Padding(
                                        padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                        child: Image.network(
                                          state.subjects[index].image,
                                        )),
                                  ),
                               ),
                              
                            ),
                          );
                  
                      }),
                ),
              ]);
            } 
            else if(state is ErrorGetSubject)
            {
              return ErrorUi();
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      }),
    );
  }
}
