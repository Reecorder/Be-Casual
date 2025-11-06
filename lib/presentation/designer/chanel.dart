import 'package:be_casual_new2/common/common.button.dart';
import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/model/brands.dart';
import 'package:be_casual_new2/model/color.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChanelTile extends StatefulWidget {
  const ChanelTile({super.key, this.brands});
  final BrandsModel? brands;
  @override
  State<ChanelTile> createState() => _ChanelTileState();
}

class _ChanelTileState extends State<ChanelTile> {
  ValueNotifier<bool> isSelected = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /* spacer */
        spacer(height: 10),
        /* image */
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            widget.brands!.logo!.first.url.toString(),
            fit: BoxFit.cover,
            height: 100,
            width: 100,
          ),
        ),
        /* chanel name */
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            // "Coco Chanel",
            widget.brands!.name.toString(),
            style: TextStyle(
              color: AppColors.black.withOpacity(0.9),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        /* subtitle */
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Gabrielle Chanel lived her life as she alone intended. The trials of a childhood as an orphan. and the successes of an accomplished businesswoman gave birth to an extraordinary character.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primary.withOpacity(0.6),
              fontSize: 12,
            ),
          ),
        ),
        /* spacer */
        spacer(height: 20),
        /* follow button */
        CommonButton(
          buttonText: "Follow",
          onPressed: () {
            Get.snackbar(
              "Success",
              "You have successfully followed!",
              backgroundColor: Colors.grey.shade200,
              colorText: Colors.black,
              snackPosition: SnackPosition.TOP,
              margin: const EdgeInsets.all(10),
            );
          },
          borderRadius: 5,
          buttonSize: const Size(120, 50),
          color: AppColors.black.withOpacity(0.9),
        ),
      ],
    );
  }
}
