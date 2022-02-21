import 'package:api_demo/blocs/demo_blocs/demo_bloc.dart';
import 'package:api_demo/blocs/system_blocs/system_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBloc {
  static List<BlocProvider> allBlocs() {
    return [
      //Data bloc provider
      BlocProvider<DemoBloc>(
        create: (BuildContext context) => DemoBloc(),
      ),
      //System bloc provider
      BlocProvider<SystemBloc>(
        create: (BuildContext context) => SystemBloc(),
      ),
    ];
  }
}
