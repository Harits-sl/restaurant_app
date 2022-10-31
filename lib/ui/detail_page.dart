import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/provider/favorite_restaurant_provider.dart';
import '../common/api_endpoint.dart';
import '../data/model/detail_restaurant_model.dart';
import '../provider/detail_restaurant_provider.dart';
import '../provider/review_restaurant_provider.dart';
import '../common/styles.dart';

class DetailPage extends StatefulWidget {
  static const String routeName = '/detail-restaurant';
  final String? idRestaurant;

  const DetailPage({
    Key? key,
    this.idRestaurant,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  bool isReadMore = false;
  Alignment alignment = Alignment.bottomCenter;

  late AnimationController controller;
  late Animation<Offset> offset;

  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();

  late DetailRestaurantProvider detailRestaurantProvider;
  late FavoriteRestaurantProvider favoriteProvider;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    offset = Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
        .animate(controller);

    detailRestaurantProvider =
        Provider.of<DetailRestaurantProvider>(context, listen: false);
    favoriteProvider =
        Provider.of<FavoriteRestaurantProvider>(context, listen: false);

    detailRestaurantProvider.fetchDetailRestaurant(widget.idRestaurant);
    favoriteProvider.getDataFromSharedPreferences(
        widget.idRestaurant ?? detailRestaurantProvider.id);
  }

  @override
  void dispose() {
    favoriteProvider.clearValue();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Consumer<DetailRestaurantProvider>(builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.state == ResultState.noData) {
        return Center(child: Text(state.message));
      } else if (state.state == ResultState.hasData) {
        /// menjalankan animasi
        controller.forward();

        DetailRestaurantModel detailRestaurant = state.detailRestaurant;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: SlideTransition(
                  position: offset,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeroImage(detailRestaurant),
                      _buildDetailRestaurant(detailRestaurant),
                      _buildMenus(
                        title: 'Foods',
                        listMenus: detailRestaurant.restaurant.menus.foods,
                        marginBottom: 12,
                      ),
                      _buildMenus(
                        title: 'Drinks',
                        listMenus: detailRestaurant.restaurant.menus.drinks,
                      ),
                      _buildReview(detailRestaurant.restaurant.customerReviews),
                      _buildAddReview(detailRestaurant.restaurant.id),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return Center(child: Text(state.message));
      }
    });
  }

