
import 'package:be_casual_new2/common/common.appbar.dart';
import 'package:be_casual_new2/common/common.title.dart';
import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/model/cart.model.dart';
import 'package:be_casual_new2/model/fonts.model.dart';
import 'package:be_casual_new2/model/order.track.model.dart';
import 'package:be_casual_new2/presentation/order/order.track.tile.dart';
import 'package:be_casual_new2/presentation/product/cart/cart.tile.dart';
import 'package:be_casual_new2/presentation/product/cart/order.summary.tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(Get.width, 70), child: appbarWidget),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            spacer(height: 10),
            /* shipped button */
            shippedButton,
            spacer(height: 10),
            orderItemTile,
            spacer(height: 20),
            /* order summary title */
            orderSummaryTitle,
            /* order summary tile */
            // const OrderSummaryTile(),
            divider,
            /* order date */
            orderedDate,
            /* order track */
            orderTrackList,
            /* cancel order button */
            cancelOrderButton,
            //  StepperTest()
          ],
        ),
      ),
    );
  }

  /* appbar  */
  Widget get appbarWidget => CommonAppbar(
        title: "Your Fashion Cart",
        subtitle: "Lorem Ipsum is simply dummy text of the printing",
        icon: null,
        divider: true,
      );

  /* item tile */
  Widget get orderItemTile => Column(
        children: [
          ...List.generate(
              2,
              (index) => CartTile(
                    cartModel: cartModelLists[0],
                    isItemAddRemoveButton: false,
                    height: 125,
                  ))
        ],
      );

  /* shipped   button */
  Widget get shippedButton => Center(
        child: Container(
          width: 100,
          decoration: decoration,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
                child: Text(
              "Shipped",
              style: TextStyle(
                  color: const Color(0xFF660077),
                  fontSize: 14,
                  fontFamily: Fonts.medium),
            )),
          ),
        ),
      );

  /* current location box decoration */
  BoxDecoration get decoration => BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: const Color(0xFF660077), width: 1.5));

  /* order summary title */
  Widget get orderSummaryTitle =>
      CommonTitleRow(title: "Order Summary", width: 125);

  /* ordered date  */
  Widget get orderedDate => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
          child: const Padding(
            padding: EdgeInsets.all(2),
            child: Text(
              "Ordered On 25th December, 2023",
              style: TextStyle(color: Colors.black54, fontSize: 12),
            ),
          ),
        ),
  );

  /* cancel order  button */
  Widget get cancelOrderButton => Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border:
                  Border.all(color: const Color(0xFFBB1918).withOpacity(0.5))),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Cancel Order",
              style: TextStyle(color: Color(0xFFBB1918)),
            ),
          ),
        ),
      );

  /* order track list */
  Widget get orderTrackList => Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(5)),
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                ...List.generate(
                  orderStatusLists.length,
                  (index) => OrderTrackTile(
                    orderTrackModel: orderStatusLists[index],
                    index: index,
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
