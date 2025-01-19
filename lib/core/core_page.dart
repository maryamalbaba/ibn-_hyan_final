import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/core/resourses/assets_manager.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
import 'package:ibnhyanfinal/feature/Failed/Error.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/ShowSubject/presenture/view/subject_page.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/presenture/view/question_page.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/revision_quiz/presenture/view/revision_page.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/score/presenture/view/result_exam_ui.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/send_answer_for_subject/data/Model/answer.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/send_answer_for_subject/presenture/view/send_answer_page.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/subject_details_quiz/presenture/view/subject_details_page.dart';
import 'package:ibnhyanfinal/feature/marks/mark_page.dart';
import 'package:ibnhyanfinal/feature/statistics/presenture/view/statistics.dart';

class CorePage extends StatefulWidget {
  const CorePage({super.key});

  static final ValueNotifier<String> page =
      ValueNotifier<String>("/SubjectPage");

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

  static const routesTitles = {
    "/SubjectPage": "المواد",
    "/MarksPage": "العلامات",
    "/StatisticsPage": "الإحصائيات",
    "/SubjectQuizzesPage": "الاختبارات الشاملة",
    "/SubjectUnitsQuizzesPage": "اختبارات الوحدات",
    "/SubjectLessonsQuizzesPage": "اختبارات الدروس",
    "/SendAnswerUI": "إرسال الإجابة",
    "/ResultExamUI": "نتيجة الاختبار",
    "/QuizSubjectUi": "اختبار",
    "/RevisionPage": "مراجعة الاختبار",
    "/ErrorUi": "حصل خطأ",
  };
  int currentIndex = 0;
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
            final route = routesTitles.keys.toList()[currentIndex];
            navigatorKey.currentState?.pushNamedAndRemoveUntil(
              route,
              (route) => !(Navigator.of(context).canPop()),
            );
          },
          selectedIndex: currentIndex,
          animationDuration: const Duration(seconds: 1),
          destinations: [
            NavigationDestination(
              icon: SizedBox.square(
                dimension: 30,
                child: Image.asset(
                  examsIcon,
                  color: Colors.white,
                ),
              ),
              label: "اختبارات",
            ),
            NavigationDestination(
                icon: SizedBox.square(
                    dimension: 30,
                    child: Image.asset(marksIcon, color: Colors.white)),
                label: "علامات المعهد"),
            NavigationDestination(
              icon: SizedBox.square(
                  dimension: 30,
                  child: Image.asset(staisticsIcon, color: Colors.white)),
              label: "نتائج الاتمتة",
            )
          ]),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: ValueListenableBuilder(
          valueListenable: CorePage.page,
          builder: (BuildContext context, String value, Widget? child) {
            return AppBar(
              actions: [
                // if (navigatorKey.currentState?.canPop() ?? false)
                //   BackButton(onPressed: () {
                //     navigatorKey.currentState?.pop();
                //     CorePage.page.value = "";
                //   }),
              ],
              backgroundColor: green,
              title: Text(routesTitles[value] ?? value),
            );
          },
        ),
      ),
      body: Navigator(
          key: navigatorKey,
          initialRoute: "/SubjectPage",
          onGenerateRoute: (RouteSettings setting) {
            Widget page;
            switch (setting.name) {
              case "/SubjectPage":
                page = pages_in_Bar[0];
                break;

              case "/MarksPage":
                page = pages_in_Bar[1];
                break;

              case "/StatisticsPage":
                page = pages_in_Bar[2];
                break;

              case "/SubjectQuizzesPage":
                final num id1 = setting.arguments as num;
                page = SubjectQuizzesPage(id: id1, type: QuizPageType.subject);
                break;

              case "/SubjectUnitsQuizzesPage":
                final num id1 = setting.arguments as num;
                page = SubjectQuizzesPage(id: id1, type: QuizPageType.unit);
                break;

              case "/SubjectLessonsQuizzesPage":
                final num id1 = setting.arguments as num;
                page = SubjectQuizzesPage(id: id1, type: QuizPageType.lesson);
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
                final num result_Id = (setting.arguments as List)[0] as num;
                final List<SentAnswerModel?> list =
                    (setting.arguments as List)[1];
                page = ResultExamUI(resultId: result_Id, list: list);

              case "/QuizSubjectUi":
                final num id2 = (setting.arguments as List)[0] as num;
                final num time_limit = (setting.arguments as List)[1] as num;
                page = QuizSubjectUi(
                  id: id2,
                  time_limit: time_limit,
                );
                break;
              case "/RevisionPage":
                final num id = (setting.arguments as List)[0] as num;
                final List<SentAnswerModel?> list =
                    (setting.arguments as List)[1];
                page = RevisionPage(id: id, list: list);
              case "/ErrorUi":
                page = ErrorUi();

              default:
                page = pages_in_Bar[currentIndex];
                break;
            }
            CorePage.page.value = setting.name ?? "";
            return PageRouteBuilder(
                // pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(opacity: animation, child: page),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return page;
                },
                transitionDuration: const Duration(milliseconds: 500),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                });
          }),
    );
  }
}
