import 'package:flutter/cupertino.dart';

enum MyPage { home, favorite, setting }

class PageProvider with ChangeNotifier {
  MyPage _page = MyPage.home;

  MyPage get page => _page;

  set setPage(MyPage newValue) {
    _page = newValue;
    notifyListeners();
  }
}
