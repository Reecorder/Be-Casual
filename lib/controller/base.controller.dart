import 'package:be_casual_new2/presentation/dashboard/dashboard.dart';
import 'package:be_casual_new2/presentation/order/order.screen.dart';
import 'package:be_casual_new2/presentation/product/cart/cart.screen.dart';
import 'package:be_casual_new2/presentation/profile/profile.dart';
import 'package:be_casual_new2/presentation/search/search.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  List<IconData> icons = [
    Feather.home,
    Feather.search,
    Feather.shopping_cart,
    Feather.box,
    Feather.user,
  ];

  List<String> screennames = [
    "Dashboard",
    "Search",
    "Cart",
    "Order",
    "Profile",
  ];

  List<Widget> screens = [
    const DashboardScreen(),
    const SearchScreen(),
    const CartScreen(fromTab: false),
    const OrderScreen(),
    ProfileScreen(),
  ];

  void onchange({required int index}) => selected.value = index;

  RxInt selected = 0.obs;

  /* search controller */
  final searchController = TextEditingController();
}
