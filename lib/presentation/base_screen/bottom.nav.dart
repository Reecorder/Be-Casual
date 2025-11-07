import 'package:be_casual_new2/controller/base.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final controller = Get.put(BaseController());

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Obx(
            () => BottomNavigationBar(
              onTap: (index) {
                controller.onchange(index: index);
              },
              currentIndex: controller.selected.value,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              // showSelectedLabels: true,
              unselectedItemColor: Colors.black.withOpacity(0.5),
              selectedItemColor: Colors.black,
              selectedIconTheme: const IconThemeData(
                color: Colors.black,
                size: 25,
              ),
              unselectedIconTheme: IconThemeData(
                color: Colors.black.withOpacity(0.5),
                size: 20,
              ),
              items: List.generate(
                controller.icons.length,
                (index) => item(icon: controller.icons[index], label: ""),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem item({
    required IconData icon,
    required String label,
  }) => BottomNavigationBarItem(
    icon: Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 2),
      child: Icon(icon),
    ),
    label: label,
  );
}
