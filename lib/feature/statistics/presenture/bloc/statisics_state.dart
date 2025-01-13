part of 'statisics_bloc.dart';

@immutable
sealed class StatisicsState {}

final class StatisicsInitial extends StatisicsState {}
final class StatisticstInitial extends StatisicsState {}

// ignore: must_be_immutable
class SuucessGetStatisics extends StatisicsState {
 List< StatiscisModel> List_Statistics;
  SuucessGetStatisics({
    required this.List_Statistics,
  });
}

class ErrorGetStatistics extends StatisicsState {}

class ExceptionGetStatistics extends StatisicsState {}

class LoadingGetStatistics extends StatisicsState {}
