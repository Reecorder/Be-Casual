import 'dart:developer';
import 'package:be_casual_new2/common/common.appbar.dart';
import 'package:be_casual_new2/common/common.button.dart';
import 'package:be_casual_new2/common/common.title.dart';
import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/controller/auth.controller.dart';
import 'package:be_casual_new2/controller/cart.controller.dart';
import 'package:be_casual_new2/controller/order-controller.dart';
import 'package:be_casual_new2/controller/product.controller.dart';
import 'package:be_casual_new2/model/addressmodel.dart';
import 'package:be_casual_new2/model/color.model.dart';
import 'package:be_casual_new2/presentation/product/cart/cart.tile.dart';
import 'package:be_casual_new2/presentation/product/cart/fetchdata.dart';
import 'package:be_casual_new2/presentation/product/cart/order.summary.tile.dart';
import 'package:be_casual_new2/presentation/profile/select.address_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, this.fromTab});
  final bool? fromTab;
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final productController = Get.find<ProductController>();
  final authontroller = Get.put(AuthController());
  final orderController = Get.put(OrderController());
  final fetchcartcontroller = Get.put(CartController());
  late bool fromAddressSelection;

  // late Map<String, dynamic>? addressDetails;
  AddressModel? addressDetails;

  @override
  void initState() {
    super.initState();
    log(widget.fromTab.toString());
    final args = Get.arguments ?? {};
    fromAddressSelection = args["fromAddressSelection"] ?? false;
    addressDetails =
        args["addressDetails"] is AddressModel
            ? args["addressDetails"] as AddressModel
            : null;

    // Always fetch the latest cart from the server when opening the cart screen
    // We're already on the cart screen, so avoid navigation inside fetchCart
    fetchcartcontroller.fetchCart(navigateToCart: false);
  }

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final args = Get.arguments ?? {};
    final showHeader =
        (widget.fromTab == true) ||
        (args['fromTab'] == true) ||
        fromAddressSelection;

    // If cart is empty, show appbar and empty message
    if (cartController.productQuantities.isEmpty) {
      return Scaffold(
        appBar:
            showHeader
                ? PreferredSize(
                  preferredSize: Size(Get.width, 70),
                  child: appbarWidget,
                )
                : null,
        body: const Center(
          child: Text("Your cart is empty.", style: TextStyle(fontSize: 18)),
        ),
      );
    }

    // If cart has items, show the normal layout

    return Scaffold(
      appBar:
          showHeader
              ? PreferredSize(
                preferredSize: Size(Get.width, 70),
                child: appbarWidget,
              )
              : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /*  cart item tile */
            Obx(() {
              print('Cart rebuild triggered');
              final cartController = Get.find<CartController>();
              final productController = Get.find<ProductController>();

              print('Cart quantities: ${cartController.productQuantities}');
              print('Product cart: ${productController.cartProducts}');

              // First try to show API fetched cart
              if (fetchcartcontroller.fetchcart.isNotEmpty) {
                return FetchCartScreen();
              }

              // If no API data, show local cart
              final cartProducts =
                  productController.cartProducts.values.toList();
              if (cartProducts.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Your cart is empty.",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                );
              }

              // Show local cart items
              return Column(
                children:
                    productController.cartProducts.values.map((product) {
                      final quantity =
                          cartController.productQuantities[product.id] ?? 0;
                      final selectedSize =
                          productController.selectedSizes[product.id] ?? "";

                      return CartTile(
                        product: product,
                        quantity: quantity,
                        selectedSize: selectedSize,
                        isItemAddRemoveButton: true,
                      );
                    }).toList(),
              );
            }),
            spacer(height: 20),
            /* order summary title */
            orderSummaryTitle,
            /* order summary tile */
            orderSummaryTile,
            if (fromAddressSelection) selectedAddressWidget,
            /* select address button */
            selectAddressButton,
          ],
        ),
      ),
    );
  }

  /* appbar widget */
  Widget get appbarWidget => CommonAppbar(
    title: "Your Fashion Cart",
    subtitle: "Lorem Ipsum is simply dummy text of the printing",
    divider: true,
    onBackTap:
        fromAddressSelection
            ? () {
              Get.back();
            }
            : () {
              // Pop to previous screen instead of pushing a new BaseScreen to avoid
              // multiple rebuilds / duplicate controllers. Use back() so navigation
              // behaves as a normal back action.
              Get.back();
            },
  );
  //  Widget get cartItemTile => CartTile();
  Widget get cartItemTile => Obx(() {
    final cartProducts = productController.cartProducts.values.toList();
    if (cartProducts.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Text("Your cart is empty."),
      );
    }

    return Column(
      children: List.generate(cartProducts.length, (index) {
        final product = cartProducts[index];
        final quantity = productController.productCounts[product.id] ?? 1;
        final selectedSize = productController.selectedSizes[product.id] ?? "";
        return InkWell(
          onTap: () {
            log("message");
          },
          child: CartTile(
            product: product,
            quantity: quantity,
            isItemAddRemoveButton: true,
            selectedSize: selectedSize,

            // cartModel: cartModelLists[index],
          ),
        );
      }),
    );
  });

  /* order summary title */
  Widget get orderSummaryTitle =>
      CommonTitleRow(title: "Order Summary", width: 120);

  /* order summary tile */
  // Widget get orderSummaryTile =>  OrderSummaryTile();
  Widget get orderSummaryTile {
    final cartProducts = productController.cartProducts.values.toList();
    double itemTotal = 0;

    for (var product in cartProducts) {
      final quantity = productController.productCounts[product.id] ?? 1;
      itemTotal += (product.discountedPrice ?? 0) * quantity;
    }

    double gst = 0.02 * itemTotal;
    double delivery = itemTotal > 500 ? 0 : 30;
    double grandTotal = itemTotal + gst + delivery;

    return OrderSummaryTile(
      itemTotal: itemTotal,
      gst: gst,
      delivery: delivery,
      grandTotal: grandTotal,
    );
  }

  /* select address button */
  Widget get selectAddressButton => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: CommonButton(
      buttonText: fromAddressSelection ? "Buy Now" : "Select Address",
      onPressed: () {
        if (fromAddressSelection) {
          final cartProducts = productController.cartProducts.values.toList();
          // Check if any product has an empty size
          bool hasMissingSize = cartProducts.any((product) {
            final selectedSize =
                productController.selectedSizes[product.id] ?? "";
            return selectedSize.isEmpty;
          });

          if (hasMissingSize) {
            Get.snackbar(
              "Size Required",
              "Please select size for all products before placing order.",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red.shade100,
              colorText: Colors.black,
            );
            return;
          }
          // Get cart total
          double totalAmount = 0;
          for (var product in cartProducts) {
            final quantity = productController.productCounts[product.id] ?? 1;
            totalAmount += (product.discountedPrice ?? 0) * quantity;
          }

          // Navigate to checkout
          Get.toNamed(
            '/checkout',
            arguments: {'address': addressDetails!, 'totalAmount': totalAmount},
          );
        } else {
          // Navigate to address selection and await the selected address.
          // The SelectAddressScreen will return the chosen AddressModel via
          // Get.back(result: model). We handle the returned model here to
          // avoid pushing a new CartScreen from the select screen.
          () async {
            final result = await Get.to(() => SelectAddressScreen());
            if (result != null && result is AddressModel) {
              setState(() {
                addressDetails = result;
                fromAddressSelection = true;
              });
            }
          }();
        }
      },
      borderRadius: 5,
      // color: fromAddressSelection ? Colors.green : AppColors.primary,
      color: AppColors.primary,
    ),
  );
  Widget get selectedAddressWidget =>
      addressDetails == null
          ? const SizedBox.shrink()
          : Container(
            width: Get.width,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black.withOpacity(0.6),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Deliver To: ${addressDetails!.addressType}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    // InkWell(
                    //     onTap: () {
                    //       // Get.to(() => SelectAddressScreen());
                    //       Get.off(() => SelectAddressScreen());
                    //     },
                    //     child: const Icon(Icons.cached, size: 20))
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  authontroller.userName.toString(),
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  authontroller.userphoneNumber.toString(),
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  addressDetails!.fullAddress,
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  "${addressDetails!.city}, ${addressDetails!.state}, ${addressDetails!.pin}",
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          );
}
