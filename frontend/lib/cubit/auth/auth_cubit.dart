import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../utils/shared_pref.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());


  final sharedPref = SharedPref();

  Future<void> appStarted() async{

    try{

      final uid = await sharedPref.getUid();

      if(uid != null ){
        emit(AuthAuthenticated(uid));
      }else{
        emit(AuthUnAuthenticated());
      }
    }catch(_){
      emit(AuthUnAuthenticated());
    }

  }

  Future<void> loggedIn(String uid)async{
    sharedPref.setUid(uid);
    emit(AuthAuthenticated(uid));
  }

  Future<void> loggedOut() async{
  sharedPref.setUid("");
  emit(AuthUnAuthenticated());
  }



}
