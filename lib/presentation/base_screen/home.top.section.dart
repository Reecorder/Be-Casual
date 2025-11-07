import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/controller/cart.controller.dart';
import 'package:be_casual_new2/controller/product.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class HomeTopSection extends StatelessWidget {
  HomeTopSection({super.key});
  final productcontroller = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* address column */
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* selected address title */
              Text('Selected Address', style: subtitleStyle),
              /* address first line */
              const Text(
                'Saltlake Sector 5',
                style: TextStyle(
                  fontSize: 16,
                  height: 1,
                  fontWeight: FontWeight.w500,
                ),
              ),
              /* address second line */
              Text(
                'DN-24, Matrix Tower, Pixel Consultancy',
                style: TextStyle(height: 2, fontSize: 12),
              ),
            ],
          ),

          /* cart icon */
          InkWell(
            onTap: () {
              final cartController = Get.put(CartController());
              // Caller is handling navigation, so avoid double navigation inside fetchCart
              cartController.fetchCart(navigateToCart: false);
              Get.toNamed('/cart', arguments: {'fromTab': true});
            },
            child: Stack(
              children: [
                const Icon(Feather.shopping_bag),
                Positioned(
                  right: 0,
                  bottom: 6,
                  child: Obx(() {
                    final total = productcontroller.productCounts.values.fold(
                      0,
                      (sum, count) => sum + count,
                    );
                    return Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$total',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
