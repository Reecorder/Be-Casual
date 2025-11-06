import 'dart:developer';

import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/controller/brands.controller.dart';
import 'package:be_casual_new2/model/color.model.dart';
import 'package:be_casual_new2/model/fonts.model.dart';
import 'package:be_casual_new2/presentation/designer/designer.details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandTile extends StatefulWidget {
  BrandTile({super.key});

  @override
  State<BrandTile> createState() => _BrandTileState();
}

class _BrandTileState extends State<BrandTile> {
  // importing category controller
  final brandsController = Get.put(BrandsController());
  @override
  void initState() {
    super.initState();
    brandsController.brandsfind();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* title */
          Text(
            "We have also love to Separate Our Brands",
            style: TextStyle(
              color: AppColors.primary,
              fontFamily: Fonts.medium,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          /* subtitle */
          Text(
            "Brands are like a badge, it reveals your true identity",
            style: TextStyle(
              color: AppColors.primary.withOpacity(0.5),
              fontSize: 12,
            ),
          ),
          /* spacer */
          spacer(height: 10),
          /* image list */
          Obx(() {
            if (brandsController.brandsLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (brandsController.brands.isEmpty) {
              return const Center(child: Text("No brands found"));
            }
            return SizedBox(
              height: 80,
              // width: 100,
              child: ListView.builder(
                itemCount: brandsController.brands.length,
                // imageLists.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      InkWell(
                        onTap: () {
                          brandsController.selectedId.value =
                              brandsController.brands[index].id.toString();

                          Get.to(
                            DesignerDetailScreen(
                              brands: brandsController.brands[index],
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            brandsController.brands[index].logo?.isNotEmpty ==
                                    true
                                ? brandsController
                                    .brands[index]
                                    .logo!
                                    .first
                                    .url!
                                : '',
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
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
