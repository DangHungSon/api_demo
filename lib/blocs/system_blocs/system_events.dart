import 'package:api_demo/services/app_themes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SystemEvent extends Equatable {
  const SystemEvent();

  @override
  List<Object?> get props => [];
}

// Change language event
class RequestChangeLanguage extends SystemEvent {
  final bool isStartLoad;
  final Locale locale;

  const RequestChangeLanguage({required this.locale, this.isStartLoad = false});

  @override
  List<Object?> get props => [locale, isStartLoad];
}

//Change theme event
class RequestChangeTheme extends SystemEvent {
  final bool isChange;

  const RequestChangeTheme(this.isChange);
}
