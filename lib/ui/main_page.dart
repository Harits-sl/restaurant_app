import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/provider/page_provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/ui/favorite_page.dart';
import 'package:restaurant_app/ui/setting_page.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  static const String routeName = '/main';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(DetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Consumer<PageProvider>(builder: (BuildContext context, state, _) {
      return Stack(
        children: [
          _switchPage(state.page),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              decoration: BoxDecoration(
                color: whiteColor,
                border: Border(
                  top: BorderSide(
                    color: greyColor.withOpacity(0.5),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  itemNavBar(
                    state: state,
                    page: MyPage.home,
                    icon: Icons.home_filled,
                  ),
                  itemNavBar(
                    state: state,
                    page: MyPage.favorite,
                    icon: Icons.favorite,
                  ),
                  itemNavBar(
                    state: state,
                    page: MyPage.setting,
                    icon: Icons.settings,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _switchPage(MyPage page) {
    switch (page) {
      case MyPage.home:
        return const HomePage();
      case MyPage.favorite:
        return const FavoritePage();
      case MyPage.setting:
        return const SettingPage();
      default:
        return const HomePage();
    }
  }

  Widget itemNavBar({
    required PageProvider state,
    required MyPage page,
    required IconData icon,
  }) {
    return InkWell(
      onTap: () => state.setPage = page,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Icon(
          icon,
          size: 35,
          color: state.page != page ? greyColor : primaryColor,
        ),
      ),
    );
  }
}
