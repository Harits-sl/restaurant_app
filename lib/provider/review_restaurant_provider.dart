import 'package:flutter/material.dart';
import '../data/api/review_restaurant_api.dart';
import '../data/model/add_review_model.dart';

enum ReviewState { initial, loading, noData, hasData, error }

class ReviewRestaurantProvider with ChangeNotifier {
  AddReviewModel? _reviewRestaurants;
  ReviewState _state = ReviewState.initial;
  String _message = '';

  get reviewRestaurants => _reviewRestaurants;
  get state => _state;
  get message => _message;

  set setReviewState(ReviewState newState) {
    _state = newState;
    notifyListeners();
  }

  void addReviewRestaurant({
    required String id,
    required String name,
    required String review,
  }) async {
    try {
      _state = ReviewState.loading;
      notifyListeners();

      final AddReviewModel? restaurant =
          await ReviewRestaurantApi.postReviewRestaurant(
        id: id,
        name: name,
        review: review,
      );

      if (restaurant == null) {
        _message = 'Failed to add';
        _state = ReviewState.noData;
        notifyListeners();
      } else {
        _message = 'Success Add Review';
        _state = ReviewState.hasData;
        _reviewRestaurants = restaurant;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('e: $e');
      _message = 'No Internet Connection';
      _state = ReviewState.error;
      notifyListeners();
    }
    return null;
  }
}
