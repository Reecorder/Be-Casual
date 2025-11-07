import 'package:get/get.dart';
import 'package:be_casual_new2/controller/cart.controller.dart';
import 'package:be_casual_new2/controller/product.controller.dart';
import 'package:be_casual_new2/controller/auth.controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    // Product Controller - initialize first since cart depends on it
    Get.put(ProductController(), permanent: true);

    // Cart Controller - initialize immediately since it's needed for bottom nav
    Get.put(CartController(), permanent: true);

    // Auth Controller
    Get.put(AuthController(), permanent: true);
  }
}
