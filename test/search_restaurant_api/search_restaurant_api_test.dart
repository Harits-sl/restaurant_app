import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/common/api_endpoint.dart';
import 'package:restaurant_app/data/api/search_restaurant_api.dart';
import 'package:restaurant_app/data/model/search_restaurant_model.dart';

import 'search_restaurant_api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test('fetch search restaurant should be success', () async {
    final client = MockClient();
    const String query = 'Makan mudah';
    final Map<String, dynamic> expectResult = {
      "error": false,
      "founded": 1,
      "restaurants": [
        {
          "id": "fnfn8mytkpmkfw1e867",
          "name": "Makan mudah",
          "description":
              "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, ...",
          "pictureId": "22",
          "city": "Medan",
          "rating": 3.7
        }
      ]
    };

    when(client.get(Uri.parse('${ApiEndpoint.baseUrl}/search?q=$query')))
        .thenAnswer((_) async => http.Response(jsonEncode(expectResult), 200));

    expect(await SearchRestaurantApi.getSearchRestaurant(query, client),
        isA<SearchRestaurantModel>());
  });
}
