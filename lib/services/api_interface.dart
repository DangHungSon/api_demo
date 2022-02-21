import 'package:api_demo/models/demo_model.dart';

abstract class ApiInterface {
  Future<List<DemoModel>> getDemoList();
}
