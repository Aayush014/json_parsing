import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'data_modal.dart';

class DataProvider extends ChangeNotifier {
  Map data = {};
  DataModel? dataModel;

  Future<void> convertJsonToString() async {
    String? json = await rootBundle.loadString('Assets/data.json');
    data = jsonDecode(json);
  }

  void convertToDataModel() {
    dataModel = DataModel.fromJson(data);
  }
}
