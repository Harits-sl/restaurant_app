import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/model/restaurant_model.dart';

class DetailPage extends StatefulWidget {
  static const String routeName = '/detail-restaurant';

  const DetailPage({Key? key, required this.restaurant}) : super(key: key);

  final RestaurantModel restaurant;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  bool isReadMore = false;
  Alignment alignment = Alignment.bottomCenter;

  late AnimationController controller;
  late Animation<Offset> offset;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    offset = Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
        .animate(controller);

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildHeroImage() {
      return Stack(
        children: [
          Hero(
            tag: widget.restaurant.id,
            child: Image.network(
              widget.restaurant.pictureId,
              width: double.infinity,
              height: 270,
              fit: BoxFit.cover,
            ),
          ),
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
                  Navigator.pop(context);
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
        ],
      );
    }

    Widget _buildDetailRestaurant() {
      final int? maxLines = isReadMore ? null : 4;

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
                        widget.restaurant.name,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: secondaryColor,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.restaurant.city,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: greyColor,
                            ),
                      ),
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
                  widget.restaurant.rating.toString(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: primaryColor,
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              widget.restaurant.description,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: greyColor,
                  ),
              textAlign: TextAlign.justify,
              maxLines: maxLines,
              overflow:
                  isReadMore ? TextOverflow.visible : TextOverflow.ellipsis,
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

    Widget _buildMenus(String title, List listMenus) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroImage(),
            Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: offset,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRestaurant(),
                    _buildMenus('Foods', widget.restaurant.menus.foods),
                    const SizedBox(
                      height: 12,
                    ),
                    _buildMenus('Drinks', widget.restaurant.menus.drinks),
                    const SizedBox(
                      height: defaultMargin,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
