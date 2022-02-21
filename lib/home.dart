import 'package:api_demo/app_localizations.dart';
import 'package:api_demo/blocs/demo_blocs/demo_bloc.dart';
import 'package:api_demo/blocs/demo_blocs/demo_events.dart';
import 'package:api_demo/blocs/demo_blocs/demo_states.dart';
import 'package:api_demo/blocs/system_blocs/system_bloc.dart';
import 'package:api_demo/models/demo_model.dart';
import 'package:api_demo/services/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/system_blocs/system_events.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFocusTextField = true;

  List<DemoModel?> _demoList = [];

  List languages = ["English", "Vietnamese"];
  String lang = "English";

  bool isChange = true;

  _requestDemo() async {
    BlocProvider.of<DemoBloc>(context).add(const RequestObject());
  }

  _requestTheme(bool isChange) async {
    BlocProvider.of<SystemBloc>(context).add(RequestChangeTheme(isChange));
  }

  _getLanguageCd() async {
    final pref = await SharedPreferencesService.instance;
    lang = pref.languageCode == 'en' ? 'English' : 'Vietnamese';
    setState(() {});
  }

  @override
  void initState() {
    _getLanguageCd();
    _requestDemo();
    _requestTheme(isChange);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DemoBloc, DemoState>(
        builder: (context, state) => _buildUI(context),
        listener: (context, state) {
          if (state is DemoLoading) {
          } else if (state is DemoLoadSuccess) {
            _demoList = state.demoModel;
          } else if (state is DemoLoadError) {
            if (kDebugMode) {
              print('message error: ${state.message}');
            }
          }
        });
  }

  Widget _buildUI(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          Switch(
              value: isChange,
              onChanged: (newValue) {
                setState(() {
                   isChange = newValue;
                  BlocProvider.of<SystemBloc>(context).add(RequestChangeTheme(isChange));
                });
              }),
          DropdownButton(
            dropdownColor: Colors.deepPurpleAccent[100],
            underline: const SizedBox(),
            value: lang,
            onChanged: (value) {},
            items: languages.map((value) {
              return DropdownMenuItem(
                value: value,
                onTap: () {
                  setState(() {
                    lang = value;
                    BlocProvider.of<SystemBloc>(context).add(
                        RequestChangeLanguage(
                            locale: value == 'English'
                                ? const Locale('en', 'US')
                                : const Locale('vi', 'VN')));
                  });
                },
                child: Text(
                  value,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _header(context),
            Padding(
              padding: const EdgeInsets.only(top: 60, right: 215, bottom: 10),
              child: Text(
                AppLocalization.of(context)
                    .getTranslatedValues('featured_recommended')
                    .toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            _list(context)
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        clipBehavior: Clip.none,
        children: <Widget>[
          Image.network(
              'https://i.pinimg.com/736x/cf/0e/d8/cf0ed8da8fb1b1108c6e51e3adac28c4.jpg'),
          Positioned(
            bottom: -25,
            child: SizedBox(
              width: 300,
              child: TextField(
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  isDense: true,
                  prefixIcon: Icon(
                    Icons.search,
                    size: 40,
                    color: isFocusTextField ? Colors.purple : Colors.purple,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      )),
                ),
              ),
            ),
          ),
          Positioned(
            top: 110,
            left: 20,
            child: Text(
              AppLocalization.of(context)
                  .getTranslatedValues('transformation_of_new_ideas')
                  .toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              // overflow: ,
            ),
          ),
        ]);
  }

  Widget _list(BuildContext context) {
    return Container(
      height: 350,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.green.shade200,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _demoList.length,
        itemBuilder: (context, index) {
          var item = _demoList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Stack(clipBehavior: Clip.none, children: [
                Positioned(
                  top: -20,
                  right: 20,
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.purple,
                      shape: BoxShape.circle,
                    ),
                    child: const Text('4.5'),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 120,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: Image.network(
                            'https://static.vecteezy.com/packs/media/components/global/search-explore-nav/img/vectors/term-bg-1-666de2d941529c25aa511dc18d727160.jpg',
                            fit: BoxFit.contain),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Project name',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.grey),
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      child: Text(
                                        'id: ',
                                        style: TextStyle(
                                          color: Colors.greenAccent,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalization.of(context)
                                          .getTranslatedValues('title')
                                          .toString(),
                                      style: const TextStyle(
                                          color: Colors.greenAccent),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        AppLocalization.of(context)
                                            .getTranslatedValues('body')
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.greenAccent),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                          ' ${item?.id}',
                                          style: const TextStyle(
                                              color: Colors.purple,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                      Text(
                                        '${item?.title} ',
                                        style: const TextStyle(
                                            color: Colors.purple),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          'body: ${item?.body} ',
                                          style: const TextStyle(
                                              color: Colors.purple),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
