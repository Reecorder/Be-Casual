import 'dart:developer';

import 'package:be_casual_new2/common/common.appbar.dart';
import 'package:be_casual_new2/common/common.title.dart';
import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/controller/cart.controller.dart';
import 'package:be_casual_new2/controller/product.controller.dart';
import 'package:be_casual_new2/model/color.model.dart';
import 'package:be_casual_new2/model/fonts.model.dart';
import 'package:be_casual_new2/model/products.dart';
import 'package:be_casual_new2/presentation/designer/product.tile.dart';
import 'package:be_casual_new2/presentation/product/filter.option_tile.dart';
import 'package:be_casual_new2/presentation/product/product.rating_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    super.key,
    required this.productsModel,
  });
  final ProductsModel productsModel;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final productcontroller = Get.put(ProductController());
  final fetchcartcontroller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(Get.width, 60), child: appbarWidget),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
              height: 220,
              width: Get.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      // image: AssetImage("assets/dashboard/cat5.jpg"),
                      image: NetworkImage(
                          widget.productsModel.images!.first.url.toString()))),
              child: containerChild),
          /* spacer */
          spacer(height: 20),
          /* detaiil tile */
          productDetailTile
        ]),
      ),
      bottomNavigationBar: bottomNavBar,
    );
  }

  /* appbar  */
  Widget get appbarWidget => CommonAppbar(
        title: "Indian Dress with Shopping Bags",
        subtitle: "Lorem Ipsum is simply dummy text of the printing",
        // icon: Feather.shopping_bag,
        icon: InkWell(
            onTap: () {
              // Get.to(() => CartScreen(fromTab: true,));
              fetchcartcontroller.fetchCart();
            },
            child: Stack(children: [
              const Icon(
                Feather.shopping_bag,
              ),
              Positioned(
                  right: 0,
                  bottom: 6,
                  child: Obx(() {
                    final total = productcontroller.productCounts.values
                        .fold(0, (sum, count) => sum + count);
                    return Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                        child: Text('$total',
                            style: const TextStyle(
                                fontSize: 10, color: Colors.white)));
                  }))
            ])),

        divider: false,
      );

  /* container child */
  Widget get containerChild => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            /* icon */
            // wishlistIcon,
            /* brand image */
            brandImage
          ],
        ),
      );

  // /* wishlist icon */
  // Widget get wishlistIcon => const Icon(
  //       Feather.heart,
  //       size: 20,
  //       color: Colors.white70,
  //     );

  /* brand image */
  Widget get brandImage => ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Image.network(
        widget.productsModel.brand!.logo!.first.url.toString(),
        height: 40,
        fit: BoxFit.cover,
      )
      );

  /* product detail tile */
  Widget get productDetailTile =>
      Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        /* title */
        title,
        /* subtitle */
        subtitle,
        /* spacer */
        spacer(height: 15),
        /* size option tile */
        sizeFilterOption,
        /* price */
        price,
        /* spacer */
        spacer(height: 15),

        /* descrition tile */
        descriptionTile,
        /* spacer */
        spacer(height: 10),
        /* sold by text */
        soldBy,
        /* rating text */
        ratingText,
        /* similar title */
        similarTitle,
        /* product tile */
        prodcutTile
      ]);

  /* title subtitle */
  Widget get title => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
          // "Indian Dress with Shopping Bags",
          widget.productsModel.name.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.primary,
              fontFamily: Fonts.medium,
              fontSize: 16)));

  /* subtitle */
  Widget get subtitle => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Text(widget.productsModel.description.toString(),
          // "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to...",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.primary.withOpacity(0.6), fontSize: 12)));

  /* size filter */
  Widget get sizeFilterOption => Padding(
        padding: const EdgeInsets.only(left: 15.0, bottom: 10),
        child: SizedBox(
          height: 35,
          child: Obx(() {
            String productId = widget.productsModel.id.toString();
            String? selectedSize = productcontroller.selectedSizes[productId];
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: widget.productsModel.size!.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final size = widget.productsModel.size![index];
                final isSelected = selectedSize == size;

                return InkWell(
                  onTap: () {
                    productcontroller.selectSizeForProduct(productId, size);
                    log("Selected size for product $productId: $size");
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.blue.withOpacity(0.2)
                          : Colors.transparent,
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      size,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.black.withOpacity(0.9),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      );


  /* price text */
  Widget get price => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Align(
          alignment: Alignment.topLeft,
          child: Row(children: [
            Row(children: [
              const Icon(Icons.arrow_downward_outlined,
                  color: Colors.green, size: 22),
              Text(
                  "${getDiscountPercentage(widget.productsModel.originalPrice!, widget.productsModel.discountedPrice!)}%",
                  style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18))
            ]),
            const SizedBox(width: 8),
            Text("\$${widget.productsModel.originalPrice}",
                style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.grey,
                    color: Colors.grey,
                    fontSize: 16)),
            const SizedBox(width: 6),
            Text("\$${widget.productsModel.discountedPrice}",
                style: TextStyle(
                    color: AppColors.primary,
                    // fontFamily: Fonts.regular,
                    fontWeight: FontWeight.w600,
                    fontSize: 18)),
          ])));
  String getDiscountPercentage(double original, double discounted) {
    final percent = ((original - discounted) / original) * 100;
    return percent.toStringAsFixed(0);
  }

  /* description  tile */
  Widget get descriptionTile => FilterOptionTile(
      //  useController: true,
      filterList: descriptionList,
      fontSize: 12,
      color: AppColors.primary.withOpacity(0.5));

  /*sold by text */
  Widget get soldBy => Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.primary.withOpacity(0.4))),
      child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text("Sold By India Textiles", style: subtitleStyle)));

  /* rating text */
  Widget get ratingText => Padding(
      padding: const EdgeInsets.only(top: 20, left: 15),
      child: InkWell(
          onTap: () {
            Get.to(() => ProductRatingScreen(
                  productsModel: widget.productsModel,
                ));
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text("Total Rating: ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: Fonts.medium,
                    )),
                Text(
                    // "{4.7k ratings}",
                    " ${widget.productsModel.rating.toString()}k",
                    style: TextStyle(
                        color: const Color(0xFF007713),
                        fontFamily: Fonts.medium,
                        decoration: TextDecoration.underline,
                        decorationColor: const Color(0xFF007713))),
              ],
            ),
          )));

  /* similar item title */
  Widget get similarTitle => Padding(
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
      child: CommonTitleRow(title: "Similar Items like this", width: 85));

  /* product tile */
  Widget get prodcutTile =>const ProductTileScreen();
  Widget get bottomNavBar => Container(
      height: 44,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -2))
      ]),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
            child:

                // Obx((){
                //   return
                // });
                ElevatedButton(
                    onPressed: () {
                      // productcontroller.selectAction('buy');
                      // Get.snackbar("Buy Now", "You tapped Buy Now");
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1))),
                    child: const Text("Buy Now",
                        style: TextStyle(color: Colors.white)))),
        // const SizedBox(width: 12),
        Expanded(child: Obx(
          () {
            final isInCart = productcontroller.cartProducts
                .containsKey(widget.productsModel.id!);
            return ElevatedButton(
                onPressed: () {
                  final productId = widget.productsModel.id!;
                  final selectedSize =
                      productcontroller.selectedSizes[productId];

                  if (selectedSize == null || selectedSize.isEmpty) {
                    Get.snackbar(
                      "Select Size",
                      "Please select a size before adding to cart",
                      backgroundColor: Colors.red.shade400,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  final alreadyAdded =
                      productcontroller.cartProducts.containsKey(productId);
                  if (alreadyAdded) {
                    Get.snackbar(
                      "Already Added",
                      "This item is already in your cart",
                      backgroundColor: Colors.red.shade300,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  productcontroller.incrementCount(productId);
                  productcontroller.addToCart(widget.productsModel);
                  productcontroller.cartsCreate();
                },

                // onPressed: () {
                //   if (productcontroller.selectedSizes.value == -1) {
                //     Get.snackbar(
                //       "Select Size",
                //       "Please select a size before adding to cart",
                //       backgroundColor: Colors.red.shade400,
                //       colorText: Colors.white,
                //     );
                //   } else {
                //     final productId = widget.productsModel.id!;
                //     final existingCount =
                //         productcontroller.productCounts[productId] ?? 0;

                //     if (existingCount > 0) {
                //       Get.snackbar(
                //         "Already Added",
                //         "This item is already in your cart",
                //         backgroundColor: Colors.red.shade300,
                //         colorText: Colors.white,
                //       );
                //     } else {
                //       productcontroller.incrementCount(productId);
                //       productcontroller
                //           .addToCart(widget.productsModel); // Add to cart
                //       productcontroller.cartsCreate();
                //     }
                //   }
                // },
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isInCart ? Colors.grey.shade400 : Colors.green.shade500,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1))),
                child: const Text("Add to Cart",
                    style: TextStyle(color: Colors.white)));
          },
        ))
      ]));

  // Widget get bottomNavBar => Container(
  //     height: 44,
  //     // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
  //     decoration: BoxDecoration(color: Colors.white, boxShadow: [
  //       BoxShadow(
  //           color: Colors.grey.withOpacity(0.3),
  //           blurRadius: 10,
  //           offset: const Offset(0, -2))
  //     ]),
  //     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
  //       Expanded(
  //           child: ElevatedButton(
  //               onPressed: () {
  //                 // productcontroller.selectAction('buy');
  //                 // Get.snackbar("Buy Now", "You tapped Buy Now");
  //               },
  //               style: ElevatedButton.styleFrom(
  //                   backgroundColor: AppColors.primary.withOpacity(0.8),
  //                   padding: const EdgeInsets.symmetric(vertical: 12),
  //                   shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(1))),
  //               child: const Text("Buy Now",
  //                   style: TextStyle(color: Colors.white)))),
  //       // const SizedBox(width: 12),
  //       Expanded(
  //           child: ElevatedButton(
  //               onPressed: () {
  //                 if (productcontroller.selectedIndex.value == -1) {
  //                   Get.snackbar(
  //                     "Select Size",
  //                     "Please select a size before adding to cart",
  //                     backgroundColor: Colors.red.shade400,
  //                     colorText: Colors.white,
  //                   );
  //                 } else {
  //                   final productId = widget.productsModel.id!;
  //                   final existingCount =
  //                       productcontroller.productCounts[productId] ?? 0;

  //                   if (existingCount > 0) {
  //                     Get.snackbar(
  //                       "Already Added",
  //                       "This item is already in your cart",
  //                       backgroundColor: Colors.red.shade300,
  //                       colorText: Colors.white,
  //                     );
  //                   } else {
  //                     productcontroller.incrementCount(productId);
  //                     productcontroller.cartsCreate();
  //                   }
  //                 }
  //               },
  //               style: ElevatedButton.styleFrom(
  //                   backgroundColor: Colors.green.withOpacity(0.9),
  //                   padding: const EdgeInsets.symmetric(vertical: 12),
  //                   shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(1))),
  //               child: const Text("Add to Cart",
  //                   style: TextStyle(color: Colors.white))))
  //     ]));
}

/* size filter list */
List sizeFilterList = ["Small", "Medium", "Large", "XL", "XXl", "XXXL"];

/* description list */
List descriptionList = [
  "Weight: 450 gm",
  "Package Size: 2 ft, 1 ft",
  "Height: 2 ft. 10 inches",
  "Cotton Material"
];
