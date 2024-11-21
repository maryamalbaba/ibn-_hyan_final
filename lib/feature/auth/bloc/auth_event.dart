// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  
}
// ignore: must_be_immutable
class SignEvent extends AuthEvent {
UserRequest user;
  SignEvent({
    required this.user,
  });
}

