import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

// Success
class AuthLoaded extends AuthState {
  final bool isLogin;
  const AuthLoaded({required this.isLogin});

  @override
  List<Object?> get props => [isLogin];
}

class AuthError extends AuthState {
  final String message;
  const AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}