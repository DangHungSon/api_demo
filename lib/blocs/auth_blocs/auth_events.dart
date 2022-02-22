import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

//Request login
class RequestLoginEvent extends AuthEvent {
  final String userName;
  final String passWord;

  const RequestLoginEvent({required this.userName,required this.passWord});

  @override
  List<Object?> get props => [];
}

//Request logout
class RequestLogoutEvent extends AuthEvent {}
