import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SystemState extends Equatable {
  const SystemState();

  @override
  List<Object?> get props => [];
}

class SystemInit extends SystemState {
  const SystemInit();
}

//Change language
class ChangeLanguageSuccess extends SystemState {
  final Locale locale;

  const ChangeLanguageSuccess({required this.locale});

  @override
  List<Object?> get props => [locale];
}

//Change theme
class ChangeThemeSuccess extends SystemState {
    final bool themeData;

    const ChangeThemeSuccess({required this.themeData});
    @override
    List<Object?> get props => [themeData];
}

