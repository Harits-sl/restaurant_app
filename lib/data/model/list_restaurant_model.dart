import 'restaurants.dart';

class ListRestaurantModel {
  ListRestaurantModel({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });
  final bool error;
  final String message;
  final int count;
  final List<Restaurants> restaurants;

  factory ListRestaurantModel.fromJson(Map<String, dynamic> map) {
    return ListRestaurantModel(
      error: map['error'] ?? false,
      message: map['message'] ?? '',
      count: map['count']?.toInt() ?? 0,
      restaurants: List<Restaurants>.from(
          map['restaurants']?.map((x) => Restaurants.fromMap(x))),
    );
  }
}
