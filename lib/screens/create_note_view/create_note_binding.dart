import 'package:get/get.dart';

import 'package:notes_app_new/screens/create_note_view/create_note_controller.dart';

class CreateNoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateNoteController());
  }
}
