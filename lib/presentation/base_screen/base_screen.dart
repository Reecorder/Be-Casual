import 'package:be_casual_new2/controller/base.controller.dart';
import 'package:be_casual_new2/presentation/base_screen/bottom.nav.dart';
import 'package:be_casual_new2/presentation/base_screen/home.top.section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseScreen extends StatefulWidget {
 const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final baseController = Get.put(BaseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size(Get.width, 70), child:   HomeTopSection()),
      body: Obx(() => baseController.screens[baseController.selected.value]),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
