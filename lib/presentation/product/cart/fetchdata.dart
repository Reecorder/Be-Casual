import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/controller/cart.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/color.model.dart';
import '../../../model/fonts.model.dart';

class FetchCartScreen extends StatefulWidget {
  @override
  State<FetchCartScreen> createState() => _FetchCartScreenState();
}

class _FetchCartScreenState extends State<FetchCartScreen> {
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (cartController.fetchcartLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final cartList = cartController.fetchcart;

      if (cartList.isEmpty) {
        return const Center(child: Text("Your cart is empty"));
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: cartList.length,
        itemBuilder: (context, index) {
          final cartItem = cartList[index];

          if (cartItem.items != null && cartItem.items!.isNotEmpty) {
            return Column(
              children:
                  cartItem.items!.map((item) {
                    final product = item.product;
                    final productitems = item;
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /* product image */
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child:
                                (product != null &&
                                        product.images != null &&
                                        product.images!.isNotEmpty)
                                    ? Image(
                                      image: NetworkImage(
                                        product.images!.first.url.toString(),
                                      ),
                                      height: 160,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    )
                                    : Container(
                                      height: 160,
                                      width: 120,
                                      color: Colors.grey[300],
                                      child: const Icon(
                                        Icons.image_not_supported,
                                        size: 48,
                                        color: Colors.grey,
                                      ),
                                    ),
                          ),
                          spacer(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /* product name  */
                                Text(
                                  product?.name?.toString() ?? '',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontFamily: Fonts.medium,
                                  ),
                                ),
                                /* description */
                                Text(
                                  product?.description?.toString() ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors.primary.withOpacity(0.5),
                                    fontSize: 12,
                                  ),
                                ),
                                /* price */
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  child: Text(
                                    // widget.isItemAddRemoveButton == true
                                    //     ? widget.cartModel.price.toString()
                                    //     : "${widget.cartModel.price} x 3",
                                    "\$${productitems.price.toString()}",
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontFamily: Fonts.medium,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    // "Size:${widget.product!.size.toString()}",
                                    //  "Size: ${widget.selectedSize ?? 'M'}",

                                    // "Size: ${widget.product!.size![productcontroller.selectedIndex.value].toString() ?? "M"}",
                                    "Size: ${productitems.selectedSize.toString()}",
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontFamily: Fonts.medium,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                /* add/ remove button */
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    "Quantity:${productitems.qty.toString()}",
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontFamily: Fonts.medium,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                // widget.isItemAddRemoveButton == true ? itemAddRemoveButton : spacer()
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            );
          } else {
            return ListTile(
              title: const Text("No items in this cart"),
              subtitle: Text('Total Price: \$${cartItem.totalPrice ?? 0}'),
            );
          }
        },
      );
    });
  }
}
