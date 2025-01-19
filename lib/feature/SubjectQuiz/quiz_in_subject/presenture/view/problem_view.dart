import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/core/widgets/tex_text_widget.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/data/model/problem.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/data/model/question_model.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/presenture/view/problem_card.dart';
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
        ProblemCard(problem: problem, pinned: false),
        ...problem.questions!.map((e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: QuestionView(
                  result: result,
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
