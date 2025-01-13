import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ibnhyanfinal/core/Models/Error.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/ShowSubject/data/service/subject_ser.dart';
import 'package:ibnhyanfinal/feature/statistics/data/model/statiscis_model.dart';
import 'package:ibnhyanfinal/feature/statistics/data/service/statistics_service.dart';
import 'package:meta/meta.dart';

part 'statisics_event.dart';
part 'statisics_state.dart';

class StatisicsBloc extends Bloc<StatisicsEvent, StatisicsState> {
  StatisicsBloc() : super(StatisicsInitial()) {
    on<StatisicsEvent>((event, emit) async {
      // TODO: implement event handler
         emit(LoadingGetStatistics());

      try {
        Either<ErrorModel, List<StatiscisModel>> result =
            await StatisticsService().getsubject();
        result.fold((error) {
          emit(ErrorGetStatistics());
        }, (statistics) {
          emit(SuucessGetStatisics(List_Statistics: statistics));
        });
      } catch (e) {
        emit(ErrorGetStatistics());
      }
    });
  }
}
