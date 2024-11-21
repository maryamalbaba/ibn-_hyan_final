import 'package:bloc/bloc.dart';
import 'package:ibnhyanfinal/core/Error/Exception.dart';
import 'package:ibnhyanfinal/core/Error/failure.dart';
import 'package:ibnhyanfinal/core/Models/Result.dart';
import 'package:ibnhyanfinal/feature/auth/model/response_user.dart';
import 'package:ibnhyanfinal/feature/auth/model/usermodel.dart';
import 'package:ibnhyanfinal/feature/auth/service/real/sign_ser.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignEvent>((event, emit) async {
      Auth auth = Auth();
      Result serviceResult = await auth.sign(event.user);
      emit(LoadingSign());
      print("hi from bloc");
      if (serviceResult is user_response) {
        print("hi from succes bloc");
        emit(SuccessSign());}
        //
        if (serviceResult is wronginputFailure) {
          emit(WronginputException());
        }
      if(serviceResult is offlineException){
        emit( nointernetException());
      }
      else {
        emit(ErrorSign());
        print("hi from error bloc");
      }
    });
  }
}
