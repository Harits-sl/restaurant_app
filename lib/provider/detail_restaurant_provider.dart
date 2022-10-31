import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../data/api/detail_restaurant_api.dart';

import '../data/model/detail_restaurant_model.dart';

enum ResultState { loading, noData, hasData, error }

class DetailRestaurantProvider with ChangeNotifier {
  String? _id;
  DetailRestaurantModel? _detailRestaurant;
  ResultState _state = ResultState.loading;
  String _message = '';

  get id => _id;
  get detailRestaurant => _detailRestaurant;
  get state => _state;
  get message => _message;

  set setId(String newId) {
    _id = newId;
    notifyListeners();
  }

  void fetchDetailRestaurant(String? id) async {
    try {
      _state = ResultState.loading;

      final DetailRestaurantModel? restaurant =
          await DetailRestaurantApi.getDetail(id ?? _id!, http.Client());

      if (restaurant == null) {
        _message = 'Failed to load detail';
        _state = ResultState.noData;
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        _detailRestaurant = restaurant;
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
      _message = 'No Internet Connection';
      _state = ResultState.error;
      notifyListeners();
    }
  }
}
