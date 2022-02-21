import 'dart:ui';
import 'package:api_demo/blocs/system_blocs/system_events.dart';
import 'package:api_demo/blocs/system_blocs/system_states.dart';
import 'package:api_demo/services/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SystemBloc extends Bloc<SystemEvent, SystemState> {
  SystemBloc() : super(const SystemInit()) {
    on<RequestChangeLanguage>((event, emit) async {
      await _handleChangeLanguage(event, emit);
    });
    on<RequestChangeTheme>((event, emit) async {
      await _handleChangeTheme(event, emit);
    });
  }

  //Change Language
  _handleChangeLanguage(RequestChangeLanguage event, Emitter emit) async {
    final pref = await SharedPreferencesService.instance;
    Locale locale;
    if (event.isStartLoad) {
      if (pref.languageCode.isEmpty) {
        locale = const Locale('en', 'US');
        await pref.setLanguage(locale.languageCode);
      } else {
        locale = Locale(pref.languageCode);
      }
    } else {
      locale = event.locale;
      pref.setLanguage(locale.languageCode);
    }
    // emit locale to app
    emit(ChangeLanguageSuccess(locale: locale));
  }

  //Change Theme
  _handleChangeTheme(RequestChangeTheme event, Emitter emit) async {
    final pref = await SharedPreferencesService.instance;
    bool themeData = event.isChange ;

    emit(ChangeThemeSuccess(themeData: themeData));
  }
}
