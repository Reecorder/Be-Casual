import 'dart:developer';

import 'package:be_casual_new2/common/common.appbar.dart';
import 'package:be_casual_new2/common/common.button.dart';
import 'package:be_casual_new2/common/common.title.dart';
import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/controller/cart.controller.dart';
import 'package:be_casual_new2/controller/order-controller.dart';
import 'package:be_casual_new2/services/cookie_services.dart';
import 'package:be_casual_new2/model/addressmodel.dart';
import 'package:be_casual_new2/presentation/dashboard/dashboard.dart';
import 'package:be_casual_new2/presentation/base_screen/base_screen.dart';
import 'package:be_casual_new2/presentation/order/order.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    super.key,
    required this.address,
    required this.totalAmount,
  });

  final AddressModel address;
  final double totalAmount;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final cartController = Get.find<CartController>();
  int selectedPaymentMethod = 0;

  double get _totalAmountWithCharges =>
      widget.totalAmount + 40.0 + (widget.totalAmount * 0.18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 70),
        child: CommonAppbar(
          title: "Checkout",
          subtitle: "Complete your order",
          divider: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Delivery Address Section
              CommonTitleRow(title: "Delivery Address", width: Get.width * 0.3),
              spacer(height: 10),
              AddressCard(address: widget.address),
              spacer(height: 20),

              // Payment Methods Section
              CommonTitleRow(title: "Payment Method", width: Get.width * 0.3),
              spacer(height: 10),
              PaymentMethodsList(
                selectedMethod: selectedPaymentMethod,
                onMethodSelected: (index) {
                  setState(() {
                    selectedPaymentMethod = index;
                  });
                },
              ),
              spacer(height: 20),

              OrderSummaryCard(
                subtotal: widget.totalAmount,
                deliveryCharge: 40.0,
                tax: widget.totalAmount * 0.18,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: CommonButton(
            buttonText: "Place Order",
            onPressed: _handlePlaceOrder,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  void _handlePlaceOrder() async {
    try {
      // Show loading indicator
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      // Simulate API call with delay
      await Future.delayed(const Duration(seconds: 2));

      // Remove loading indicator
      Get.back();

      // Call API to create order
      final orderController = Get.find<OrderController>();
      final userId = await getCookie(key: 'userId');
      String cartId = '';
      if (cartController.fetchcart.isNotEmpty &&
          (cartController.fetchcart[0].id?.isNotEmpty ?? false)) {
        cartId = cartController.fetchcart[0].id!;
      } else {
        // Create cart on server from local items
        cartId = await cartController.createCart() ?? '';
      }

      if (cartId.isEmpty) {
        Get.snackbar(
          "Error",
          "Cart could not be created. Please try again.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      final paymentMethodStr =
          selectedPaymentMethod == 0
              ? 'cod'
              : selectedPaymentMethod == 1
              ? 'card'
              : 'upi';
      final createdOrder = await orderController.createOrder(
        userId: userId ?? '',
        cartId: cartId,
        addressId: widget.address.id,
        totalAmount: _totalAmountWithCharges.toInt(),
        paymentMethod: paymentMethodStr,
      );
      log('Created Order: ${createdOrder?.toJson().toString() ?? 'null'}');
      // Simulate API call with delay
      await Future.delayed(const Duration(seconds: 2));
      if (createdOrder == null) {
        // Fallback: show error snackbar
        Get.snackbar(
          "Error",
          "Unable to place order. Please try again.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      final orderId =
          createdOrder.orderId ??
          createdOrder.id ??
          DateTime.now().millisecondsSinceEpoch.toString().substring(7);

      // Show success dialog (custom styled)
      Get.dialog(
        Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Order Placed!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your order #$orderId has been placed successfully.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back(); // close dialog
                          // Navigate to home (base screen)
                          Get.offAll(() => const BaseScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Shope More',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Get.back();
                          // Navigate to OrderScreen and skip remote fetch so local order is visible
                          Get.to(
                            () => const OrderScreen(fromTab: true),
                            arguments: {'skipFetch': true},
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('View Orders'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );
    } catch (e) {
      Get.back(); // Remove loading indicator
      Get.snackbar(
        "Error",
        "Failed to place order. Please try again.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

class AddressCard extends StatelessWidget {
  const AddressCard({super.key, required this.address});

  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                address.addressType,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.location_on,
                size: 20,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
          spacer(height: 10),
          Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                address.fullAddress,
                style: const TextStyle(fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              spacer(height: 5),
              Text(
                '${address.city}, ${address.state}',
                style: const TextStyle(fontSize: 14),
              ),
              Text(
                'PIN: ${address.pin}',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PaymentMethodsList extends StatelessWidget {
  const PaymentMethodsList({
    super.key,
    required this.selectedMethod,
    required this.onMethodSelected,
  });

  final int selectedMethod;
  final Function(int) onMethodSelected;

  @override
  Widget build(BuildContext context) {
    final paymentMethods = [
      {'name': 'Cash on Delivery', 'icon': Feather.dollar_sign},
      {'name': 'Credit/Debit Card', 'icon': Feather.credit_card},
      {'name': 'UPI', 'icon': Feather.smartphone},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: List.generate(
          paymentMethods.length,
          (index) => Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: RadioListTile(
                  value: index,
                  groupValue: selectedMethod,
                  onChanged: (value) => onMethodSelected(value!),
                  title: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          paymentMethods[index]['icon'] as IconData,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                      ),
                      spacer(width: 12),
                      Text(
                        paymentMethods[index]['name'] as String,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  controlAffinity: ListTileControlAffinity.trailing,
                  activeColor: Theme.of(context).primaryColor,
                  visualDensity: VisualDensity.compact,
                ),
              ),
              if (index < paymentMethods.length - 1)
                const Divider(height: 1, indent: 16, endIndent: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({
    super.key,
    required this.subtotal,
    required this.deliveryCharge,
    required this.tax,
  });

  final double subtotal;
  final double deliveryCharge;
  final double tax;

  @override
  Widget build(BuildContext context) {
    final total = subtotal + deliveryCharge + tax;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildSummaryRow("Subtotal", "\$${subtotal.toStringAsFixed(2)}"),
          _buildSummaryRow(
            "Delivery Charge",
            "\$${deliveryCharge.toStringAsFixed(2)}",
          ),
          _buildSummaryRow("Tax (18%)", "\$${tax.toStringAsFixed(2)}"),
          const Divider(height: 1),
          spacer(height: 10),
          _buildSummaryRow(
            "Total",
            "\$${total.toStringAsFixed(2)}",
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isBold ? 16 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isBold ? 16 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
