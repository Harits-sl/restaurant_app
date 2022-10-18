import 'dart:convert';

import 'package:flutter/services.dart';

import '../model/restaurant_model.dart';

class RestaurantService {
  static Future<List<RestaurantModel>> loadData() async {
    String data = await rootBundle.loadString('assets/local_restaurant.json');
    Map<String, dynamic> jsonResult = await jsonDecode(data);

    List<RestaurantModel> listRestaurant = (jsonResult['restaurants'] as List)
        .map(
          (resturant) => RestaurantModel.fromMap(resturant),
        )
        .toList();

    return listRestaurant;
  }
}
