
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
    String username;
    String password;
    emit(const AuthLoading());
    try {
      var responseAuth =  apiClient.requestLogin(event.userName, event.passWord);
      if(event.userName == 'Son'){
        if(pref.userCode.isEmpty){
          username = 'Son';
          await pref.setUsername(username);
        }else {
          username = pref.userCode;
        }
      } else {
        username = event.userName;
        pref.setUsername(username);
      }
      if(event.passWord == '123456'){
        if(pref.password.isEmpty){
          password = '123456';
          await pref.setPassword(password);
        }else {
          password = pref.password;
        }
      } else {
        password = event.passWord;
        pref.setPassword(password);
      }
      if(responseAuth == true) {
        emit(AuthLoaded(isLogin: responseAuth));
      } else {
        emit(const AuthError(message:"Login error"));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
