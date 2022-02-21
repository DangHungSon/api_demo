import 'package:equatable/equatable.dart';

import '../../app_localizations.dart';

abstract class DemoEvent extends Equatable {
  const DemoEvent();

  @override
  List<Object> get props => [];
}

// Api event
class RequestObject extends DemoEvent {
  const RequestObject();

  @override
  List<Object> get props => [];
}
