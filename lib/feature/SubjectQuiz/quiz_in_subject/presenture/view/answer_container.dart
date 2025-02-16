import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/core/widgets/interactive_image.dart';
import 'package:ibnhyanfinal/core/widgets/tex_text_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
      onDoubleTap: () {
        if (answerImage != null) {
          showDialog(
              context: context,
              builder: (context) => InteractiveImage(image: answerImage!));
        }
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width * .42,
            maxWidth: MediaQuery.of(context).size.width * .9,
          ),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color ?? babyblue,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: borderColor!,
              width: borderWidth ?? 1,
            ),
          ),
          child: Column(
            children: [
              if (answerText != null)
                TexTextWidget2(
                  "  $label   ${answerText ?? ""}",
                ),
              if (answerImage != null)
                // InkWell(
                //   onDoubleTap: () {
                //   //  onTap;
                //     showDialog(
                //         context: context,
                //         builder: (context) => Dialog(
                //               child: Padding(
                //                 padding: const EdgeInsets.all(8.0),
                //                 child: InteractiveViewer(
                //                     child: Image.network(
                //                   answerImage!,
                //                   fit: BoxFit.fill,
                //                 )),
                //               ),
                //             ));
                // },
                // child:
                Image.network(
                  answerImage!,
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
              // )
            ],
          )),
    );
  }
}
