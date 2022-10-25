import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../common/api_endpoint.dart';
import '../model/detail_restaurant_model.dart';

class DetailRestaurantApi {
  static Future<DetailRestaurantModel?> getDetail(String id) async {
    var apiResult =
        await http.get(Uri.parse('${ApiEndpoint.baseUrl}/detail/$id'));

    if (apiResult.statusCode == 200) {
      var data = jsonDecode(apiResult.body);
      DetailRestaurantModel restaurant = DetailRestaurantModel.fromJson(data);
      return restaurant;
    } else {
      throw Exception('No Internet Connection');
    }
  }
}
