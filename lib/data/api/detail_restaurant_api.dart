import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../common/api_endpoint.dart';
import '../model/detail_restaurant_model.dart';

class DetailRestaurantApi {
  static Future<DetailRestaurantModel?> getDetail(
      String id, http.Client client) async {
    var apiResult =
        await client.get(Uri.parse('${ApiEndpoint.baseUrl}/detail/$id'));

    if (apiResult.statusCode == 200) {
      var data = jsonDecode(apiResult.body);
      DetailRestaurantModel restaurant = DetailRestaurantModel.fromJson(data);
      return restaurant;
    } else {
      throw Exception('No Internet Connection');
    }
  }
}
