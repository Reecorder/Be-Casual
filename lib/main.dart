import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:be_casual_new2/model/fonts.model.dart';
import 'package:be_casual_new2/presentation/splash/splash.dart';
import 'package:be_casual_new2/routes/app_routes.dart';
import 'package:be_casual_new2/bindings/initial_bindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (!didPop) {
          // Optional: Handle custom back logic here
        }
      },
      child: GetMaterialApp(
        title: 'Be Casual',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: Fonts.regular, useMaterial3: true),
        initialBinding: InitialBindings(),
        initialRoute: '/',
        getPages: AppRoutes.routes,
        home: const SplashScreen(),
      ),
    );
  }
}
