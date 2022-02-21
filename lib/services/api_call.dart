import 'dart:convert';
import 'package:api_demo/models/demo_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'api_constant.dart';
import 'api_interface.dart';

class ApiClient extends ApiInterface {
  @override
  Future<List<DemoModel>> getDemoList() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
     Iterable demoResult =  jsonDecode(response.body);
      return demoResult.map((e) => DemoModel.fromJson(e)).toList();
    } else {
      var message = response.body;
      if (kDebugMode) {
        print(message);
      }
      return throw Exception('Error: Service Not Available. Please try later');
    }
  }
}
