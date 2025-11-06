import 'package:be_casual_new2/common/common.appbar.dart';
import 'package:be_casual_new2/controller/product.controller.dart';
import 'package:be_casual_new2/presentation/designer/product.tile.dart';
import 'package:be_casual_new2/presentation/product/filter.option_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final productcontroller = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(Get.width, 70), child: appbarWidget),
        body: SingleChildScrollView(
            child: Column(children: [
          /* spacer */
          // spacer(height: 10),
          /* filter option  */
          filterOptions,

          /* product tile screen  */
          productTile
        ])));
  }

  /* appbar */
  Widget get appbarWidget => CommonAppbar(
        title: "Items based on Indian Ethnic Wear",
        subtitle: "Lorem Ipsum is simply dummy text of the printing",
        // icon: Feather.shopping_bag,
        // icon: Icon(Feather.shopping_bag),
        icon: Stack(children: [
          const Icon(Feather.shopping_bag),
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
        ]),
        divider: false,
      );

  /* filter optiona */
  Widget get filterOptions => FilterOptionTile(
        filterList: filterOptionsLists,
        //  controller: productcontroller,
      );

  /* filter option decoration */
  BoxDecoration get decoration => BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: Colors.black12));

  /* product tile */
  Widget get productTile =>const ProductTileScreen();
}

List filterOptionsLists = [
  "Relevant",
  "Premium Quality",
  "Rating 4.0+",
  "Price: Low to High",
  "Price: High to Low"
];
