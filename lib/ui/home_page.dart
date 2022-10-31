import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import '../data/model/list_restaurant_model.dart';
import '../provider/list_restaurant_provider.dart';
import '../common/styles.dart';
import 'search_page.dart';
import '../widgets/custom_card_restaurant.dart';
import '../widgets/custom_list_tile_restaurant.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listRestaurantProvider =
        Provider.of<ListRestaurantProvider>(context, listen: false);
    listRestaurantProvider.fetchListRestaurant();

    return Scaffold(
      body: _buildBody(context),
    );
  }

  void _onTapSearch(BuildContext context) {
    Navigation.intent(SearchPage.routeName);
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Consumer<ListRestaurantProvider>(
          builder: (BuildContext context, state, _) {
        debugPrint('state.state: ${state.state}');
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.noData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.hasData) {
          return ListView(
            children: [
              _buildSearch(context),
              _buildTitlePopular(context),
              _buildListPopularRestaurant(state.listRestaurants),
              _buildTitleNearby(context),
              _buildNearbyRestaurant(state.listRestaurants),
            ],
          );
        } else {
          return Center(child: Text(state.message));
        }
      }),
    );
  }

  Widget _buildSearch(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTapSearch(context),
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

  Widget _buildTitlePopular(BuildContext context) {
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

  Widget _buildListPopularRestaurant(ListRestaurantModel restaurants) {
    int index = 0;
    return SizedBox(
      height: 268,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: restaurants.restaurants.sublist(0, 4).map(
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

  Widget _buildTitleNearby(BuildContext context) {
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

  Widget _buildNearbyRestaurant(ListRestaurantModel restaurants) {
    int index = 0;

    return Padding(
      padding: const EdgeInsets.only(
        left: defaultMargin,
        right: defaultMargin,
        bottom: defaultMargin,
      ),
      child: Column(
        children: restaurants.restaurants.sublist(4).map(
          (restaurant) {
            index++;

            return Container(
              margin: EdgeInsets.only(
                top: index == 1 ? 0 : 12,
                bottom: index == restaurants.restaurants.sublist(4).length
                    ? defaultMargin + 35 // size icon bottom navbar
                    : 0,
              ),
              child: CustomListTileRestaurant(
                restaurant: restaurant,
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
