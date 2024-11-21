part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class ErrorSign extends AuthState {}
class ExceptionSign extends AuthState {}
class WronginputException extends AuthState{}
class nointernetException extends AuthState{}
class SuccessSign extends AuthState {}

class LoadingSign extends AuthState {}
