import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/core/resourses/assets_manager.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/ShowSubject/presenture/view/subject_page.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/presenture/view/question_page.dart';
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
final GlobalKey<NavigatorState>navigatorKey=GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: offwhite,
      
      bottomNavigationBar:
       NavigationBar(
     indicatorColor:green,
        backgroundColor:green,
         labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        onDestinationSelected: (newDestenaition) {
          setState(() {
       currentIndex=newDestenaition;
          });
          navigatorKey.currentState?.pushReplacement(MaterialPageRoute(builder: (context)=>pages_in_Bar[currentIndex]));
        },
        selectedIndex: currentIndex,
        animationDuration: const Duration(seconds: 1),
        destinations: [
        NavigationDestination(icon: Image.asset(examsIcon), label: "اختبارات"),
        NavigationDestination(icon: Image.asset(marksIcon), label: "علامات"),

        NavigationDestination(
            icon: Image.asset(staisticsIcon), label: "احصائيات")
      ]),
      appBar: AppBar(
        backgroundColor: green,
      ),
      body: 
      Navigator(
        key: navigatorKey,
        onGenerateRoute: (RouteSettings setting) {
        Widget page;
        switch (setting.name) {


            case "/SubjectdetailsQuizPage":
            final num id1=setting.arguments as num ;
            page= SubjectdetailsQuizPage(id:id1);
            break;

            case "/QuizSubjectUi":
            final num  id2=setting.arguments as num;
            page= QuizSubjectUi(id: id2,);
            break;

          default:
            page = pages_in_Bar[currentIndex];
            break;
        }
        return MaterialPageRoute(builder: (context) => page);
      }),
    );
  }
}
