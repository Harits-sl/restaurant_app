import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/model/restaurant_model.dart';
import 'package:restaurant_app/ui/detail_page.dart';

class CustomListTileRestaurant extends StatelessWidget {
  const CustomListTileRestaurant({Key? key, required this.restaurant})
      : super(key: key);

  final RestaurantModel restaurant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailPage.routeName,
          arguments: restaurant,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Hero(
                tag: restaurant.id,
                child: Image.network(
                  restaurant.pictureId,
                  width: 75,
                  height: 75,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: secondaryColor,
                        ),
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    restaurant.city,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: greyColor,
                        ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
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
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: primaryColor,
                      ),
                ),
                const SizedBox(
                  width: 12,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
