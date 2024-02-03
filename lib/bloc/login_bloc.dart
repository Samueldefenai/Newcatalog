import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository loginRepository;
  LoginBloc({required this.loginRepository}): super(LoginInitial()){
    on<LoginInitialEvent>(_initialevent);
    on<ProsesLogin>(_prosesloginevent);
    on<ProsesLogout>(_proseslogoutevent);
  }
  
  _initialevent(LoginInitialEvent event, Emitter emit) async {
    emit(LoginLoading());
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String sessionToken = preferences.getString('session') ?? "";
    final String sessionName = preferences.getString('nama') ?? "";
    if(sessionToken == ""){
      emit(LoginInitial());
    }else {
      bool result = await loginRepository.checkSession(sessionToken);
      if(result == true){
        emit(LoginSuccess(session: sessionToken, name: sessionName));
      }else{
        emit(LoginInitial());
      }
    }
  }
  
  _prosesloginevent(ProsesLogin event, Emitter emit) async {
    String username = event.username;
    String password = event.password;
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String sessionName = preferences.getString('nama') ?? "";
    emit(LoadingLogin());
    //conditional
    Map res = await loginRepository.login(username: username, password: password);
    if (res['status'] == true) {
      emit(LoginSuccess(session: res['data']['session_token'], name: sessionName));
    }else{
      emit(LoginFailed(message: "Gagal login: " + $res['data']['message']));
    }
  }
  
  _proseslogout(ProsesLogout event, Emitter emit) async {
    emit(LoadingLogin());
    await loginRepository.logout();
    emit(LoginInitial());
    //conditional
  } 
}
