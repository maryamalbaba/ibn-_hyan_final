import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnhyanfinal/core/resourses/assets_manager.dart';
import 'package:ibnhyanfinal/core/widgets/useable_green_container.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/score/presenture/bloc/scorebloc_bloc.dart';

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
              children: [
                Text("finsh exam").tr(),
                Container(
                  child: Row(
                    children: [
                      Text(state.result.duration_minutes.toString()),
                      Text("minute".tr()),
                      Image.asset(A_plus)
                    ],
                  ),
                ),
                Container(
                    child: Row(children: [
                      Image.asset(clock2),
                  Text("${state.result.total_score}/${state.result.score}")
                ])),
                Image.network(state.result.image),
                Useable_Green_container(
                  text: 'read answers'.tr(),
                )
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
