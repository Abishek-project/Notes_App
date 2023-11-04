import 'package:get/get.dart';
import 'package:notes_app_new/screens/create_note_view/create_note_controller.dart';
import 'package:notes_app_new/screens/home/home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CreateNoteController>(() => CreateNoteController());
  }
}
