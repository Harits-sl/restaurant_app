class RestaurantModel {
  RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus menus;

  factory RestaurantModel.fromMap(Map<String, dynamic> map) {
    return RestaurantModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      pictureId: map['pictureId'] ?? '',
      city: map['city'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      menus: Menus.fromMap(map['menus']),
    );
  }
}

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  final List<Foods> foods;
  final List<Drink> drinks;

  factory Menus.fromMap(Map<String, dynamic> map) {
    return Menus(
      foods: List<Foods>.from(map['foods']?.map((x) => Foods.fromMap(x))),
      drinks: List<Drink>.from(map['drinks']?.map((x) => Drink.fromMap(x))),
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

class Drink {
  Drink({
    required this.name,
  });

  factory Drink.fromMap(Map<String, dynamic> map) {
    return Drink(
      name: map['name'] ?? '',
    );
  }

  final String name;
}
