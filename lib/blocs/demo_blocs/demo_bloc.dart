import 'dart:ui';
import 'package:api_demo/blocs/demo_blocs/demo_events.dart';
import 'package:api_demo/blocs/demo_blocs/demo_states.dart';
import 'package:api_demo/services/api_call.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemoBloc extends Bloc<DemoEvent, DemoState> {
  ApiClient apiClient = ApiClient();

  DemoBloc() : super(const DemoInit()) {
    on<RequestObject>((event, emit) async {
      await _handleGetId(emit);
    });
  }

  _handleGetId(Emitter emit) async {
    emit(const DemoLoading());
    try {
      var responseDemo = await apiClient.getDemoList();
      emit(DemoLoadSuccess(demoModel: responseDemo));
    } catch (e) {
      emit(DemoLoadError(message: e.toString()));
    }
  }
}
