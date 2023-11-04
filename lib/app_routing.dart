import 'package:get/get.dart';
import 'package:notes_app_new/constants/app_path.dart';
import 'package:notes_app_new/screens/home/home_binding.dart';
import 'package:notes_app_new/screens/home/home_view.dart';

class AppRoutes {
  static const initialPage = AppPaths.home;
  static final initialBinding = HomeBindings();
  static final routes = [
    GetPage(
        name: AppPaths.home, page: (() => HomeView()), binding: HomeBindings()),
    // GetPage(
    //     name: AppPaths.auth, page: (() => AuthView()), binding: AuthBinding()),
  ];
}
