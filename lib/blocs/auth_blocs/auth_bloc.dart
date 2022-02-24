
import 'package:api_demo/services/api_call.dart';
import 'package:api_demo/services/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_events.dart';
import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  ApiClient apiClient = ApiClient();
  
  AuthBloc() : super(const AuthInitial()) {
    on<RequestLoginEvent>((event, emit) => _handleLogin(event,emit));
  }

  // Process get token
  _handleLogin(RequestLoginEvent event,Emitter emit) async {
    final pref = await SharedPreferencesService.instance;
    emit(const AuthLoading());
    try {
      var responseAuth =  apiClient.requestLogin(event.userName, event.passWord);
      if(responseAuth == true) {
        pref.setToken('loginSuccess');
        emit(AuthLoaded(isLogin: responseAuth));
      } else {
        emit(const AuthError(message:"Login error"));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
