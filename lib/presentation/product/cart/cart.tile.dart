import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/controller/product.controller.dart';
import 'package:be_casual_new2/model/cart.model.dart';
import 'package:be_casual_new2/model/color.model.dart';
import 'package:be_casual_new2/model/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

import '../../../model/fonts.model.dart';

class CartTile extends StatefulWidget {
  CartTile({
    super.key,
    this.cartModel,
    this.isItemAddRemoveButton,
    this.height,
    this.product,
    this.quantity,
    this.selectedSize,
  });
  CartModel? cartModel;
  bool? isItemAddRemoveButton = false;
  double? height;
  final ProductsModel? product;
  final int? quantity;
  final String? selectedSize;

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  final productcontroller = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* product image */
              productImage,
              spacer(width: 10),
              Expanded(child: productDetailColumn)
            ],
          ),
        ),
        divider
      ],
    );
  }

  /* product image */
  Widget get productImage => ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Image(
        // image: AssetImage(
        //   widget.cartModel.image.toString(),
        // ),
        image: NetworkImage(widget.product!.images!.first.url.toString()),
        height: 160,
        width: 120,
        fit: BoxFit.cover,
      ));

  /* product detail column */
  Widget get productDetailColumn => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* product name  */
          Text(
            // widget.cartModel.productName.toString(),
            widget.product!.name.toString(),
            style:
                TextStyle(color: AppColors.primary, fontFamily: Fonts.medium),
          ),
          /* description */
          Text(
            // widget.cartModel.detail.toString(),
            widget.product!.description.toString(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.primary.withOpacity(0.5),
              fontSize: 12,
            ),
          ),
          /* price */
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              // widget.isItemAddRemoveButton == true
              //     ? widget.cartModel.price.toString()
              //     : "${widget.cartModel.price} x 3",
              "\$${widget.product!.discountedPrice.toString()}",
              style: TextStyle(
                  color: AppColors.primary,
                  fontFamily: Fonts.medium,
                  fontSize: 14),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                  // "Size:${widget.product!.size.toString()}",
                  //  "Size: ${widget.selectedSize ?? 'M'}",

                  // "Size: ${widget.product!.size![productcontroller.selectedIndex.value].toString() ?? "M"}",
                  "Size: ${widget.selectedSize ?? ""}",
                  style: TextStyle(
                      color: AppColors.primary,
                      fontFamily: Fonts.medium,
                      fontSize: 14))),
          /* add/ remove button */
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              "Quantity:${widget.quantity}",
              style: TextStyle(
                  color: AppColors.primary,
                  fontFamily: Fonts.medium,
                  fontSize: 14),
            ),
          )
          // widget.isItemAddRemoveButton == true ? itemAddRemoveButton : spacer()
        ],
      );

  /* item increament/decreament button */
  // Widget get itemAddRemoveButton => Container(
  //       // height: 40,
  //       width: 100,
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(5),
  //           border: Border.all(color: Colors.black12)),
  //       child: Padding(
  //         padding: const EdgeInsets.all(10),
  //         child:
  //             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
  //           /* remove icon */
  //           removeIcon,
  //           /* quantity */
  //           quantity,
  //           /* add icon */
  //           addIcon
  //         ]),
  //       ),
  //     );

  /* remove icon */
  Widget get removeIcon => const Icon(
        Feather.minus,
        size: 20,
      );

  /* add icon */
  Widget get addIcon => const Icon(
        Feather.plus,
        size: 20,
      );

  /* quantity */
  // Widget get quantity => Text(widget.cartModel.quantity.toString());
}
