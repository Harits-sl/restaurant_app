import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../common/api_endpoint.dart';
import '../model/add_review_model.dart';

class ReviewRestaurantApi {
  static Future<AddReviewModel?> postReviewRestaurant({
    required String id,
    required String name,
    required String review,
  }) async {
    Map<String, String> toMap = {
      'id': id,
      'name': name,
      'review': review,
    };

    try {
      var apiResult = await http.post(
        Uri.parse('${ApiEndpoint.baseUrl}/review'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(toMap),
      );
      if (apiResult.statusCode == 201) {
        var data = jsonDecode(apiResult.body);
        AddReviewModel review = AddReviewModel.fromJSon(data);
        return review;
      }
    } catch (err) {
      debugPrint('err: $err');
      throw Exception(err);
    }
    return null;
  }
}
