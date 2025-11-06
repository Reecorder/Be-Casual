import 'package:be_casual_new2/common/common.textfield.dart';
import 'package:be_casual_new2/common/common.title.dart';
import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/controller/base.controller.dart';
import 'package:be_casual_new2/controller/product.controller.dart';
import 'package:be_casual_new2/presentation/designer/product.tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = Get.put(BaseController());
  final productcontroller = Get.put(ProductController());
  @override
  void initState() {
    super.initState();
    // productcontroller.allproductsfind();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      divider,
      // search box
      searchBox,
      // search items
      searchItems,
      // favorite item title
      // favoriteItemmTite,
      // favorite items
      // searchItems
    ]));
  }

  // search box
  Widget get searchBox => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: CommonTextField(
          controller: controller.searchController,
          suffixicon: Feather.search,
          hint: 'Indian Ethnic Dress in Red Color'));

  // search item
  Widget get searchItems => const ProductTileScreen(
        fromTab: true,
      );

  // more favorite i
  Widget get favoriteItemmTite =>
      CommonTitleRow(title: "Most Favorite Items this Year", width: 80);
}
