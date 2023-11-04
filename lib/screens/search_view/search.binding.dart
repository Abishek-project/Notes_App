import 'package:get/get.dart';

import 'package:notes_app_new/screens/search_view/search.controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchViewController());
  }
}
