import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/core/widgets/image_container.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/subject_details_quiz/data/Model/Subject.dart';

import '../../../../../core/resourses/assets_manager.dart';
import '../../../../../core/resourses/colors_manager.dart';
import '../../../../../core/widgets/container_page_subj.dart';

class SubjectQuizCard extends StatelessWidget {
  const SubjectQuizCard({super.key, required this.quiz});
  final SubjecDetailsQuizs quiz;

  @override
  Widget build(BuildContext context) {
    final parentName = quiz.lesson_name??quiz.unit_name??quiz.subject_name??"";
    final parentImage = quiz.lesson_image??quiz.unit_image??"";
    if(quiz.subject_id == null){
      return ContainerSubject(
        widget: ListTile(
          leading: ImageContainer(imageUrl: parentImage),
          titleTextStyle: const TextStyle(
              color: green,
              fontSize: 18,
              fontWeight: FontWeight.w400),
          subtitleTextStyle: const TextStyle(
              color: green,
              fontSize: 14,
              fontWeight: FontWeight.w500),
          subtitle: RichText(
            text: TextSpan(
              text: quiz.description,
              style: const TextStyle(color: green),
              children: [
                const TextSpan(text: '\t\t\t\t'),
                WidgetSpan(
                  child: Image.asset(
                    clock,
                  ),
                ),
                TextSpan(
                  text: '\t:\t\t${quiz.time_limit}',
                )
              ],
            ),
          ),
          title: Text(
            quiz.name,
          ),
        ),
      );
    }
    return ContainerSubject(
      widget: ListTile(
        titleTextStyle: const TextStyle(
            color: green,
            fontSize: 18,
            fontWeight: FontWeight.w400),
        subtitleTextStyle: const TextStyle(
            color: green,
            fontSize: 14,
            fontWeight: FontWeight.w500),
        subtitle: Row(
          children: [
            Image.asset(questionmark),
            Text(": ${quiz.question_count}"),
            const Spacer(),
            Image.asset(clock),
            Text(": ${quiz.time_limit}"),
          ],
        ),
        title: Text(
          quiz.name,
        ),
      ),
    );
  }
}
