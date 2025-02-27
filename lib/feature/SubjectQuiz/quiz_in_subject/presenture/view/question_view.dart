// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/core/widgets/interactive_image.dart';
import 'package:ibnhyanfinal/core/widgets/tex_text_widget.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/data/model/answer_model.dart';

import '../../../../../core/resourses/colors_manager.dart';
import '../../../send_answer_for_subject/data/Model/answer.dart';
import '../../data/model/question_model.dart';
import 'answer_container.dart';
import 'question_page.dart';

class QuestionView extends StatelessWidget {
  const QuestionView({
    super.key,
    this.nameWithoutCard = false,
    required this.question,
    required this.selected,
    this.onAnswer,
    this.result = false,
    required this.index,
  });

  final QuestionModel question;
  final bool nameWithoutCard;
  final int? selected;
  final bool result;
  final int index;
  final void Function(
      QuestionModel question, int answer_index, AnswerModel answer)? onAnswer;
  static const List<String> label = ["A", "B", "C", "D"];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          // width: MediaQuery.of(context).size.width * 0.9,
          decoration: nameWithoutCard
              ? null
              : BoxDecoration(
                  color: cardYellow,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: cardYellowBorder,
                  )),
          // alignment: nameWithoutCard? AlignmentDirectional.centerStart: null,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: nameWithoutCard
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsetsDirectional.only(end: 8),
                    height: 20,
                    width: 20,
                    decoration: nameWithoutCard
                        ? const ShapeDecoration(
                            color: green, shape: CircleBorder())
                        : null,
                    alignment: Alignment.center,
                    child: Text("${index + 1}",
                        style: TextStyle(
                            color: nameWithoutCard ? Colors.white : amber)),
                  ),
                  Flexible(
                      fit: FlexFit.tight,
                      child: TexTextWidget2(question.question_text)),
                ],
              ),
              question.question_image
                          // testImage
                          !=
                          null &&
                      question
                          .question_image!
                          // testImage
                          .isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.01),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => InteractiveImage(
                                  image: question.question_image!));
                        },
                        child: Image.network(
                          // testImage,
                          question.question_image!,
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: 0.001,
                      width: 0.001,
                    )
            ],
          )),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: Row(
          children: [
            Text("${question.score} درجة",
                style: const TextStyle(
                    color: darkergreen, fontWeight: FontWeight.w700)),
            const SizedBox(width: 15),
            Flexible(
                fit: FlexFit.tight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(question.source,
                        style: const TextStyle(
                            color: darkergreen, fontWeight: FontWeight.w700)),
                  ],
                )),
          ],
        ),
      ),
      //!answers for seprated Question
      SizedBox(
        width: MediaQuery.of(context).size.width * .9,
        child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 20,
            spacing: 5,
            children: List.generate(
              question.answers.length,
              (answer_index) {
                final answer = question.answers[answer_index];
                // print("$selected:${answer.id}");
                final answer_selected = !result && selected == answer_index;
                final selected_wrong = result &&
                    selected == answer.id &&
                    !(answer.is_correct == 1);
                final selected_correct =
                    result && selected == answer.id && answer.is_correct == 1;
                final correction =
                    result && selected != answer.id && answer.is_correct == 1;
                return AnswerContainer(
                  borderColor: correction
                      ? correctBorder
                      : selected_wrong
                          ? wrongBorder
                          : selected_correct || answer_selected
                              ? yellow
                              : Lightgreen,
                  color: selected_wrong
                      ? wrong
                      : correction || selected_correct
                          ? correct
                          : null,
                  borderWidth: correction ||
                          answer_selected ||
                          selected_wrong ||
                          selected_correct
                      ? 2
                      : 1,
                  label: label[answer_index],
                  answerText: answer.answer_text,
                  answerImage: answer.answer_image,
                  onTap: () {
                    if (onAnswer != null) {
                      onAnswer!(question, answer_index, answer);
                    }
                  },
                );
              },
            )),
      ),
    ]);
  }
}
