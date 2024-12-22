import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
import 'package:ibnhyanfinal/core/resourses/styles_manager.dart';
import 'package:ibnhyanfinal/feature/marks/presenture/bloc/marks_bloc.dart';

class MarksPage extends StatelessWidget {
  const MarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MarksBloc()..add(GetmarksEvent()),
      child: BlocConsumer<MarksBloc, MarksState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is SuccessGetMarks) {
            return Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.2,
                    child: Row(children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            0.03),
                                    child: Text(
                                      "التاريخ",
                                      style: style_font_marks,
                                    ),
                                  )),
                            ),
                            verticalDivDer(),
                            Expanded(
                              flex: 1,
                              child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            0.01),
                                    child: Text(
                                      "س/م",
                                      style: style_font_marks,
                                    ),
                                  )),
                            ),
                            verticalDivDer(),
                            Expanded(
                              flex: 2,
                              child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            0.03),
                                    child: Text(
                                      "المادة",
                                      style: style_font_marks,
                                    ),
                                  )),
                            ),
                            verticalDivDer(),
                            Expanded(
                              flex: 2,
                              child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Text(
                                    "العلامة المستحقة",
                                    style: style_font_marks,
                                  )),
                            ),
                            verticalDivDer(),
                            Expanded(
                              flex: 2,
                              child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Text(
                                    "العلامة العظمى",
                                    style: style_font_marks,
                                  )),
                            ),
                          ],
                        ),
                      )
                    ])),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Divider(
                      color: Lightgreen,
                    )),
                Expanded(
                  child: ListView.builder(
                      itemCount: state.list.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.01),
                                          child: Text(
                                            state.list[index].date,
                                            style: style_font_marks,
                                          ),
                                        )),
                                  ),
                                  verticalDivDer(),
                                  Expanded(
                                    flex: 1,
                                    child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.01),
                                          child: Text(
                                            state.list[index].exam_name,
                                            style: style_font_marks,
                                          ),
                                        )),
                                  ),
                                  verticalDivDer(),
                                  Expanded(
                                    flex: 2,
                                    child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.01),
                                          child: Text(
                                            state.list[index].subject_name,
                                            style: style_font_marks,
                                          ),
                                        )),
                                  ),
                                  verticalDivDer(),
                                  Expanded(
                                    flex: 2,
                                    child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04),
                                          child: Text(
                                            state.list[index].my_score
                                                .toString(),
                                            style: style_font_marks,
                                          ),
                                        )),
                                  ),
                                  verticalDivDer(),
                                  Expanded(
                                    flex: 2,
                                    child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04),
                                          child: Text(
                                            state.list[index].total_score
                                                .toString(),
                                            style: style_font_marks,
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Lightgreen,
                            )
                          ],
                        );
                      }),
                ),
              ],
            );
          } else {
            return Center(child: const CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class verticalDivDer extends StatelessWidget {
  const verticalDivDer({super.key});

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
        quarterTurns: 1,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Divider(
            color: Lightgreen,
            thickness: 1,
          ),
        ));
  }
}
