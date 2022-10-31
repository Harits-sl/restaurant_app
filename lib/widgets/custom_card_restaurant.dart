import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import '../data/model/restaurants.dart';
import '../common/api_endpoint.dart';
import '../common/styles.dart';

import '../provider/detail_restaurant_provider.dart';
import '../ui/detail_page.dart';

class CustomCardRestaurant extends StatelessWidget {
  const CustomCardRestaurant({Key? key, required this.restaurant})
      : super(key: key);

  /// [Restaurants] from ListRestaurantModel
  final Restaurants restaurant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DetailRestaurantProvider detailRestaurantProvider =
            Provider.of<DetailRestaurantProvider>(context, listen: false);

        detailRestaurantProvider.setId = restaurant.id;

        Navigation.intentWithData(
          DetailPage.routeName,
          null,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.network(
                    '${ApiEndpoint.mediumImageResolution}/${restaurant.pictureId}',
                    width: 180,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8, top: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 15,
                          sigmaY: 8,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star_outlined,
                              color: primaryColor,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              restaurant.rating.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: whiteColor,
                                    fontWeight: bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              width: 180,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                restaurant.name,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: secondaryColor,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                restaurant.city,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: greyColor,
                    ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
