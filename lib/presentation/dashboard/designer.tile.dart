import 'package:be_casual_new2/controller/banner.controller.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DesignerTile extends StatefulWidget {
const  DesignerTile({super.key});

  @override
  State<DesignerTile> createState() => _DesignerTileState();
}

class _DesignerTileState extends State<DesignerTile> {
  final bannerController = Get.put(BannerController());

  int _currentIndex = 0;
  @override
  void initState() {
    bannerController.bannerfind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 250,
            child: Obx(() {
              if (bannerController.bannerLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (bannerController.banners.isEmpty) {
                return const Center(child: Text("No banners found"));
              }
              return Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 228,
                      enlargeCenterPage: false, // no zoom on center
                      autoPlay: true,
                      viewportFraction: 1.0, // full width
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    items:
                        bannerController.banners.map((imageUrl) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: SizedBox(
                              width:
                                  MediaQuery.of(
                                    context,
                                  ).size.width, // full width
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  12,
                                ), // set to 0 for full bleed
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          const Icon(
                                            Icons.broken_image,
                                            size: 50,
                                          ),
                                  loadingBuilder: (
                                    context,
                                    child,
                                    loadingProgress,
                                  ) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(bannerController.banners.length, (
                      index,
                    ) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentIndex == index ? 8 : 6,
                        height: _currentIndex == index ? 8 : 6,
                        decoration: BoxDecoration(
                          color:
                              _currentIndex == index
                                  ? Colors.black
                                  : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
