import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';

import '../../../../core/widgets/statisics_container.dart';
import '../../data/model/statiscis_model.dart';

class StatisticsList extends StatefulWidget {
  const StatisticsList({super.key, required this.listStatistics});

  final List<StatiscisModel> listStatistics;

  @override
  State<StatisticsList> createState() => _StatisticsListState();
}

class _StatisticsListState extends State<StatisticsList> {
  late List<StatiscisModel> shownList = widget.listStatistics;
  late final Set<String?> subjects =
      widget.listStatistics.map((e) => e.subject_name).toSet();
  String? selected;

  onChanged(String? value) {
    if(value==null){
      shownList = widget.listStatistics;
      return;
    }
    shownList = widget.listStatistics.where((element) => element.subject_name == value).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: Lightgreen),
                color: babyblue),
            child: DropdownButton<String?>(
                borderRadius: BorderRadius.circular(7),
                underline: const SizedBox(),
                padding: const EdgeInsets.symmetric(horizontal: 7),
                dropdownColor: babyblue,
                value: selected,
                items: [
                  const DropdownMenuItem(value: null, child: Text("الكل")),
                  ...subjects
                      .map((e) => DropdownMenuItem(value: e, child: Text(e??"-")))
                ],
                onChanged: (value) {
                  onChanged(value);
                  setState(() {
                    selected = value;
                  });
                }),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: shownList.length,
            itemBuilder: (BuildContext context, int index) {
              return StatisicsContainer(
                imageUrl: shownList[index].image,
                Text_quizName: shownList[index].quiz_name!,
                Text_SubjectName: shownList[index].subject_name!,
                totalscore: shownList[index].total_score,
                myscore: shownList[index].score,
              );
            },
          ),
        ),
      ],
    );
  }
}
