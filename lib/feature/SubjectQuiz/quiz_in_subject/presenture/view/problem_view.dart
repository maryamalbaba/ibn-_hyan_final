import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/data/model/problem.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/data/model/question_model.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/presenture/view/question_view.dart';

import '../../../../../core/resourses/colors_manager.dart';
import '../../data/model/answer_model.dart';

class ProblemView extends StatelessWidget {
  const ProblemView({
    super.key,
    required this.problem,
    required this.selected,
    this.onAnswer,
    this.result = false,
  });

  final ProblemModel problem;
  final int? Function(QuestionModel question) selected;
  final bool result;
  final void Function(
      QuestionModel question, int answer_index, AnswerModel answer)? onAnswer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: babyblue,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Lightgreen,
              )),
          child: Column(
            children: [
              Center(child: Text(problem.problem_text!)),
              if (problem.problem_image != null)
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                  child: Image.network(
                    problem.problem_image!,
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.1,
                    fit: BoxFit.scaleDown,
                  ),
                )
            ],
          ),
        ),
        ...problem.questions!.map((e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: QuestionView(
                  result: true,
                  nameWithoutCard: true,
                  question: e,
                  selected: selected(e),
                  onAnswer: onAnswer),
            )),
        const Divider(color: green),
      ],
    );
  }
}
