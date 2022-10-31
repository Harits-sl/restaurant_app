import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/detail_restaurant_model.dart';
import 'package:restaurant_app/data/model/restaurants.dart';
import 'package:restaurant_app/provider/favorite_restaurant_provider.dart';
import 'package:restaurant_app/widgets/custom_list_tile_restaurant.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});
  @override
  Widget build(BuildContext context) {
    Provider.of<FavoriteRestaurantProvider>(context)
        .getListFavoriteRestaurant();

    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          _buildTitle(context),
          _buildListFavorite(),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: defaultMargin,
        top: defaultMargin,
        bottom: 12,
      ),
      child: Text(
        'Your Favorite Restaurant',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _buildListFavorite() {
    int index = 0;

    return Consumer<FavoriteRestaurantProvider>(
        builder: (BuildContext context, state, _) {
      return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children:
            state.listRestaurants == null || state.listRestaurants!.isEmpty
                ? [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                      ),
                      child: Text(
                        'Tidak ada restaurant favorit',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ]
                : state.listRestaurants!.map((restaurant) {
                    index++;

                    DetailRestaurantModel data =
                        DetailRestaurantModel.fromJson(jsonDecode(restaurant));

                    Restaurants res = Restaurants(
                      id: data.restaurant.id,
                      name: data.restaurant.name,
                      description: data.restaurant.description,
                      pictureId: data.restaurant.pictureId,
                      city: data.restaurant.city,
                      rating: data.restaurant.rating,
                    );

                    return Container(
                      margin: EdgeInsets.only(
                        left: defaultMargin,
                        right: defaultMargin,
                        top: index == 1 ? 0 : 12,
                        bottom: index == state.listRestaurants!.length
                            ? defaultMargin + 35 // size icon bottom navbar
                            : 0,
                      ),
                      child: CustomListTileRestaurant(
                        restaurant: res,
                      ),
                    );
                  }).toList(),
      );
    });
  }
}
