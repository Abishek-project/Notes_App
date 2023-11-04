import 'package:get/get.dart';

import 'package:notes_app_new/screens/view_note_view/note_view.controller.dart';

class NoteIndividualViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NoteIndividualViewController());
  }
}
