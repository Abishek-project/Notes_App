import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:notes_app_new/components/common_functions.dart';
import 'package:notes_app_new/constants/app_strings.dart';
import 'package:notes_app_new/screens/search_view/search.variable.dart';

class SearchViewController extends GetxController with SearchVariables {
  @override
  void onClose() {}
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  /// The `init` function initializes the app by checking network connectivity, resetting the search, and
  /// retrieving all notes.
  init() async {
    var isNetwork = await CommonWidgetFuncions.checkNetworkConnectivity();
    isNetworkAvailable.value = isNetwork;
    await resetSearch();
    await getAllNotes();
  }

  /// The function searches for notes in a list based on a given text query and updates the search
  /// results.
  ///
  /// Args:
  ///   text (String): The `text` parameter is a nullable String that represents the search query.
  ///
  /// Returns:
  ///   If the `text` parameter is null or empty, the function will return without performing any further
  /// operations.
  void searchNote(String? text) {
    if (text == null || text.isEmpty) {
      return;
    }

    final query = text.trim().toLowerCase();

    searchNoteList.value = notesList
        .where((note) => note["title"].trim().toLowerCase().contains(query))
        .toList();

    searchText.value = query;
    searchNoteList.refresh();
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

  /// The function "resetSearch" resets the search functionality by clearing the search text, search list,
  /// and setting the search note flag to false.
  resetSearch() {
    isSearchNote.value = false;
    searchController.text = "";
    searchText.value = "";
    searchNoteList.value = [];
  }
}
