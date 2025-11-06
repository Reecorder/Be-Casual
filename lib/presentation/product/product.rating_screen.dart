import 'package:be_casual_new2/common/common.appbar.dart';
import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/controller/product.controller.dart';
import 'package:be_casual_new2/model/color.model.dart';
import 'package:be_casual_new2/model/fonts.model.dart';
import 'package:be_casual_new2/model/product.rating.model.dart';
import 'package:be_casual_new2/model/products.dart';
import 'package:be_casual_new2/presentation/product/filter.option_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class ProductRatingScreen extends StatefulWidget {
  ProductRatingScreen({super.key, required this.productsModel});
  final ProductsModel productsModel;
  @override
  State<ProductRatingScreen> createState() => _ProductRatingScreenState();
}

class _ProductRatingScreenState extends State<ProductRatingScreen> {
  final controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(Get.width, 70), child: appbarWidget),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /* product detail row */
            productDetailRow,
            /* review field */
            reviewField,
            /* rating type */
            ratingType,
            /* rating tile */
            ratingTile
          ],
        ),
      ),
    );
  }

  /* appbar  */
  Widget get appbarWidget => CommonAppbar(
        title: "Indian Dress with Shopping Bags",
        subtitle: "Lorem Ipsum is simply dummy text of the printing",
        // icon: ,
        // icon: Icon(Feather.shopping_bag),
        icon: Stack(children: [
          const Icon(Feather.shopping_bag),
          Positioned(
              right: 0,
              bottom: 6,
              child: Obx(() {
                final total = controller.productCounts.values
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
        divider: true,
      );

  /* product detail row */
  Widget get productDetailRow => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /* product image */
            productImage,
            /* title + subtitle */
            spacer(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /* title */
                  title,
                  /* subtitle */
                  subtitle,
                  /* price */
                  price,
                ],
              ),
            )
          ],
        ),
      );

  /* imagetile */
  Widget get productImage => Container(
      height: 100,
      width: 150,
      decoration: decoration,
      child: Align(
        alignment: Alignment.bottomRight,
        child: brandImage,
      ));

  /* conatiner decoration */
  BoxDecoration get decoration => BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      image: DecorationImage(
          fit: BoxFit.cover,
          // image: AssetImage("assets/dashboard/cat5.jpg"),
          image:
              NetworkImage(widget.productsModel.images!.first.url.toString())));

  /* brand image */
  Widget get brandImage => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              // "assets/dashboard/brand1.png",
              widget.productsModel.brand!.logo!.first.url.toString(),
              height: 30,
              fit: BoxFit.cover,
            )),
      );

  /* title */
  Widget get title => Text(
        // "Indian Dress with Shopping Bags",
        widget.productsModel.name.toString(),
        style: TextStyle(
            color: AppColors.primary,
            fontSize: 13,
            height: 1,
            fontFamily: Fonts.medium),
      );

  Widget get subtitle => Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Text(
          // "Lorem Ipsum is simply dummy text",
          widget.productsModel.description.toString(),
          style: TextStyle(
            color: AppColors.primary.withOpacity(0.6),
            fontSize: 12,
          ),
        ),
      );

  /* price text */
  Widget get price => Text(
        // "\$650",
        "\$${widget.productsModel.originalPrice}",
        style: TextStyle(
            color: AppColors.primary, fontFamily: Fonts.medium, fontSize: 18),
      );

  /* review text field */
  Widget get reviewField => Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
          height: 50,
          width: Get.width,
          decoration: reviewDecoration,
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text("Write a review",
                  style: TextStyle(
                      color: AppColors.primary, fontFamily: Fonts.light)))));

  /* review box dcoration */
  BoxDecoration get reviewDecoration => BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: Colors.black12));

  /* rating type */
  Widget get ratingType => FilterOptionTile(
        filterList: ratingTypeList,
        // controller: controller,
        color: AppColors.black.withOpacity(0.9),
        fontSize: 14,
      );

  /* rating tile */
  Widget get ratingTile => Column(
        children: [
          ...List.generate(
            widget.productsModel.reviews!.length,
            (index) => RatingTile(
                ratingModel: ratingLists[index],
                productsModel: widget.productsModel,
                review: widget.productsModel.reviews![index]),
          )
        ],
      );
}

/* rating type list */
List ratingTypeList = ["Top Ratings", "Worse Ratings", "Show me all"];

class RatingTile extends StatefulWidget {
  RatingTile(
      {super.key,
      required this.ratingModel,
      required this.productsModel,
      required this.review});
  final ProductsModel productsModel;
  ProductRatingModel ratingModel;
  final String review;

  @override
  State<RatingTile> createState() => _RatingTileState();
}

class _RatingTileState extends State<RatingTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              /* profile image */
              profileImage,
              spacer(width: 10),
              /* comment */
              commentColumn,
            ])),
        reviewImage,
        divider
      ],
    );
  }

  /* image */
  Widget get profileImage => CircleAvatar(
        radius: 35,
        backgroundImage: AssetImage(widget.ratingModel.profileImage.toString()),
      );

  /* comments  column*/
  Widget get commentColumn => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* rating comment */
          ratingComment,
          spacer(height: 10),
          ratingStar
        ],
      );

  /* comment  */
  Widget get ratingComment => Text(
        // widget.ratingModel.comments.toString(),
        // widget.productsModel.reviews.toString(),
        // widget.productsModel.reviews!.join("\n"),
        widget.review,
        style: TextStyle(
            color: AppColors.primary.withOpacity(0.8),
            fontFamily: Fonts.medium,
            fontSize: 11),
      );

  /* rating star */
  Widget get ratingStar => Row(
        children: [
          ...List.generate(
              widget.ratingModel.rating!,
              (index) => const Icon(
                    Icons.star_sharp,
                    color: Colors.amber,
                  ))
        ],
      );

  /* review image */
  Widget get reviewImage => Padding(
        padding: const EdgeInsets.only(left: 100),
        child: SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                height: 120,
                width: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                        image:
                            AssetImage(widget.ratingModel.imageList![index]))),
              );
            },
            separatorBuilder: (context, index) {
              return spacer(width: 8);
            },
            itemCount: widget.ratingModel.imageList!.length,
          ),
        ),
      );
}
