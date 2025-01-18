import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
import 'package:ibnhyanfinal/core/resourses/styles_manager.dart';
import 'package:ibnhyanfinal/feature/Failed/Error.dart';
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
                Row(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.all(2),
                            child: Center(
                              child: Text(
                                "التاريخ",
                                style: style_font_marks,
                              ),
                            ),
                          ),
                        ),
                        verticalDivDer(),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.all(2),
                            child: Center(
                              child: Text(
                                "اسم الاختبار",
                                style: style_font_marks,
                              ),
                            ),
                          ),
                        ),
                        verticalDivDer(),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.all(2),
                            child: Center(
                              child: Text(
                                "المادة",
                                textAlign: TextAlign.center,
                                style: style_font_marks,
                              ),
                            ),
                          ),
                        ),
                        verticalDivDer(),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(2),
                            child: Center(
                              child: Text(
                                "الدرجة",
                                style: style_font_marks,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        // const verticalDivDer(),
                        // Expanded(
                        //   flex: 2,
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(0),
                        //     child: Center(
                        //       child: Text(
                        //         "العلامة العظمى",
                        //         textAlign: TextAlign.center,
                        //         style: style_font_marks.copyWith(fontSize: 12),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ]),
                const Divider(color: Lightgreen, height: 0),
                Expanded(
                  child: ListView.builder(
                      itemCount: state.list.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        state.list[index].date,
                                        textAlign: TextAlign.center,
                                        style: style_font_marks,
                                      ),
                                    ),
                                  ),
                                  const verticalDivDer(),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),

                                      child: Text(
                                        state.list[index].exam_name,
                                        textAlign: TextAlign.center,
                                        style: style_font_marks,
                                      ),
                                    ),
                                  ),
                                  const verticalDivDer(),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),

                                      child: Text(
                                        textAlign: TextAlign.center,
                                        state.list[index].subject_name,
                                        style: style_font_marks,
                                      ),
                                    ),
                                  ),
                                  const verticalDivDer(),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${state.list[index].my_score}",
                                            textAlign: TextAlign.center,
                                            style: style_font_marks,
                                          ),
                                          const Divider(color: Colors.black, height: 2, indent: 5, endIndent: 5),
                                          Text(
                                            "${state.list[index].total_score}",
                                            textAlign: TextAlign.center,
                                            style: style_font_marks,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // const verticalDivDer(),
                                  // Expanded(
                                  //   flex: 2,
                                  //   child: Padding(
                                  //     padding: EdgeInsets.all(
                                  //         MediaQuery.of(context).size.width *
                                  //             0.04),
                                  //     child: Text(
                                  //       state.list[index].total_score
                                  //           .toString(),
                                  //       style: style_font_marks,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            const Divider(color: Lightgreen, height: 0),
                          ],
                        );
                      }),
                ),
              ],
            );
            // ! Refactor the states of Failed and Re-Order it
          } else if (state is FailedGetMarks) {
            return ErrorUi();
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: green,
              ),
            );
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
          child: const Divider(
            color: Lightgreen,
            height: 0,
            thickness: 1,
          ),
        ));
  }
}
