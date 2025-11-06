import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/controller/categories.controller.dart';
import 'package:be_casual_new2/controller/product.controller.dart';
import 'package:be_casual_new2/model/category.model.dart';
import 'package:be_casual_new2/model/color.model.dart';
import 'package:be_casual_new2/model/fonts.model.dart';
import 'package:be_casual_new2/presentation/dashboard/category.option.tile.dart';
import 'package:be_casual_new2/presentation/product/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomizedTile extends StatefulWidget {
  const CustomizedTile({super.key});

  @override
  State<CustomizedTile> createState() => _CustomizedTileState();
}

class _CustomizedTileState extends State<CustomizedTile> {
  // importing category controller
  final categoryController = Get.put(CategoryController());
  final productController = Get.put(ProductController());
  @override
  void initState() {
    super.initState();
    categoryController.categoryfind();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* title */
          Text(
            "All Designer Works in One Place ",
            style: TextStyle(
              color: AppColors.primary,
              fontFamily: Fonts.medium,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          /* subtitle */
          Text(
            "Coco Chanel, Giorgio Armani, Yves Saint Laurent and more designers awaits for you",
            style: TextStyle(
              color: AppColors.primary.withOpacity(0.5),
              fontSize: 12,
            ),
          ),

          /* spacer */
          spacer(height: 10),
          /* image list */
          Obx(() {
            if (categoryController.categoryLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (categoryController.categories.isEmpty) {
              return const Center(child: Text("No categories found"));
            }

            return SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: categoryController.categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final category = categoryController.categories[index];

                  // Build categoryOptions dynamically
                  final categoryOptions = CategoryOptions(
                    image:
                        category.image?.first.url ??
                        'https://via.placeholder.com/150',
                  );

                  return Row(
                    children: [
                      InkWell(
                        onTap: () {
                          productController.selectedId.value =
                              category.id.toString();
                          Get.to(() => const ProductScreen());
                        },
                        child: CategoryOptioTile(
                          category: category,
                          categoryOptions: categoryOptions,
                        ),
                      ),
                      spacer(width: 8),
                    ],
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
