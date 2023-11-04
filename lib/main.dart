import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:notes_app_new/app_routing.dart';
import 'package:notes_app_new/constants/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    systemNavigationBarColor: AppColors.primaryColor,
    statusBarColor: AppColors.primaryColor,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.routes,
      initialBinding: AppRoutes.initialBinding,
      initialRoute: AppRoutes.initialPage,
      title: 'Notes App',
      theme: ThemeData(primaryColor: AppColors.primaryColor),
    );
  }
}
