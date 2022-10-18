import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/services/restaurant_service.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/widgets/custom_card_restaurant.dart';
import 'package:restaurant_app/widgets/custom_list_tile_restaurant.dart';

import '../model/restaurant_model.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildSearch() {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, SearchPage.routeName);
        },
        child: Container(
          margin: const EdgeInsets.all(defaultMargin),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(11),
                child: Icon(
                  Icons.search_rounded,
                  color: primaryColor,
                  size: 34,
                ),
              ),
              Text(
                'Search Restaurant...',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: greyColor,
                    ),
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildTitlePopular() {
      return Padding(
        padding: const EdgeInsets.only(
          left: defaultMargin,
          bottom: 12,
        ),
        child: Text(
          'Popular Restaurant',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      );
    }

    Widget _buildListPopularRestaurant() {
      return FutureBuilder(
        future: RestaurantService.loadData(),
        builder: ((context, AsyncSnapshot<List<RestaurantModel>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.hasData) {
            int index = 0;
            List<RestaurantModel>? restaurants = snapshot.data;

            return SizedBox(
              height: 268,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: restaurants!.sublist(0, 4).map(
                  (restaurant) {
                    index++;

                    return Container(
                      margin: EdgeInsets.only(
                        left: index == 1 ? defaultMargin : 12,
                        right: index == 4 ? defaultMargin : 0,
                      ),
                      child: CustomCardRestaurant(restaurant: restaurant),
                    );
                  },
                ).toList(),
              ),
            );
          }
          return const SizedBox();
        }),
      );
    }

    Widget _buildTitleNearby() {
      return Padding(
        padding: const EdgeInsets.only(
          left: defaultMargin,
          top: defaultMargin,
          bottom: 12,
        ),
        child: Text(
          'Nearby Restaurant',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      );
    }

    Widget _buildNearbyRestaurant() {
      return Padding(
        padding: const EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          bottom: defaultMargin,
        ),
        child: FutureBuilder(
          future: RestaurantService.loadData(),
          builder: ((context, AsyncSnapshot<List<RestaurantModel>> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.hasData) {
              int index = 0;
              List<RestaurantModel>? restaurants = snapshot.data;

              return Column(
                children: restaurants!.sublist(4, 10).map(
                  (restaurant) {
                    index++;

                    return Container(
                      margin: EdgeInsets.only(
                        top: index == 1 ? 0 : 12,
                      ),
                      child: CustomListTileRestaurant(
                        restaurant: restaurant,
                      ),
                    );
                  },
                ).toList(),
              );
            }
            return const SizedBox();
          }),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            _buildSearch(),
            _buildTitlePopular(),
            _buildListPopularRestaurant(),
            _buildTitleNearby(),
            _buildNearbyRestaurant(),
          ],
        ),
      ),
    );
  }
}
