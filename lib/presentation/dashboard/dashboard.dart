import 'package:be_casual_new2/common/common.banner.dart';
import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/presentation/dashboard/brand.tile.dart';
import 'package:be_casual_new2/presentation/dashboard/category.tile.dart';
import 'package:be_casual_new2/presentation/dashboard/customized.tile.dart';
import 'package:be_casual_new2/presentation/dashboard/designer.tile.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DesignerTile(),

            /* spacer */
            spacer(height: 25),

            /* customized tile */
            CustomizedTile(),

            /* spacer */
            spacer(height: 25),

            /* second banner widget */
            CommonBanner(),

            /* spacer */
            spacer(height: 25),

            /* brand tile */
            BrandTile(),
            /* spacer */
            spacer(height: 25),

            /* category tile */
            // CategoryTile(),
            CustomizedTile(),
          ],
        ),
      ),
    );
  }
}
