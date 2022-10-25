import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/model/restaurants.dart';
import '../provider/search_restaurant_provider.dart';
import '../common/styles.dart';
import '../widgets/custom_list_tile_restaurant.dart';

class SearchPage extends StatefulWidget {
  static const String routeName = '/search';

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<Restaurants> _searchResults = [];

  final List<String> _listHintSearch = [
    'Kafe',
    'Italia',
    'kopi',
    'Air',
    'Sop',
    'Jus',
    'Es',
    'Soda',
    'Modern',
    'Apel',
  ];
  late String _hintSearch =
      _listHintSearch[Random().nextInt(_listHintSearch.length)];

  late SearchRestaurantProvider searchRestaurantProvider;

  @override
  void initState() {
    super.initState();

    searchRestaurantProvider =
        Provider.of<SearchRestaurantProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _searchResults = [];
    _hintSearch = '';
    searchRestaurantProvider.disposeValue();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  SafeArea _buildBody() {
    return SafeArea(
      child: Consumer<SearchRestaurantProvider>(
          builder: (BuildContext context, state, _) {
        _searchResults = state.searchRestaurant == null
            ? []
            : state.searchRestaurant!.restaurants;

        return ListView(
          children: [
            _buildSearch(),
            _buildTitleResult(),
            _buildResult(state),
          ],
        );
      }),
    );
  }

  Widget _buildSearch() {
    return Container(
      margin: const EdgeInsets.all(defaultMargin),
      child: TextField(
        autofocus: true,
        style: Theme.of(context).textTheme.bodyMedium,
        controller: _searchController,
        onSubmitted: (String query) {
          _searchResults.clear();

          if (query == '') {
            _searchController = TextEditingController(text: _hintSearch);
          }

          searchRestaurantProvider
              .fetchSearchRestaurant(_searchController.text);
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: whiteColor,
          hintText: _hintSearch,
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
        _searchResults.isEmpty
            ? 'Result (0)'
            : 'Result (${_searchResults.length})',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget _buildResult(SearchRestaurantProvider state) {
    int index = 0;
    return state.state == ResultState.loading
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : _searchResults.isEmpty
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                child: Center(
                  child: Text(state.message),
                ),
              )
            : Column(
                children: _searchResults.map(
                  (restaurant) {
                    index++;
                    return Container(
                      margin: EdgeInsets.only(
                        top: index == 1 ? 8 : 12,
                        bottom:
                            index == _searchResults.length ? defaultMargin : 0,
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
}
