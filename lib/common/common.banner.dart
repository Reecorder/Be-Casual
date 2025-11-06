import 'package:be_casual_new2/model/color.model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CommonBanner extends StatefulWidget {
  const CommonBanner({super.key});

  @override
  State<CommonBanner> createState() => _CommonBannerState();
}

class _CommonBannerState extends State<CommonBanner> {
  final ValueNotifier<int> carouselIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
          height: 100,
          child: CarouselSlider(
              options: options,
              items: List.generate(imageList.length,
                  (index) => carouselItemTile(image: imageList[index]))))
    ]);
  }

  //------------------------------------------------------------
  // Carousel item tile
  Widget carouselItemTile({required String image}) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Container(
        // height: 1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppColors.black.withOpacity(0.9)),
            image: DecorationImage(
                image: AssetImage(image), fit: BoxFit.cover, scale: 1.0))),
  );

  //------------------------------------------------------------
  // Carousel Options
  CarouselOptions get options => CarouselOptions(
      height: 150,
      viewportFraction: 0.8,
      autoPlay: true,
      enlargeCenterPage: true,
      onPageChanged: (index, reason) {
        carouselIndex.value = index;
      });

  final imageList = [
    "assets/baseScreen/banner.png",
    "assets/baseScreen/banner.png",
    "assets/baseScreen/banner.png",
  ];
}
