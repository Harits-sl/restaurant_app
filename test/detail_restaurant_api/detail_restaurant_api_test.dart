import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/common/api_endpoint.dart';
import 'package:restaurant_app/data/api/detail_restaurant_api.dart';
import 'package:restaurant_app/data/model/detail_restaurant_model.dart';

import 'detail_restaurant_api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test('fetch detail restaurant should be success', () async {
    final client = MockClient();
    const String id = 'rqdv5juczeskfw1e867';
    final Map<String, dynamic> expectResult = {
      "error": false,
      "message": "success",
      "restaurant": {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description":
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
        "city": "Medan",
        "address": "Jln. Pandeglang no 19",
        "pictureId": "14",
        "categories": [
          {"name": "Italia"},
          {"name": "Modern"}
        ],
        "menus": {
          "foods": [
            {"name": "Paket rosemary"},
            {"name": "Toastie salmon"}
          ],
          "drinks": [
            {"name": "Es krim"},
            {"name": "Sirup"}
          ]
        },
        "rating": 4.2,
        "customerReviews": [
          {
            "name": "Ahmad",
            "review": "Tidak rekomendasi untuk pelajar!",
            "date": "13 November 2019"
          }
        ]
      }
    };

    when(client.get(Uri.parse('${ApiEndpoint.baseUrl}/detail/$id')))
        .thenAnswer((_) async => http.Response(jsonEncode(expectResult), 200));

    expect(await DetailRestaurantApi.getDetail(id, client),
        isA<DetailRestaurantModel>());
  });
}
