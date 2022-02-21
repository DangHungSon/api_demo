import 'package:api_demo/blocs/system_blocs/system_bloc.dart';
import 'package:api_demo/blocs/system_blocs/system_states.dart';
import 'package:api_demo/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_localizations.dart';
import 'blocs/main_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'blocs/system_blocs/system_events.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: MainBloc.allBlocs(),
      child: const MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // Language flag
  Locale _locale = const Locale('en', 'US');

  //Theme flag
  late bool themeData = true;


  // Get languageCd from local storage
  _getLanguageCd() async {
    BlocProvider.of<SystemBloc>(context).add(const RequestChangeLanguage(
        isStartLoad: true, locale: Locale('en', 'US')));
  }

  @override
  void initState() {
    _getLanguageCd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SystemBloc, SystemState>(
      builder: (context, state) => _buildUI(context),
      listener: (context, state) {
        if (state is ChangeLanguageSuccess) {
          _locale = state.locale;
        }
        else if(state is ChangeThemeSuccess) {
          themeData = state.themeData;
        }
      },
    );
  }

  Widget _buildUI(BuildContext context) {
    return MaterialApp(
      theme: themeData == true ? ThemeData.dark() : ThemeData.light(),
      locale: _locale,
      localizationsDelegates: const [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('vi', 'VN'),
      ],
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