  Widget _buildHeroImage(DetailRestaurantModel detailRestaurant) {
    return Stack(
      children: [
        Image.network(
          '${ApiEndpoint.mediumImageResolution}/${detailRestaurant.restaurant.pictureId}',
          width: double.infinity,
          height: 270,
          fit: BoxFit.cover,
        ),
        // NOTE: Button back
        SafeArea(
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(50),
            ),
            margin: const EdgeInsets.only(
              left: defaultMargin,
              top: 12,
            ),
            child: IconButton(
              onPressed: () {
                Navigation.back();
              },
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.arrow_back_rounded,
              ),
              iconSize: 24,
              color: primaryColor,
            ),
          ),
        ),
        // NOTE: Button Favorite
        Consumer<FavoriteRestaurantProvider>(
            builder: (BuildContext context, state, _) {
          return Align(
            alignment: Alignment.topRight,
            child: SafeArea(
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                margin: const EdgeInsets.only(
                  right: defaultMargin,
                  top: 12,
                ),
                child: IconButton(
                  onPressed: () {
                    // isFavorite = state.isFavorite!;
                    state.buttonFavoriteTapped(detailRestaurant);
                    // state.setIsFavorite = !isFavorite;

                    // SharedPreferencesHelper.writeBooleanData('a', true);
                    // SharedPreferencesHelper.readBooleanData('a');
                  },
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    state.isFavorite == false
                        ? Icons.favorite_border
                        : Icons.favorite,
                  ),
                  iconSize: 24,
                  color: primaryColor,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildDetailRestaurant(DetailRestaurantModel detailRestaurant) {
    final int? maxLines = isReadMore ? null : 4;

    /// menampung category restaurant
    List categories = [];
    for (var category in detailRestaurant.restaurant.categories) {
      categories.add(category.name);
    }

    return Container(
      margin: const EdgeInsets.all(defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detailRestaurant.restaurant.name,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: secondaryColor,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      categories.join(','),
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: greyColor,
                          ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.star_outlined,
                color: primaryColor,
                size: 20,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                detailRestaurant.restaurant.rating.toString(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: primaryColor,
                    ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: primaryColor,
              ),
              const SizedBox(width: 2),
              Text(
                detailRestaurant.restaurant.city,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: greyColor,
                    ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            detailRestaurant.restaurant.description,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: greyColor,
                ),
            textAlign: TextAlign.justify,
            maxLines: maxLines,
            overflow: isReadMore ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isReadMore = !isReadMore;
              });
            },
            child: Text(
              isReadMore ? 'Read Less' : 'Read More',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: primaryColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenus({
    required String title,
    required List listMenus,
    double marginBottom = 0,
  }) {
    return Container(
      margin: EdgeInsets.only(
        left: defaultMargin,
        right: defaultMargin,
        bottom: marginBottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: secondaryColor,
                ),
          ),
          Wrap(
            children: listMenus.map((menu) {
              return GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 12,
                  ),
                  margin: const EdgeInsets.only(
                    right: 12,
                    top: 12,
                  ),
                  child: Text(
                    menu.name,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: primaryColor,
                        ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReview(List<CustomerReviews> customerReviews) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: defaultMargin,
            right: defaultMargin,
            top: defaultMargin,
          ),
          child: Text(
            'Customer reviews',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: secondaryColor,
                ),
          ),
        ),
        ListView.builder(
          itemCount: customerReviews.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(
            left: defaultMargin,
            right: defaultMargin,
            top: 12,
          ),
          itemBuilder: (BuildContext context, index) {
            return Container(
              /// margin bottom bernilai 0 jika customer review terakhir
              margin: EdgeInsets.only(
                  bottom: customerReviews.length - 1 == index ? 0 : 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.person_outline_sharp,
                      color: primaryColor,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: customerReviews[index].name,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: secondaryColor,
                                ),
                            children: [
                              TextSpan(
                                text: ' • ',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      color: greyColor,
                                    ),
                              ),
                              TextSpan(
                                text: customerReviews[index].date,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      fontSize: 10,
                                      color: greyColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          customerReviews[index].review,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: secondaryColor,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    double marginBottom = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: marginBottom,
      ),
      child: TextField(
        controller: controller,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          filled: true,
          fillColor: backgroundColor,
          labelText: label,
          labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: greyColor,
              ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _buildAddReview(String id) {
    var reviewRestaurantProvider =
        Provider.of<ReviewRestaurantProvider>(context, listen: false);

    var detailRestaurantProvider =
        Provider.of<DetailRestaurantProvider>(context, listen: false);

    return Container(
      margin: const EdgeInsets.all(defaultMargin),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Add Review',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: secondaryColor,
                  ),
            ),
          ),
          _buildTextField(
            label: 'Full Name',
            controller: nameController,
            marginBottom: 16,
          ),
          _buildTextField(
            label: 'your Review',
            controller: reviewController,
          ),
          Consumer<ReviewRestaurantProvider>(
              builder: (BuildContext context, state, _) {
            void showSnackBar() {
              final snackBar = SnackBar(
                content: Text(state.message),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }

            debugPrint('state.review: ${state.state}');
            if (state.state == ReviewState.hasData) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  reviewRestaurantProvider.setReviewState = ReviewState.initial;

                  nameController = TextEditingController(text: '');
                  reviewController = TextEditingController(text: '');

                  /// fetch data restaurant from provider
                  detailRestaurantProvider
                      .fetchDetailRestaurant(widget.idRestaurant);
                });
                showSnackBar();
              });
            } else if (state.state == ReviewState.noData) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showSnackBar();
              });
            } else if (state.state == ReviewState.error) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showSnackBar();
              });
            }
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.all(12),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  if (nameController.text != '' ||
                      reviewController.text != '') {
                    reviewRestaurantProvider.addReviewRestaurant(
                      id: id,
                      name: nameController.text,
                      review: reviewController.text,
                    );
                  }
                },
                child: state.state == ReviewState.loading
                    ? const CircularProgressIndicator()
                    : Text(
                        'Add Review',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: whiteColor,
                            ),
                      ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
