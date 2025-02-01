import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
import 'package:ibnhyanfinal/core/widgets/statisics_container.dart';
import 'package:ibnhyanfinal/feature/statistics/presenture/bloc/statisics_bloc.dart';
import 'package:ibnhyanfinal/feature/statistics/presenture/view/statistics_list.dart';
import 'package:shimmer/shimmer.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatisicsBloc()..add(GetAllStatistics()),
      child: BlocBuilder<StatisicsBloc, StatisicsState>(
        builder: (context, state) {
          if (state is SuucessGetStatisics) {
            return StatisticsList(listStatistics: state.List_Statistics);
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
