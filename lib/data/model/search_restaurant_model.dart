import 'restaurants.dart';

class SearchRestaurantModel {
  SearchRestaurantModel({
    required this.error,
    required this.founded,
    required this.restaurants,
  });
  final bool error;
  final int founded;
  final List<Restaurants> restaurants;

  factory SearchRestaurantModel.fromJson(Map<String, dynamic> map) {
    return SearchRestaurantModel(
      error: map['error'] ?? false,
      founded: map['founded']?.toInt() ?? 0,
      restaurants: List<Restaurants>.from(
          map['restaurants']?.map((x) => Restaurants.fromMap(x))),
    );
  }
}
