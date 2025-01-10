import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/core/resourses/assets_manager.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
import 'package:ibnhyanfinal/feature/Failed/Error.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/ShowSubject/presenture/view/subject_page.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/data/model/answer_model.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/presenture/view/question_page.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/revision_quiz/presenture/view/revision_page.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/score/presenture/view/result_exam_ui.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/send_answer_for_subject/data/Model/answer.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/send_answer_for_subject/presenture/view/send_answer_page.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/subject_details_quiz/presenture/view/subject_page.dart';
import 'package:ibnhyanfinal/feature/marks/mark_page.dart';
import 'package:ibnhyanfinal/feature/statistics/statistics.dart';

class CorePage extends StatefulWidget {
  CorePage({super.key});

  @override
  State<CorePage> createState() => _CorePageState();
}

class _CorePageState extends State<CorePage> {
  // ignore: non_constant_identifier_names
  List<Widget> pages_in_Bar = [
    const SubjectPage(),
    const MarksPage(),
    const StatisticsPage(),
  ];

  int currentIndex = 2;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: offwhite,
      bottomNavigationBar: NavigationBar(
          indicatorColor: green,
          backgroundColor: green,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          onDestinationSelected: (newDestenaition) {
            setState(() {
              currentIndex = newDestenaition;
            });
            navigatorKey.currentState?.pushReplacement(MaterialPageRoute(
                builder: (context) => pages_in_Bar[currentIndex]));
          },
          selectedIndex: currentIndex,
          animationDuration: const Duration(seconds: 1),
          destinations: [
            NavigationDestination(
                icon: Image.asset(examsIcon), label: "اختبارات",),
            NavigationDestination(
                icon: Image.asset(marksIcon), label: "علامات"),
            NavigationDestination(
                icon: Image.asset(staisticsIcon), label: "احصائيات")
          ]),
      appBar: AppBar(
        backgroundColor: green,
      ),
      body: Navigator(
          key: navigatorKey,
          onGenerateRoute: (RouteSettings setting) {
            Widget page;
            switch (setting.name) {
              case "/SubjectdetailsQuizPage":
                final num id1 = setting.arguments as num;
                page = SubjectdetailsQuizPage(id: id1);
                break;

              case "/SendAnswerUI":
                final int itemcount = (setting.arguments as List)[0];
                final List<SentAnswerModel> list =
                    (setting.arguments as List)[1];

                final num result_Id = (setting.arguments as List)[2];
                final Timer timer = (setting.arguments as List)[3];

                page = SendAnswerUI(
                  itemcount: itemcount,
                  list: list,
                  result_Id: result_Id,
                  timer: timer,
                );

              case "/ResultExamUI":
                final num result_Id = (setting.arguments) as num;
                page = ResultExamUI(resultId: result_Id);

              case "/QuizSubjectUi":
                final num id2 = (setting.arguments as List)[0] as num;
                final num time_limit = (setting.arguments as List)[1] as num;
                page = QuizSubjectUi(
                  id: id2,
                  time_limit: time_limit,
                );
                break;
              case "/RevisionPage":
                final num id = (setting.arguments) as num;
                page = RevisionPage(
                  id: id,
                );
              case "/ErrorUi":
                page = ErrorUi();

              default:
                page = pages_in_Bar[currentIndex];
                break;
            }
            return MaterialPageRoute(builder: (context) => page);
          }),
    );
  }
}
