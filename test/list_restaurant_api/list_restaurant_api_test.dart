import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/common/api_endpoint.dart';
import 'package:restaurant_app/data/api/list_restaurant_api.dart';
import 'package:restaurant_app/data/model/list_restaurant_model.dart';

import 'list_restaurant_api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test('fetch list restaurant should be success', () async {
    final client = MockClient();

    final Map<String, dynamic> expectResult = {
      "error": false,
      "message": "success",
      "count": 20,
      "restaurants": [
        {
          "id": "rqdv5juczeskfw1e867",
          "name": "Melting Pot",
          "description":
              "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
          "pictureId": "14",
          "city": "Medan",
          "rating": 4.2
        },
        {
          "id": "s1knt6za9kkfw1e867",
          "name": "Kafe Kita",
          "description":
              "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
          "pictureId": "25",
          "city": "Gorontalo",
          "rating": 4
        }
      ]
    };

    when(client.get(Uri.parse('${ApiEndpoint.baseUrl}/list')))
        .thenAnswer((_) async => http.Response(jsonEncode(expectResult), 200));

    expect(await ListRestaurantApi.getListRestaurant(client),
        isA<ListRestaurantModel>());
  });
}
