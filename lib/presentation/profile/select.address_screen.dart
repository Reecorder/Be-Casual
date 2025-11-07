import 'package:be_casual_new2/common/common.appbar.dart';
import 'package:be_casual_new2/common/common.title.dart';
import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/controller/addAddress.controller.dart';
import 'package:be_casual_new2/controller/auth.controller.dart';
import 'package:be_casual_new2/model/addressmodel.dart';
import 'package:be_casual_new2/model/color.model.dart';
import 'package:be_casual_new2/presentation/product/cart/cart.screen.dart';
import 'package:be_casual_new2/presentation/profile/address/add.address_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/fonts.model.dart';

class SelectAddressScreen extends StatefulWidget {
  SelectAddressScreen({super.key, this.addressModel});
  final AddressModel? addressModel;
  @override
  State<SelectAddressScreen> createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  final controller = Get.put(AuthController());

  final addresscontroller = Get.put(AddAddressController());
  final authontroller = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    addresscontroller.addressIdfind();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 70),
        child: appbarWidget,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              // current location field
              currentLocationField,
              spacer(height: 20),
              // save address title
              savedAddressTitle,
              // save address lists
              saveAddressList,
              // add address button
              addAddressButton,
            ],
          ),
        ),
      ),
    );
  }

  // appbar widget
  Widget get appbarWidget => CommonAppbar(
    title: "Please Select Your Address",
    subtitle: "",
    divider: true,
  );

  // current loaction field
  Widget get currentLocationField => Container(
    width: Get.width,
    decoration: decoration,
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Text(
          "Current Location",
          style: TextStyle(
            color: AppColors.black.withOpacity(0.9),
            fontSize: 14,
            fontFamily: Fonts.medium,
          ),
        ),
      ),
    ),
  );

  // current location box decoration
  BoxDecoration get decoration => BoxDecoration(
    borderRadius: BorderRadius.circular(5),
    border: Border.all(color: AppColors.black.withOpacity(0.9), width: 2),
  );

  // saved address title
  Widget get savedAddressTitle =>
      CommonTitleRow(title: "Saved Addresses", width: 100);

  Widget get saveAddressList => Obx(() {
    if (addresscontroller.addressidLoader.value) {
      return const Center(child: CircularProgressIndicator());
    }

    if (addresscontroller.addressmodel.isEmpty) {
      return const Center(child: Text("No saved addresses found."));
    }

    return Column(
      children: List.generate(
        addresscontroller.addressmodel.length,
        (index) => addressModelTile(
          index: index,
          model: addresscontroller.addressmodel[index],
        ),
      ),
    );
  });

  Widget addressModelTile({required int index, required AddressModel model}) =>
      Obx(
        () => Padding(
          padding: const EdgeInsets.only(top: 10),
          child: InkWell(
            onTap: () {
              controller.selctedAddress.value = index;
              // Return the selected address to the previous screen instead of
              // pushing a new CartScreen. The caller can await Get.to() and
              // receive this model as the result.
              Get.back(result: model);
            },
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color:
                      controller.selctedAddress.value == index
                          ? AppColors.black.withOpacity(0.9)
                          : Colors.black12,
                  width: controller.selctedAddress.value == index ? 1.5 : 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(model.addressType,
                        //     style: TextStyle(fontFamily: Fonts.medium)),
                        Text(
                          authontroller.userName.value,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),

                        Text(
                          model.addressType,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(221, 40, 40, 40),
                          ),
                        ),
                        Text(
                          model.fullAddress,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(221, 40, 40, 40),
                          ),
                        ),
                        Text(
                          "${model.city}, ${model.state}, ${model.pin}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(221, 40, 40, 40),
                          ),
                        ),
                      ],
                    ),
                    // Image.asset("assets/product/edit.png", height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget addressTile({
    required int index,
    required Map<String, String> address,
  }) => Obx(
    () => Padding(
      padding: const EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: () {
          controller.selctedAddress.value = index;
          Get.to(
            () => const CartScreen(),
            arguments: {
              "fromAddressSelection": true,
              "addressDetails": address,
            },
          );
        },
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color:
                  controller.selctedAddress.value == index
                      ? AppColors.black.withOpacity(0.9)
                      : Colors.black12,
              width: controller.selctedAddress.value == index ? 1.5 : 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(address["name"] ?? "",
                    //     style: TextStyle(fontFamily: Fonts.medium)),
                    Text(widget.addressModel!.city.toString()),
                    Text(address["phone"] ?? ""),
                    Text(
                      address["addressLine1"] ?? "",
                      style: TextStyle(
                        color: AppColors.primary.withOpacity(0.5),
                        height: 1.5,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      address["addressLine2"] ?? "",
                      style: TextStyle(
                        color: AppColors.primary.withOpacity(0.5),
                        height: 1.5,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      address["addressLine3"] ?? "",
                      style: TextStyle(
                        color: AppColors.primary.withOpacity(0.5),
                        height: 1.5,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                // Image.asset("assets/product/edit.png", height: 20),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  /* add address button */
  Widget get addAddressButton => Padding(
    padding: const EdgeInsets.only(top: 30),
    child: InkWell(
      onTap: () async {
        Get.to(() => AddAddressScreen());
        // if (result != null && result is Map<String, String>) {
        //   addresscontroller.addNewAddress(result);
        // }
      },
      child: Container(
        width: Get.width,
        // decoration: decoration,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.black.withOpacity(0.9), width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Text(
              "Add Address",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: Fonts.medium,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
