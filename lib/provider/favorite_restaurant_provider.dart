import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/model/detail_restaurant_model.dart';
import 'package:restaurant_app/utils/shared_preferences_helper.dart';

class FavoriteRestaurantProvider with ChangeNotifier {
  final String _keyFavoriteSharedPreferences = 'favorite';
  final String _keyListFavoriteSharedPreferences = 'list-favorite';
  bool? _isFavorite;
  List<String>? _listRestaurants;

  bool? get isFavorite => _isFavorite;
  List<String>? get listRestaurants => _listRestaurants;

  set setIsFavorite(bool newValue) {
    _isFavorite = newValue;
    notifyListeners();
  }

  void clearValue() {
    _isFavorite = null;
  }

  void getDataFromSharedPreferences(String id) async {
    // get data from sharedpreferences
    _isFavorite = await SharedPreferencesHelper.readBooleanData(
        '$_keyFavoriteSharedPreferences-$id');

    /// jika belom ada data dalam sharedpreferences maka value bernial false
    _isFavorite ??= false;

    notifyListeners();
  }

  void getListFavoriteRestaurant() async {
    /// get list data favorite restaurant
    _listRestaurants = await SharedPreferencesHelper.readListStringData(
            _keyListFavoriteSharedPreferences) ??
        [];
    notifyListeners();
  }

  void buttonFavoriteTapped(DetailRestaurantModel restaurant) async {
    /// create or update data favorite
    SharedPreferencesHelper.writeBooleanData(
      '$_keyFavoriteSharedPreferences-${restaurant.restaurant.id}',
      !_isFavorite!,
    );

    /// get boolean data favorite restaurant
    getDataFromSharedPreferences(restaurant.restaurant.id);

    /// get list data favorite restaurant
    _listRestaurants = await SharedPreferencesHelper.readListStringData(
            _keyListFavoriteSharedPreferences) ??
        [];

    notifyListeners();

    if (_isFavorite == true) {
      _listRestaurants!.add(json.encode(restaurant.toJson()));

      /// create or update list data restaurants
      SharedPreferencesHelper.writeListStringData(
        _keyListFavoriteSharedPreferences,
        _listRestaurants!,
      );
      notifyListeners();
    } else {
      int? index = _listRestaurants!.indexWhere((data) {
        DetailRestaurantModel result =
            DetailRestaurantModel.fromJson(jsonDecode(data));
        return result.restaurant.id == restaurant.restaurant.id;
      });
      _listRestaurants!.removeAt(index);

      /// create or update list data restaurants
      SharedPreferencesHelper.writeListStringData(
        _keyListFavoriteSharedPreferences,
        _listRestaurants!,
      );

      /// get list data favorite restaurant
      _listRestaurants = await SharedPreferencesHelper.readListStringData(
          _keyListFavoriteSharedPreferences);
      notifyListeners();
    }
    // SharedPreferencesHelper.removeData(_keyListFavoriteSharedPreferences);
  }
}
