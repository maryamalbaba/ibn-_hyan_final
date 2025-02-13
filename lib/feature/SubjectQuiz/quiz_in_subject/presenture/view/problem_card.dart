import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnhyanfinal/core/widgets/interactive_image.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/data/model/problem.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/presenture/bloc/bloc/subject_question_bloc.dart';

import '../../../../../core/resourses/colors_manager.dart';
import '../../../../../core/widgets/tex_text_widget.dart';

class ProblemCard extends StatelessWidget {
  const ProblemCard({super.key, required this.problem, required this.pinned});

  final ProblemModel problem;
  final bool pinned;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: pinned? const EdgeInsets.all(8): EdgeInsets.zero,
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Material(
            elevation: pinned? 5:0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(minHeight: 70),
              decoration: BoxDecoration(
                  color: cardYellow,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: cardYellowBorder,
                  )),
              child: Column(
                children: [
                  Center(child: TexTextWidget(problem.problem_text!)),
                  if (problem.problem_image != null)
                    Padding(
                      padding:
                          EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                      child: InkWell(
                        onTap: () {
                          showDialog(context: context, builder: (context) => InteractiveImage(image: problem.problem_image!));
                        },
                        child: Image.network(
                          problem.problem_image!,
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.1,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              context
                  .read<SubjectQuestionBloc>()
                  .togglePinProblem(pinned ? null : problem);
            },
            style: ButtonStyle(
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: amber)))),
            icon: Icon(
              pinned ? Icons.push_pin_outlined : Icons.push_pin,
              color: amber,
            ),
          ),
        ],
      ),
    );
  }
}
