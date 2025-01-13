import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
import 'package:ibnhyanfinal/feature/statistics/presenture/bloc/statisics_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';

class StatisticsPage extends StatelessWidget {
  StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatisicsBloc()..add(GetAllStatistics()),
      child: BlocBuilder<StatisicsBloc, StatisicsState>(
        builder: (context, state) {
          if (state is SuucessGetStatisics) {
            return ListView.builder(
              itemCount: state.List_Statistics.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.04,
                  ),
                  decoration: BoxDecoration(
                      color: babyblue,
                      border: Border.all(color: greygreen),
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.22,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child:
                            Lottie.network(state.List_Statistics[index].image),
                        fit: FlexFit.loose,
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.loose,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.width * 0.04,
                                bottom:
                                    MediaQuery.of(context).size.width * 0.005,
                              ),
                              child: Text(
                                state.List_Statistics[index].quiz_name!,
                                style: TextStyle(
                                    color: green, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(state.List_Statistics[index].subject_name!,
                                style: TextStyle(
                                  color: green,
                                )),
                            Text(
                              state.List_Statistics[index].score.toString() +
                                  "/" +
                                  state.List_Statistics[index].total_score
                                      .toString(),
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return ListView.builder(
                itemCount: 3,
                itemBuilder: (context, int index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[200]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      margin: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.03,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: greygreen),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
