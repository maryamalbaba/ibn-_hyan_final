import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnhyanfinal/core/resourses/assets_manager.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
import 'package:ibnhyanfinal/core/widgets/useable_green_container.dart';
import 'package:ibnhyanfinal/feature/Failed/Error.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/score/presenture/bloc/scorebloc_bloc.dart';
import 'package:lottie/lottie.dart';

class ResultExamUI extends StatelessWidget {
  ResultExamUI({super.key, required this.resultId});
  final num resultId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ResultExamblocBloc()..add(GetResult(result_Id: resultId)),
      child: BlocBuilder<ResultExamblocBloc, ResultGetExamblocState>(
        builder: (context, state) {
          if (state is SuccessGetResult) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Expanded(
                  flex: 1,
                  child: Text(
                    "finsh exam",
                    style: TextStyle(
                        color: green,
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).size.width * 0.1),
                  ).tr(),
                ),
                Row(
                  children: [
                    Container(
                      child: Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Image.asset(clock2),
                            Text(
                                " " + state.result.duration_minutes.toString()),
                            Text("minute".tr()),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Expanded(
                          flex: 1,
                          child: Row(children: [
                            Image.asset(A_plus),
                            Text(
                                "  ${state.result.total_score}/${state.result.score}")
                          ])),
                    )
                  ],
                ),
                
              
                Expanded(flex: 4, child: Lottie.network(state.result.image)),
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                  child: InkWell(
                    onTap: () {
                      print("push named");
                      Navigator.pushNamed(context, "/RevisionPage",
                          arguments: resultId);
                    },
                    child: UseableGreenContainer(
                      text: 'read answers'.tr(),
                    ),
                  ),
                )
              ],
            );
          } else if (state is FailedGetResult) {
            return ErrorUi();
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
