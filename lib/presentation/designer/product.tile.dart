import 'dart:developer';
import 'package:be_casual_new2/common/add_to_cart.buttn.dart';
import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/controller/product.controller.dart';
import 'package:be_casual_new2/model/color.model.dart';
import 'package:be_casual_new2/model/fonts.model.dart';
import 'package:be_casual_new2/model/product.model.dart';
import 'package:be_casual_new2/model/products.dart';
import 'package:be_casual_new2/presentation/product/product.details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductTileScreen extends StatefulWidget {
  const ProductTileScreen({super.key, this.fromTab = false});
  final bool fromTab;
  @override
  State<ProductTileScreen> createState() => _ProductTileScreenState();
}

class _ProductTileScreenState extends State<ProductTileScreen> {
  // importing products controller
  final productsController = Get.put(ProductController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.fromTab) {
        productsController.allproductsfind(); // safely called after build
      } else {
        productsController.productsIdfind();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (productsController.products.isEmpty) {
        // If list is empty
        return const Center(child: CircularProgressIndicator());
      }

      // When data is loaded
      return Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            GridView.count(
              crossAxisCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisSpacing: 5.5,
              mainAxisSpacing: 5.5,
              childAspectRatio: 0.6,
              children: List.generate(
                // productModelLists.length,
                productsController.products.length,
                (index) => ProductTile(
                  productModel: productModelLists[index],
                  productsModel: productsController.products[index],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class ProductTile extends StatelessWidget {
  ProductTile({
    super.key,
    required this.productModel,
    required this.productsModel,
  });

  final ProductModel productModel;
  final ProductsModel productsModel;
  final controller = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ProductDetailScreen(productsModel: productsModel));
      },
      child: Container(
        height: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.black.withOpacity(0.1)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /* image */
                  Container(
                    height: 100,
                    width: Get.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          productsModel.images!.first.url.toString(),
                        ),
                        fit: BoxFit.cover,
                        scale: 1.5,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        log("message");
                      },
                      child: wishlistIcon(productsModel.id ?? ""),
                    ),
                  ),
                  /* spacer */
                  spacer(height: 5),
                  /* title */
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      productsModel.name.toString(),
                      style: TextStyle(
                        color: AppColors.primary,
                        fontFamily: Fonts.medium,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  /*subtitle */
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),
                    child: Text(
                      productsModel.description.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.primary.withOpacity(0.5),
                        fontSize: 11,
                      ),
                    ),
                  ),
                  /* available size */
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      productModel.sizeAvailable.toString(),
                      style: TextStyle(
                        color: AppColors.primary.withOpacity(0.5),
                        fontSize: 11,
                      ),
                    ),
                  ),
                  /* price */
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      // productModel.price.toString(),
                      "\$${productsModel.originalPrice.toString()}",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontFamily: Fonts.medium,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /* add to cart button */
            addToCartButton,
          ],
        ),
      ),
    );
  }

  /* wishlist icon */
  Widget wishlistIcon(String productId) => Obx(() {
    final isWishlisted = controller.wishlist[productId] ?? false;
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: InkWell(
          onTap: () {
            controller.toggleWishlist(productId);
          },
          child: Icon(
            Icons.favorite,
            color: isWishlisted ? Colors.red : Colors.grey,
          ),
        ),
      ),
    );
  });

  /* add to cart button */
  Widget get addToCartButton => Obx(() {
    final count = controller.productCounts[productsModel.id] ?? 0;
    return count == 0
        ? Addtocartbutton(
          onpressed: () {
            controller.incrementCount(productsModel.id!);
          },
        )
        : OutlinedButton(
          style: OutlinedButton.styleFrom(
            fixedSize: const Size(130, 30),
            side: BorderSide(
              color: AppColors.primary.withOpacity(0.5),
              width: 1.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            padding: EdgeInsets.zero,
          ),
          onPressed: () {},
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    controller.decrementCount(productsModel.id!);
                  },
                  child: Container(
                    height: double.infinity,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.remove,
                      size: 17,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Text(
                count.toString(),
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    controller.incrementCount(productsModel.id!);
                  },
                  child: Container(
                    height: double.infinity,
                    alignment: Alignment.center,
                    child: const Icon(Icons.add, size: 17, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        );
  });
}
