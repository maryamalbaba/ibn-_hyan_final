import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/core/widgets/tex_text_widget.dart';

import '../../../../../core/resourses/colors_manager.dart';

class AnswerContainer extends StatelessWidget {
  final String? answerText;
  final String? answerImage;
  final String label;
  final VoidCallback onTap;
  Color? borderColor;
  Color? color;
  double? borderWidth;

  AnswerContainer(
      {super.key,
      required this.answerText,
      required this.answerImage,
      required this.label,
      required this.onTap,
      this.borderColor,
      this.color,
      this.borderWidth
      // required this.ispressesd,
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width * .42,
            maxWidth: MediaQuery.of(context).size.width * .9,
          ),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color??babyblue,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: borderColor!,
              width: borderWidth ?? 1,
            ),
          ),
          child: Column(
            children: [
              answerText != null
                  ? TexTextWidget(
                      "  $label   $answerText",
                      style: const TextStyle(fontSize: 16),
                    )
                  : const Text(""),
              answerImage != null
                  ? Image.network(
                      answerImage!,
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.1,
                    )
                  : const SizedBox(
                      height: 0.001,
                      width: 0.001,
                    )
            ],
          )),
    );
  }
}
