import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../common/api_endpoint.dart';
import '../model/list_restaurant_model.dart';

class ListRestaurantApi {
  static Future<ListRestaurantModel?> getListRestaurant() async {
    var apiResult = await http.get(Uri.parse('${ApiEndpoint.baseUrl}/list'));

    if (apiResult.statusCode == 200) {
      var data = jsonDecode(apiResult.body);
      ListRestaurantModel restaurant = ListRestaurantModel.fromJson(data);
      return restaurant;
    } else {
      throw Exception('No Internet Connection');
    }
  }
}
