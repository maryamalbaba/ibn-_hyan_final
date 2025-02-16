import 'package:flutter/material.dart';
import 'package:latext/latext.dart';

import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class TexTextWidget extends StatelessWidget {
  const TexTextWidget(this.text, {super.key, this.style});

  final String text;
  final TextStyle? style;

  List<String> splitByDollar(String input) {
    // Split the input string by dollar sign
    List<String> parts = input.split('\$');

    // Initialize an empty list to store the results
    List<String> result = [];

    // Iterate through the parts and wrap expressions in dollar signs
    for (int i = 0; i < parts.length; i++) {
      if (i % 2 == 0) {
        // Plain text part
        result.add(parts[i]);
      } else {
        // Expression part, wrap it in dollar signs
        result.add("\$${parts[i]}\$");
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final texts = splitByDollar(text);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Wrap(
        spacing: 2,
        runSpacing: 5,
        textDirection: TextDirection.rtl,
        crossAxisAlignment: WrapCrossAlignment.end,
        children:
        List.generate(
          texts.length,
          (index) {
            if (index % 2 == 0) {
              return Text(texts[index],
                  style: style, textDirection: TextDirection.rtl);
            }
            return LaTexT(
                equationStyle: style,
                laTeXCode: Text(texts[index],
                    style: style, textDirection: TextDirection.rtl));
          },
        ),
      ),
    );
  }
}


class TexTextWidget2 extends StatelessWidget {
  const TexTextWidget2(this.text, {super.key, this.style});

  final String text;
  final TextStyle? style;

  List<String> splitByDollar(String input) {
    List<String> parts = input.split('\$');
    List<String> result = [];

    for (int i = 0; i < parts.length; i++) {
      if (i % 2 == 0) {
        result.add(parts[i]); // نص عادي
      } else {
        result.add("\$${parts[i]}\$"); // معادلة رياضية
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final texts = splitByDollar(text);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Wrap(
        spacing: 2,
        runSpacing: 5,
        textDirection: TextDirection.rtl,
        crossAxisAlignment: WrapCrossAlignment.end,
        children: List.generate(
          texts.length,
          (index) {
            if (index % 2 == 0) {
              return Text(
                texts[index],
                style: style,
                textDirection: TextDirection.rtl,
              );
            }
            return Math.tex(
              texts[index].replaceAll("\$", ""), // إزالة علامات الدولار
              textStyle: style,
              mathStyle: MathStyle.text, // لجعل المعادلة مضمنة في النص
            );
          },
        ),
      ),
    );
  }
}
