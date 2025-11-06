import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/controller/order-controller.dart';
import 'package:be_casual_new2/model/color.model.dart';
import 'package:be_casual_new2/model/fonts.model.dart';
import 'package:be_casual_new2/model/order.model.dart';
import 'package:be_casual_new2/presentation/base_screen/home.top.section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key, this.fromTab});
  final bool? fromTab;
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final ordercontroller = Get.put(OrderController());

  @override
  void initState() {
    super.initState();
    ordercontroller.orderIdfind();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.fromTab == true)
          ? PreferredSize(
              preferredSize: Size(Get.width, 70),
              child:  HomeTopSection(),
            )
          : null,
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: Obx(() {
            if (ordercontroller.orderidLoader.value) {
              // Show loader while fetching
              return const Center(child: CircularProgressIndicator());
            } else if (ordercontroller.ordermodel.isEmpty) {
              // Show empty state
              return const Center(child: Text("No orders found"));
            } else {
              // Show order list
              return SingleChildScrollView(
                  child: Column(children: [
                // Padding(
                //   padding: const EdgeInsets.all(15),
                //   child: Obx(() {
                //     return ListView.builder(
                //       shrinkWrap: true,
                //       physics: const NeverScrollableScrollPhysics(),
                //       itemCount: ordercontroller.ordermodel.length,
                //       itemBuilder: (context, index) {
                //         final order = ordercontroller.ordermodel[index];
                //         return ListTile(
                //             subtitle: Text(
                //           'Status: ${order.status}\nPayment: ${order.paymentMethod}',
                //         ));
                //       },
                //     );
                //   }),
                // ),
                ...List.generate(
                    ordercontroller.ordermodel.length,
                    (index) => Column(children: [
                          // order detail tile
                          // OrderDetailTile(orderModel: orderLists[index]),
                          InkWell(
                              onTap: () {
                                // Get.to(() => const OrderDetailScreen());
                              },
                              child: Container(
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border:
                                          Border.all(color: Colors.black12)),
                                  child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(children: [
                                        Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                              /* order id */
                                              Text(
                                                  // orderModel.id.toString(),
                                                  "Order Id: ${ordercontroller.ordermodel[index].orderId.toString()}",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          Fonts.medium)),
                                              // Text(
                                              //     ordercontroller
                                              //         .ordermodel[index]
                                              //         .cart!
                                              //         .items!
                                              //         .first
                                              //         .product
                                              //         .toString(),
                                              //     style: TextStyle(
                                              //         fontSize: 13,
                                              //         color: AppColors.primary
                                              //             .withOpacity(0.9))),
                                              // const SizedBox(width: 10),
                                              // Text(
                                              //     "Qty: ${ordercontroller.ordermodel[index].cart?.totalQty??'2'}",
                                              //     style: TextStyle(
                                              //         fontSize: 13,
                                              //         color: AppColors.primary
                                              //             .withOpacity(0.9))),
                                              // Text(
                                              //     "Amount: ${ordercontroller.ordermodel[index].totalAmount.toString()}",
                                              //     style: TextStyle(
                                              //         fontSize: 13,
                                              //         color: AppColors.primary
                                              //             .withOpacity(0.9))),
                                              Text(
                                                  "Payment Method: ${ordercontroller.ordermodel[index].paymentMethod.toString()}",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: AppColors.primary
                                                          .withOpacity(0.9))),
                                              Text(
                                                  "Date: ${DateTime.parse(ordercontroller.ordermodel[index].createdAt!).toString().substring(0, 10)}",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: AppColors.primary
                                                          .withOpacity(0.9)))
                                            ])),
                                        spacer(width: 20),
                                        /* order status */
                                        Text(
                                            ordercontroller
                                                .ordermodel[index].status
                                                .toString(),
                                            style: TextStyle(
                                              color: getOrderStatusColor(
                                                  ordercontroller
                                                      .ordermodel[index].status
                                                      .toString()),
                                            ))
                                      ])))),
                          spacer(height: 10)
                        ]))
              ]));
            }
          })),
    );
  }

  Color getOrderStatusColor(String status) {
    if (status == "pending") {
      return Colors.red;
    } else if (status == "Ordered") {
      return const Color(0xFFD3BE00);
    } else if (status == "shipped") {
      return const Color(0xFF660077);
    } else if (status == "Out for Delivery") {
      return const Color(0xFFD30072);
    } else if (status == "Delivered") {
      return const Color(0xFF007713);
    }
    return AppColors.primary.withOpacity(0.5);
  }
}

/* order detail tile */
class OrderDetailTile extends StatelessWidget {
  OrderDetailTile({super.key, required this.orderModel});
  OrderModel orderModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // Get.to(() => const OrderDetailScreen());
        },
        child: Container(
            width: Get.width,
            decoration: decoration,
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(children: [
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        /* order id */
                        orderId,
                        /* ordered product */
                        orderedProduct,
                        /* order date */
                        orderedDate
                      ])),
                  spacer(width: 20),
                  /* order status */
                  orderedStatus
                ]))));
  }

  /* box decoration */
  BoxDecoration get decoration => BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: Colors.black12));

  /* order id */
  Widget get orderId => Text(orderModel.id.toString(),
      style: TextStyle(fontFamily: Fonts.medium));

  /* ordered product */
  Widget get orderedProduct =>
      Text(orderModel.detail.toString(), style: textStyle);

  /* ordered date */
  Widget get orderedDate =>
      Text(orderModel.orderDate.toString(), style: textStyle);

  /* ordered status */
  Widget get orderedStatus => Text(orderModel.orderStatus.toString(),
      style: TextStyle(color: orderStatusColor));

  Color get orderStatusColor {
    if (orderModel.orderStatus.toString() == "Ordered") {
      return const Color(0xFFD3BE00);
    } else if (orderModel.orderStatus.toString() == "Shipped") {
      return const Color(0xFF660077);
    } else if (orderModel.orderStatus.toString() == "Out for Delivery") {
      return const Color(0xFFD30072);
    } else if (orderModel.orderStatus.toString() == "Delivered") {
      return const Color(0xFF007713);
    }
    return AppColors.primary.withOpacity(0.5);
  }

  /* textstyle */
  TextStyle get textStyle =>
      TextStyle(fontSize: 12, color: AppColors.primary.withOpacity(0.5));
}
