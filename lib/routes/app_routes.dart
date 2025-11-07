import 'package:be_casual_new2/presentation/base_screen/base_screen.dart';
import 'package:be_casual_new2/presentation/product/cart/cart.screen.dart';
import 'package:be_casual_new2/presentation/product/cart/checkout.screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String home = '/';
  static const String cart = '/cart';
  static const String checkout = '/checkout';

  static final routes = [
    GetPage(name: home, page: () => const BaseScreen()),
    GetPage(name: cart, page: () => const CartScreen(fromTab: false)),
    GetPage(
      name: checkout,
      page:
          () => CheckoutScreen(
            address: Get.arguments['address'],
            totalAmount: Get.arguments['totalAmount'],
          ),
    ),
  ];
}
