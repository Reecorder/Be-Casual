import 'dart:developer';

import 'package:be_casual_new2/controller/categories.controller.dart';
import 'package:be_casual_new2/model/category.dart';
import 'package:be_casual_new2/model/category.model.dart';
import 'package:be_casual_new2/model/color.model.dart';
import 'package:be_casual_new2/model/fonts.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryOptioTile extends StatefulWidget {
  const CategoryOptioTile({
    super.key,
    required this.categoryOptions,
    this.category,
  });

  final CategoryOptions categoryOptions;

  final CategoryItem? category;
  @override
  State<CategoryOptioTile> createState() => _CategoryOptioTileState();
}

class _CategoryOptioTileState extends State<CategoryOptioTile> {
  // importing category controller
  final categoryController = Get.put(CategoryController());
  @override
  void initState() {
    super.initState();
    log("length${categoryController.categories.length.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // This is the main container using for the decoration with image
        Container(
          width: 130,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            image: DecorationImage(
              image: NetworkImage(widget.category!.image!.first.url.toString()),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // This container only for gradient and text
        Container(
          height: 200,
          width: 130,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, AppColors.black.withOpacity(0.7)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /* name */
              Text(
                categoryController.categories.isNotEmpty
                    ? widget.category!.name.toString()
                    : 'No category found',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: Fonts.medium,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),

              /* price */
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  widget.category!.description.toString(),
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: Fonts.medium,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
