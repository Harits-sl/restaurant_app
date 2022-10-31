import 'dart:math';
import 'dart:ui';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/detail_restaurant_api.dart';
import 'package:restaurant_app/data/api/list_restaurant_api.dart';
import 'package:restaurant_app/data/model/detail_restaurant_model.dart';
import 'package:restaurant_app/data/model/list_restaurant_model.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:http/http.dart' as http;

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;
  static final _client = http.Client();

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    try {
      debugPrint('Alarm fired!');
      final NotificationHelper notificationHelper = NotificationHelper();
      ListRestaurantModel? listRestaurants =
          await ListRestaurantApi.getListRestaurant(_client);

      int randomIndex = Random().nextInt(listRestaurants!.count);
      String id = listRestaurants.restaurants[randomIndex].id;

      DetailRestaurantModel? detailRestaurants =
          await DetailRestaurantApi.getDetail(id, _client);

      await notificationHelper.showNotification(
          flutterLocalNotificationsPlugin, detailRestaurants!);
    } catch (e) {
      debugPrint(e.toString());
    }

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
