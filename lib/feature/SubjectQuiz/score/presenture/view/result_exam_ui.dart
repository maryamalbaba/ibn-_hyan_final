import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnhyanfinal/core/resourses/assets_manager.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
import 'package:ibnhyanfinal/core/widgets/useable_green_container.dart';
import 'package:ibnhyanfinal/feature/Failed/Error.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/score/presenture/bloc/scorebloc_bloc.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/send_answer_for_subject/data/Model/answer.dart';
import 'package:lottie/lottie.dart';

class ResultExamUI extends StatelessWidget {
  const ResultExamUI({super.key, required this.resultId, required this.list});

  final num resultId;
  final List<SentAnswerModel?> list;

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
                    const Spacer(),
                    Image.asset(A_plus, height: 24),
                    Text(
                      "  ${state.result.total_score}/${state.result.score}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18, color: grey),
                    ),
                    const Spacer(),
                    Image.asset(clock2, height: 24),
                    Text(
                      " ${state.result.duration_minutes} ${"minute".tr()}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18, color: grey),
                    ),
                    const Spacer(),
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
                          arguments: [resultId, list]);
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
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
