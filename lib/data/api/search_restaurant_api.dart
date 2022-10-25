import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../common/api_endpoint.dart';
import '../model/search_restaurant_model.dart';

class SearchRestaurantApi {
  static Future<SearchRestaurantModel?> getSearchRestaurant(
      String query) async {
    var apiResult =
        await http.get(Uri.parse('${ApiEndpoint.baseUrl}/search?q=$query'));

    if (apiResult.statusCode == 200) {
      var data = jsonDecode(apiResult.body);
      SearchRestaurantModel restaurant = SearchRestaurantModel.fromJson(data);
      return restaurant;
    } else {
      throw Exception('No Internet Connection');
    }
  }
}
