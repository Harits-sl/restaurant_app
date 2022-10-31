import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../data/api/search_restaurant_api.dart';
import '../data/model/search_restaurant_model.dart';

enum ResultState { initial, loading, noData, hasData, error }

class SearchRestaurantProvider with ChangeNotifier {
  SearchRestaurantModel? _searchRestaurant;
  ResultState _state = ResultState.initial;
  String _message = '';

  SearchRestaurantModel? get searchRestaurant => _searchRestaurant;
  get state => _state;
  get message => _message;

  void fetchSearchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final SearchRestaurantModel? restaurant =
          await SearchRestaurantApi.getSearchRestaurant(query, http.Client());

      if (restaurant!.founded == 0) {
        _message = 'No result found';
        _state = ResultState.noData;
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        _searchRestaurant = restaurant;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('e: $e');
      _message = 'No Internet Connection';
      _state = ResultState.error;
      notifyListeners();
    }
    return null;
  }

  void disposeValue() {
    _searchRestaurant = null;
    _state = ResultState.initial;
    _message = '';
  }
}
