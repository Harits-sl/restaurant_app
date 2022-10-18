import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/model/restaurant_model.dart';
import 'package:restaurant_app/services/restaurant_service.dart';
import 'package:restaurant_app/widgets/custom_list_tile_restaurant.dart';

class SearchPage extends StatefulWidget {
  static const String routeName = '/search';

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<RestaurantModel> restaurants = [];
  List<RestaurantModel> searchResults = [];

  void _searchRestaurant(String query) {
    List<RestaurantModel> list = [];

    for (var restaurant in restaurants) {
      if (restaurant.name.toLowerCase().contains(query.toLowerCase())) {
        list.add(restaurant);
      }
    }
    setState(() {
      searchResults = list;
    });
  }

  void _clearResult() {
    setState(() {
      searchResults.clear();
      searchResults = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildSearch() {
      return Container(
        margin: const EdgeInsets.all(defaultMargin),
        child: TextField(
          autofocus: true,
          style: Theme.of(context).textTheme.bodyMedium,
          controller: _searchController,
          onChanged: (String query) {
            _searchRestaurant(query);

            if (_searchController.text == '') {
              _clearResult();
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: whiteColor,
            hintText: 'Search Restaurant...',
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: greyColor,
                ),
            prefixIcon: const Padding(
              padding: EdgeInsets.all(11),
              child: Icon(
                Icons.search_rounded,
                color: primaryColor,
                size: 34,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      );
    }

    Widget _buildTitleResult() {
      return Padding(
        padding: const EdgeInsets.only(left: defaultMargin),
        child: Text(
          'Result (${searchResults.length})',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    }

    Widget _buildResult() {
      int index = 0;
      return Column(
        children: searchResults.map(
          (restaurant) {
            index++;
            return Container(
              margin: EdgeInsets.only(
                top: index == 1 ? 8 : 12,
                bottom: index == searchResults.length ? defaultMargin : 0,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: CustomListTileRestaurant(
                restaurant: restaurant,
              ),
            );
          },
        ).toList(),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: RestaurantService.loadData(),
          builder: ((context, AsyncSnapshot<List<RestaurantModel>> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.hasData) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                restaurants = snapshot.data!;
              });

              return ListView(
                children: [
                  _buildSearch(),
                  _buildTitleResult(),
                  _buildResult(),
                ],
              );
            }
            return const SizedBox();
          }),
        ),
      ),
    );
  }
}
