import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/detail_restaurant_provider.dart';
import 'provider/list_restaurant_provider.dart';
import 'provider/review_restaurant_provider.dart';
import 'provider/search_restaurant_provider.dart';
import 'common/styles.dart';
import 'ui/detail_page.dart';
import 'ui/home_page.dart';
import 'ui/search_page.dart';
import 'ui/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: customTextTheme,
          scaffoldBackgroundColor: backgroundColor,
        ),
        initialRoute: SplashPage.routeName,
        routes: {
          SplashPage.routeName: (context) => const SplashPage(),
          HomePage.routeName: (context) => const HomePage(),
          SearchPage.routeName: (context) => const SearchPage(),
          DetailPage.routeName: (context) => const DetailPage(),
        },
      ),
    );
  }
}
