import 'package:get/get.dart';
import 'package:notes_app_new/screens/view_note_view/note_view.variable.dart';

class NoteIndividualViewController extends GetxController
    with NoteIndividualViewVariables {
  @override
  void onClose() {}

  /// The `init` function in Dart initializes variables with values from a data object if it is not null.
  init() async {
    var data = await Get.arguments;
    if (data != null) {
      noteTitle.value = data["title"];
      noteDescription.value = data["description"];
      noteValue = data;
    }
  }
}
