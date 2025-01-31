import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';

import 'main_filled_button.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({super.key, this.title = "", required this.onConfirm, this.child});

  final String title;
  final Widget? child;
  final Future<void> Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 250,
        width: 450,
        child: Dialog(
          insetPadding: const EdgeInsets.all(8),
          backgroundColor: offwhite,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "هل أنت متأكد $title",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, color: green),
                ),
                if(child !=null)
                child!,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MainFilledButton(
                        text: "إلغاء",
                        onTap: () {
                          Navigator.pop(context);
                        }),
                    if(onConfirm !=null)
                    MainFilledButton(
                        text: "تأكيد",
                        onTap: () {
                          onConfirm!();
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
