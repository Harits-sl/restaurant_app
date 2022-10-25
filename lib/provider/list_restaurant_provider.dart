import 'package:flutter/material.dart';
import '../data/api/list_restaurant_api.dart';
import '../data/model/list_restaurant_model.dart';

enum ResultState { loading, noData, hasData, error }

class ListRestaurantProvider with ChangeNotifier {
  ListRestaurantModel? _listRestaurants;
  ResultState _state = ResultState.loading;
  String _message = '';

  get listRestaurants => _listRestaurants;
  get state => _state;
  get message => _message;

  void fetchListRestaurant() async {
    try {
      _state = ResultState.loading;
      final ListRestaurantModel? restaurant =
          await ListRestaurantApi.getListRestaurant();

      if (restaurant == null) {
        _message = 'Failed to load data';
        _state = ResultState.noData;
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        _listRestaurants = restaurant;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('e: $e');
      _message = 'No Internet Connection';
      _state = ResultState.error;
      notifyListeners();
    }
  }
}
