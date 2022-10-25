class AddReviewModel {
  AddReviewModel({
    required this.error,
    required this.message,
    required this.customerReviews,
  });
  final bool error;
  final String message;
  final List<CustomerReviews> customerReviews;

  factory AddReviewModel.fromJSon(Map<String, dynamic> map) {
    return AddReviewModel(
      error: map['error'] ?? false,
      message: map['message'] ?? '',
      customerReviews: List<CustomerReviews>.from(
          map['customerReviews']?.map((x) => CustomerReviews.fromMap(x))),
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

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'review': review});
    result.addAll({'date': date});

    return result;
  }

  factory CustomerReviews.fromMap(Map<String, dynamic> map) {
    return CustomerReviews(
      name: map['name'] ?? '',
      review: map['review'] ?? '',
      date: map['date'] ?? '',
    );
  }
}
