import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/core/widgets/image_container.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/subject_details_quiz/data/Model/Subject.dart';

import '../../../../../core/resourses/assets_manager.dart';
import '../../../../../core/resourses/colors_manager.dart';
import '../../../../../core/widgets/container_page_subj.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({super.key, required this.quiz});

  final SubjecDetailsQuizs quiz;

  @override
  Widget build(BuildContext context) {
    final parentName =
        quiz.lesson_name ?? quiz.unit_name ?? quiz.subject_name ?? "";
    final parentImage = quiz.lesson_image ?? quiz.unit_image ?? "";
    if (quiz.subject_id == null) {
      return ContainerSubject(
        height: 83,
        widget: Row(
          children: [
            ClipRRect(
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(8)),
                child: ImageContainer(imageUrl: parentImage, width: 83)),
            // const SizedBox(width: 20),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(quiz.name,
                      style: const TextStyle(
                          color: green,
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                  Row(children: [
                    Text(parentName,
                        style: const TextStyle(
                            color: green,
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                    const Spacer(),
                    Image.asset(clock, height: 18),
                    Text(": ${quiz.time_limit} دقيقة",
                        style: const TextStyle(
                            color: green,
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                  ]),
                ],
              ),
            )),
          ],
        ),
      );
    }
    return ContainerSubject(
      height: 83,
      widget: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 40),
        titleTextStyle: const TextStyle(
            color: green, fontSize: 18, fontWeight: FontWeight.w400),
        subtitleTextStyle: const TextStyle(
            color: green, fontSize: 14, fontWeight: FontWeight.w400),
        subtitle: Row(
          children: [
            Image.asset(questionmark, height: 18),
            Text(": ${quiz.question_count} سؤال"),
            const Spacer(),
            Image.asset(clock, height: 18),
            Text(": ${quiz.time_limit} دقيقة"),
          ],
        ),
        title: Text(
          quiz.name,
        ),
      ),
    );
  }
}
