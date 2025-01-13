import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';

import 'package:ibnhyanfinal/core/resourses/styles_manager.dart';
import 'package:ibnhyanfinal/core/widgets/container_page_subj.dart';
import 'package:ibnhyanfinal/core/widgets/image_container.dart';
import 'package:ibnhyanfinal/feature/Failed/Error.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/ShowSubject/presenture/bloc/bloc/subject_bloc.dart';

import 'main_outline_button.dart';

class SubjectPage extends StatelessWidget {
  const SubjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubjectBloc()..add(GetAllSubject()),
      child: Builder(builder: (context) {
        return BlocBuilder<SubjectBloc, SubjectState>(
          builder: (context, state) {
            if (state is SuucessGetSubject) {
              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.subjects.length,
                      itemBuilder: (context, index) {
                        return ContainerSubject(
                          widget: Center(
                            child: ListTile(
                              isThreeLine: true,
                              title: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            0.02),
                                    child: ImageContainer(
                                        imageUrl: state.subjects[index].image),
                                  ),
                                  Text(state.subjects[index].name,
                                      style: style_subject_word),
                                ],
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(
                                      child: MainOutlineButton(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              "/SubjectQuizzesPage",
                                              arguments:
                                                  state.subjects[index].id);
                                        },
                                        color: red,
                                        title: "شامل",
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Flexible(
                                      child: MainOutlineButton(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                            "/SubjectUnitsQuizzesPage",
                                            arguments: state.subjects[index].id,
                                          );
                                        },
                                        color: yellow,
                                        title: "وحدة",
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: MainOutlineButton(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              "/SubjectLessonsQuizzesPage",
                                              arguments:
                                                  state.subjects[index].id);
                                        },
                                        color: green,
                                        title: "درس",
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is ErrorGetSubject) {
              return ErrorUi();
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                color: green,
              ));
            }
          },
        );
      }),
    );
  }
}
