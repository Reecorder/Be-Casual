import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/model/color.model.dart';
import 'package:be_casual_new2/model/order.track.model.dart';
import 'package:flutter/material.dart';

class OrderTrackTile extends StatelessWidget {
  OrderTrackTile({super.key, required this.orderTrackModel, this.index});
  OrderTrackModel orderTrackModel;
  int? index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //title
        Expanded(
            child: Text(
          orderTrackModel.title.toString(),
          style: const TextStyle(fontSize: 12),
        )),
        Column(
          children: [
            CircleAvatar(
              radius: 6,
              backgroundColor: AppColors.black.withOpacity(0.9),
            ),
            index == 3
                ? const SizedBox()
                : SizedBox(
                    height: 60,
                    child: VerticalDivider(
                      color: AppColors.black.withOpacity(0.5),
                    ),
                  )
          ],
        ),
        spacer(width: 10),
        Expanded(
            child: Text(orderTrackModel.subTitle.toString(),
                style: const TextStyle(fontSize: 12, color: Colors.black12)))
      ],
    );
  }
}
