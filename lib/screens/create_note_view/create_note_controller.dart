import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:notes_app_new/components/common_functions.dart';
import 'package:notes_app_new/constants/app_path.dart';
import 'package:notes_app_new/constants/app_strings.dart';
import 'package:notes_app_new/screens/create_note_view/create_note_variable.dart';

class CreateNoteController extends GetxController with CreateVariables {
  @override
  void onClose() {}

  @override
  void dispose() {
    noteTitleController.dispose();
    noteDescriptionController.dispose();
    super.dispose();
  }

  /// The `init` function checks for network connectivity, retrieves data from the arguments, and sets
  /// the values of note title and description if they are not empty.
  init() async {
    var isNetwork = await CommonWidgetFuncions.checkNetworkConnectivity();
    isNetworkAvailable.value = isNetwork;
    var data = await Get.arguments;
    if (data != null) {
      note.value = data;
    }
    if (note.isNotEmpty) {
      noteTitleController.text = note.value["title"];
      noteDescriptionController.text = note.value["description"];
    }
  }

  /// The function `updateNote` updates a note with a given title and description, displaying an alert if
  /// there is no network connection, showing a loader while the update is being processed, and showing a
  /// success or error message based on the response from the server.
  ///
  /// Args:
  ///   title: The title parameter is the new title for the note. It is used to update the title of the
  /// note in the database.
  ///   desc: The "desc" parameter is the updated description of the note. It is used to update the
  /// description of a note in the "updateNote" function.
  updateNote(title, desc) async {
    var isNetwork = await CommonWidgetFuncions.checkNetworkConnectivity();
    isNetworkAvailable.value = isNetwork;
    if (isNetworkAvailable.value == false) {
      CommonWidgetFuncions.showAlertSnackbar(AppStrings.networkUnAvailable);
    } else {
      CommonWidgetFuncions.showOverlayLoader();
      http.Response response =
          await noteServices.updateNote(note.value["id"], title, desc);
      if (response != null && response.statusCode == 200 ||
          response.statusCode == 201) {
        Get.back();
        noteTitleController.clear();
        noteDescriptionController.clear();
        Get.offNamed(AppPaths.home);
      } else {
        Get.back();
        CommonWidgetFuncions.showAlertSnackbar(AppStrings.someThingWentWrong);
      }
    }
  }

  /// The function saves a new note by checking if the network is available, showing a snackbar if it's
  /// not, and then making an HTTP request to create the note, handling success and error cases
  /// accordingly.
  ///
  /// Args:
  ///   context: The context parameter is typically used in Flutter to access the current state of the
  /// app, such as the current theme, localization, or navigation. It is usually passed down from the
  /// parent widget to its child widgets. In this case, it is used to show an overlay loader and to
  /// navigate to different screens
  ///   title: The title of the note that needs to be saved.
  ///   desc: The "desc" parameter is the description or content of the note that you want to save.
  saveNewNote(context, title, desc) async {
    var isNetwork = await CommonWidgetFuncions.checkNetworkConnectivity();
    isNetworkAvailable.value = isNetwork;
    if (isNetworkAvailable.value == false) {
      CommonWidgetFuncions.showAlertSnackbar(AppStrings.networkUnAvailable);
    } else {
      CommonWidgetFuncions.showOverlayLoader();
      http.Response response =
          await noteServices.createNote(context, title, desc);
      if (response != null && response.statusCode == 200 ||
          response.statusCode == 201) {
        Get.back();
        noteTitleController.clear();
        noteDescriptionController.clear();
        Get.offNamed(AppPaths.home);
      } else {
        Get.back();
        CommonWidgetFuncions.showAlertSnackbar(AppStrings.someThingWentWrong);
      }
    }
  }
}
