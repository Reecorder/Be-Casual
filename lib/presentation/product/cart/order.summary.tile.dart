
import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/model/color.model.dart';
import 'package:be_casual_new2/model/fonts.model.dart';
import 'package:flutter/material.dart';

// class OrderSummaryTile extends StatelessWidget {
//   const OrderSummaryTile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Column(
//         children: [
//           /* price + tax detail */
//           ...List.generate(priceModelList.length,
//               (index) => totalPriceTaxTile(priceModel: priceModelList[index])),
//           /* grand total price  */
//           grandTotalPrice
//         ],
//       ),
//     );
//   }

//   /* item total tile */
//   Widget totalPriceTaxTile({required PriceModel priceModel}) => Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               /* title */
//               Text(
//                 priceModel.title.toString(),
//                 style: priceStyle,
//               ),
//               Text(
//                 priceModel.price.toString(),
//                 style: priceStyle,
//               )
//             ],
//           ),
//           divider
//         ],
//       );

//   /* price style */
//   TextStyle get priceStyle => TextStyle(color: AppColors.primary, fontSize: 14);

//   /*grand total price */
//   Widget get grandTotalPrice => Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             "Grand Total",
//             style: grandTotalPriceStyle,
//           ),
//           Text(
//             "\$540",
//             style: grandTotalPriceStyle,
//           )
//         ],
//       );

//   /* grand total price style */
//   TextStyle get grandTotalPriceStyle =>
//       TextStyle(color: AppColors.primary, fontFamily: Fonts.bold, fontSize: 14);
// }

// class PriceModel {
//   String? title;
//   String? price;
//   PriceModel({this.title, this.price});
// }

// List<PriceModel> priceModelList = [
//   PriceModel(title: "Item Total", price: "\$500"),
//   PriceModel(title: "GST and other taxes", price: "\$10"),
//   PriceModel(title: "Delivery Cost", price: "\$30")
// ];
class OrderSummaryTile extends StatelessWidget {
  final double itemTotal;
  final double gst;
  final double delivery;
  final double grandTotal;

  const OrderSummaryTile({
    super.key,
    required this.itemTotal,
    required this.gst,
    required this.delivery,
    required this.grandTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          priceRow("Item Total", itemTotal),
          priceRow("GST and other taxes", gst),
          priceRow("Delivery Cost", delivery),
          grandTotalRow(grandTotal)
        ],
      ),
    );
  }

  Widget priceRow(String title, double value) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: priceStyle),
              Text("\$${value.toStringAsFixed(2)}", style: priceStyle),
            ],
          ),
          divider,
        ],
      );

  Widget grandTotalRow(double value) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Grand Total", style: grandTotalPriceStyle),
          Text("\$${value.toStringAsFixed(2)}", style: grandTotalPriceStyle),
        ],
      );

  TextStyle get priceStyle =>
      TextStyle(color: AppColors.primary, fontSize: 14);

  TextStyle get grandTotalPriceStyle =>
      TextStyle(color: AppColors.primary, fontFamily: Fonts.bold, fontSize: 14);
}
