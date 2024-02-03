part of 'login_bloc.dart';

@immutable
sealed class LoginState extends Equatable{
  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadingLogin extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  String session, name;
  
  LoginSuccess({required this.session, required this.name});
  @override
  List<Object> get props => [session, name];
}

class LoginFailed extends LoginState {
  String message;
  
  LoginFailed({required this.message});
  @override
  List<Object> get props => [message];
}