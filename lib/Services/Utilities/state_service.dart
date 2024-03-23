import 'dart:convert';

import 'package:covid_tracker/Services/Utilities/app_url.dart.dart';
import 'package:http/http.dart' as http;
import '../../Models/world_state_model.dart';

class StateServices {
  Future<WorldstateModel> getWorldStateRecord() async {
    final response = await http.get(Uri.parse(ApiUrl.worldStatesApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldstateModel.fromJson(data);
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getCountryRecord() async {
    final response = await http.get(Uri.parse(ApiUrl.countriesStatesApi));
    // ignore: prefer_typing_uninitialized_variables
    var data;
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('error');
    }
  }
}
