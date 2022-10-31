import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/provider/favorite_restaurant_provider.dart';
import 'package:restaurant_app/provider/page_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/ui/main_page.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'provider/detail_restaurant_provider.dart';
import 'provider/list_restaurant_provider.dart';
import 'provider/review_restaurant_provider.dart';
import 'provider/search_restaurant_provider.dart';
import 'common/styles.dart';
import 'ui/detail_page.dart';
import 'ui/search_page.dart';
import 'ui/splash_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PageProvider>(
          create: (context) => PageProvider(),
        ),
        ChangeNotifierProvider<ListRestaurantProvider>(
          create: (context) => ListRestaurantProvider(),
        ),
        ChangeNotifierProvider<DetailRestaurantProvider>(
          create: (context) => DetailRestaurantProvider(),
        ),
        ChangeNotifierProvider<SearchRestaurantProvider>(
          create: (context) => SearchRestaurantProvider(),
        ),
        ChangeNotifierProvider<ReviewRestaurantProvider>(
          create: (context) => ReviewRestaurantProvider(),
        ),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (context) => SchedulingProvider(),
        ),
        ChangeNotifierProvider<FavoriteRestaurantProvider>(
          create: (context) => FavoriteRestaurantProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: ThemeData(
          textTheme: customTextTheme,
          scaffoldBackgroundColor: backgroundColor,
        ),
        initialRoute: SplashPage.routeName,
        routes: {
          SplashPage.routeName: (context) => const SplashPage(),
          MainPage.routeName: (context) => const MainPage(),
          SearchPage.routeName: (context) => const SearchPage(),
          DetailPage.routeName: (context) => DetailPage(
                idRestaurant:
                    ModalRoute.of(context)?.settings.arguments as String?,
              ),
        },
      ),
    );
  }
}
