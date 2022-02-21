import 'dart:ui';

import 'package:api_demo/models/demo_model.dart';
import 'package:equatable/equatable.dart';

abstract class DemoState extends Equatable {
  const DemoState();

  @override
  List<Object?> get props => [];
}

class DemoInit extends DemoState {
  const DemoInit();
}

class DemoLoading extends DemoState {
  const DemoLoading();
}

//Api load
class DemoLoadSuccess extends DemoState {
  final List<DemoModel?> demoModel;

  const DemoLoadSuccess({required this.demoModel});

  @override
  List<Object?> get props => [demoModel];
}

class DemoLoadError extends DemoState {
  final String? message;

  const DemoLoadError({this.message});

  @override
  List<Object?> get props => [message];
}
