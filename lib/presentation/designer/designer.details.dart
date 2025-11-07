import 'package:be_casual_new2/common/common.appbar.dart';
import 'package:be_casual_new2/common/common.title.dart';
import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/controller/categories.controller.dart';
import 'package:be_casual_new2/controller/product.controller.dart';
import 'package:be_casual_new2/model/brands.dart';
import 'package:be_casual_new2/model/category.model.dart';
import 'package:be_casual_new2/presentation/dashboard/category.option.tile.dart';
import 'package:be_casual_new2/presentation/designer/chanel.dart';
import 'package:be_casual_new2/presentation/designer/product.tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class DesignerDetailScreen extends StatefulWidget {
  const DesignerDetailScreen({super.key, this.brands});
  final BrandsModel? brands;
  @override
  State<DesignerDetailScreen> createState() => _DesignerDetailScreenState();
}

class _DesignerDetailScreenState extends State<DesignerDetailScreen> {
  // importing category controller
  final categoryController = Get.put(CategoryController());
  final productcontroller = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 70),
        child: CommonAppbar(
          title: "A Brand Gives you Identity",
          subtitle: "Lorem Ipsum is simply dummy text of the printing",
          icon: GestureDetector(
            onTap: () => Get.toNamed('/cart', arguments: {'fromTab': true}),
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
          divider: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /* chanel tile */
            Center(child: ChanelTile(brands: widget.brands)),
            /* spacer */
            spacer(height: 10),

            /* fashion title */
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: CommonTitleRow(
                title: "Available Fashion Options Right Now",
                width: 45,
              ),
            ),

            /* fashion tile */
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: SizedBox(
                height: 200,
                // width: 10
                child: ListView.builder(
                  itemCount: categoryOptionLists.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        CategoryOptioTile(
                          // index: index,
                          category: categoryController.categories[index],
                          categoryOptions: categoryOptionLists[index],
                        ),
                        spacer(width: 8),
                      ],
                    );
                  },
                ),
              ),
            ),

            /* spacer */
            spacer(height: 20),

            /* more item title */
            CommonTitleRow(title: 'Most Favorite Items this Year', width: 50),

            /* product tile*/
            ProductTileScreen(),
          ],
        ),
      ),
    );
  }
}
