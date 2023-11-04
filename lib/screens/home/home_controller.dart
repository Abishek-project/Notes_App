import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:notes_app_new/components/common_functions.dart';
import 'package:notes_app_new/constants/app_strings.dart';
import 'package:notes_app_new/screens/home/home_variables.dart';

class HomeController extends GetxController with HomeVariables {
  /// The `init` function checks for network connectivity, updates a variable with the result, and then
  /// calls another function to retrieve all notes.
  init() async {
    var isNetwork = await CommonWidgetFuncions.checkNetworkConnectivity();
    isNetworkAvailable.value = isNetwork;
    await getAllNotes();
  }

  /// The function `getAllNotes` retrieves all notes from a server and updates the `notesList` variable
  /// with the response data, while also handling network availability and displaying appropriate alerts.
  getAllNotes() async {
    if (isNetworkAvailable.value == false) {
      CommonWidgetFuncions.showAlertSnackbar(AppStrings.networkUnAvailable);
    } else {
      CommonWidgetFuncions.showOverlayLoader();
      http.Response response = await noteServices.getAllNotes();
      if (response != null && response.statusCode == 200 ||
          response.statusCode == 201) {
        final body = json.decode(response.body);
        notesList.value = body["data"];
        Get.back();
      } else {
        Get.back();
        CommonWidgetFuncions.showAlertSnackbar(AppStrings.someThingWentWrong);
      }
    }
  }

  /// The getRandomColor function returns a random color from a list of available colors.
  ///
  /// Returns:
  ///   The getRandomColor() function returns a random color from the availableColors array.
  Color getRandomColor() {
    final Random _random = Random();
    return availableColors[_random.nextInt(availableColors.length)];
  }

  /// The function `deleteNote` checks if the network is available, shows a snackbar alert if it's not,
  /// shows an overlay loader, sends a request to delete a note, removes the note from the list if the
  /// request is successful, and shows a snackbar alert if there's an error.
  ///
  /// Args:
  ///   note: The "note" parameter is an object that represents a note. It likely has properties such as
  /// "id", "title", "content", etc.
  deleteNote(note) async {
    if (isNetworkAvailable.value == false) {
      CommonWidgetFuncions.showAlertSnackbar(AppStrings.networkUnAvailable);
    } else {
      CommonWidgetFuncions.showOverlayLoader();
      http.Response response = await noteServices.deleteNote(note["id"]);
      if (response != null && response.statusCode == 200 ||
          response.statusCode == 201) {
        notesList.remove(note);
        notesList.refresh();
        Get.back();
      } else {
        Get.back();
        CommonWidgetFuncions.showAlertSnackbar(AppStrings.someThingWentWrong);
      }
    }
  }
}
