import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import 'package:dental_care/src/data/model/bottom_navigation_item.dart';


class AppData {
  const AppData._();

  static List<BottomNavigationItem> bottomNavigationItems = [
    const BottomNavigationItem(
      Icon(Icons.home_outlined),
      Icon(Icons.home),
      'Trang chủ',
      isSelected: true,
    ),
    const BottomNavigationItem(
      Icon(Icons.shopping_cart_outlined),
      Icon(Icons.shopping_cart),
      'Dịch vụ',
    ),
    BottomNavigationItem(
      Lottie.asset(
        'assets/lottie/scan.json',
      ),
      Lottie.asset(
        'assets/lottie/scan.json',
      ),
      '',
    ),
    const BottomNavigationItem(
      Icon(CupertinoIcons.calendar),
      Icon(CupertinoIcons.calendar),
      'Đặt lịch',
    ),
    const BottomNavigationItem(
      Icon(CupertinoIcons.gift),
      Icon(CupertinoIcons.gift_fill),
      'Quà của tôi',
    ),
  ];
}
