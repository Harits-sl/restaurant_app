class DetailRestaurantModel {
  DetailRestaurantModel({
    required this.error,
    required this.message,
    required this.restaurant,
  });
  final bool error;
  final String message;
  final Restaurant restaurant;

  factory DetailRestaurantModel.fromJson(Map<String, dynamic> map) {
    return DetailRestaurantModel(
      error: map['error'] ?? false,
      message: map['message'] ?? '',
      restaurant: Restaurant.fromMap(map['restaurant']),
    );
  }
}

class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<Categories> categories;
  final Menus menus;
  final double rating;
  final List<CustomerReviews> customerReviews;

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      city: map['city'] ?? '',
      address: map['address'] ?? '',
      pictureId: map['pictureId'] ?? '',
      categories: List<Categories>.from(
          map['categories']?.map((x) => Categories.fromMap(x))),
      menus: Menus.fromMap(map['menus']),
      rating: map['rating']?.toDouble() ?? 0.0,
      customerReviews: List<CustomerReviews>.from(
          map['customerReviews']?.map((x) => CustomerReviews.fromMap(x))),
    );
  }
}

class Categories {
  Categories({
    required this.name,
  });
  final String name;

  factory Categories.fromMap(Map<String, dynamic> map) {
    return Categories(
      name: map['name'] ?? '',
    );
  }
}

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });
  final List<Foods> foods;
  final List<Drinks> drinks;

  factory Menus.fromMap(Map<String, dynamic> map) {
    return Menus(
      foods: List<Foods>.from(map['foods']?.map((x) => Foods.fromMap(x))),
      drinks: List<Drinks>.from(map['drinks']?.map((x) => Drinks.fromMap(x))),
    );
  }
}

class Foods {
  Foods({
    required this.name,
  });
  final String name;

  factory Foods.fromMap(Map<String, dynamic> map) {
    return Foods(
      name: map['name'] ?? '',
    );
  }
}

class Drinks {
  Drinks({
    required this.name,
  });
  final String name;

  factory Drinks.fromMap(Map<String, dynamic> map) {
    return Drinks(
      name: map['name'] ?? '',
    );
  }
}

class CustomerReviews {
  CustomerReviews({
    required this.name,
    required this.review,
    required this.date,
  });
  final String name;
  final String review;
  final String date;

  factory CustomerReviews.fromMap(Map<String, dynamic> map) {
    return CustomerReviews(
      name: map['name'] ?? '',
      review: map['review'] ?? '',
      date: map['date'] ?? '',
    );
  }
}
