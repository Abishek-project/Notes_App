import 'dart:convert';
import 'package:notes_app_new/components/common_functions.dart';
import 'package:notes_app_new/constants/api_url.dart';
import 'package:http/http.dart' as http;

class NoteServices {
  /// The `createNote` function sends a POST request to a specified API endpoint with a note title and
  /// description, and returns the response.
  ///
  /// Args:
  ///   context: The `context` parameter is typically the current context of the application. It is used
  /// to access resources and services provided by the framework, such as accessing the theme, navigation,
  /// or displaying dialogs.
  ///   noteTitle: The title of the note that you want to create.
  ///   noteDescription: The `noteDescription` parameter is a string that represents the description or
  /// content of the note. It provides additional information or details about the note.
  ///
  /// Returns:
  ///   a `http.Response` object.
  createNote(context, noteTitle, noteDescription) async {
    Map<String, String>? header = {};
    header["Content-Type"] = "application/json";

    try {
      var body = {"title": noteTitle, "description": noteDescription};
      http.Response response = await http.post(
          Uri.parse("${ApiUrls.baseUrl}create-note"),
          body: jsonEncode(body),
          headers: header);
      return response;
    } catch (e) {
      CommonWidgetFuncions.showAlertSnackbar(e.toString());
    }
  }

  /// The function `getAllNotes` makes an HTTP GET request to a specified URL and returns the response.
  ///
  /// Returns:
  ///   a `http.Response` object.

  getAllNotes() async {
    Map<String, String>? header = {};
    header["Content-Type"] = "application/json";
    try {
      http.Response response = await http
          .get(Uri.parse("${ApiUrls.baseUrl}get-all-notes"), headers: header);
      return response;
    } catch (e) {
      CommonWidgetFuncions.showAlertSnackbar(e.toString());
    }
  }

  /// The function `updateNote` updates a note by sending a PUT request to a specified API endpoint with
  /// the provided note ID, title, and description.
  ///
  /// Args:
  ///   id: The unique identifier of the note that needs to be updated.
  ///   noteTitle: The `noteTitle` parameter is the new title for the note that you want to update.
  ///   noteDescription: The `noteDescription` parameter is a string that represents the updated
  /// description of a note.
  ///
  /// Returns:
  ///   a `http.Response` object.
  updateNote(id, noteTitle, noteDescription) async {
    Map<String, String>? header = {};
    header["Content-Type"] = "application/json";

    try {
      var body = {"title": noteTitle, "description": noteDescription};

      http.Response response = await http.put(
          Uri.parse("${ApiUrls.baseUrl}update-note/$id"),
          body: jsonEncode(body),
          headers: header);
      return response;
    } catch (e) {
      CommonWidgetFuncions.showAlertSnackbar(e.toString());
    }
  }

  /// The `deleteNote` function sends a DELETE request to a specified API endpoint with the provided note
  /// ID and returns the response.
  ///
  /// Args:
  ///   id: The `id` parameter is the unique identifier of the note that you want to delete. It is used to
  /// construct the URL for the delete request.
  ///
  /// Returns:
  ///   a `http.Response` object.
  deleteNote(id) async {
    Map<String, String>? header = {};
    header["Content-Type"] = "application/json";
    try {
      http.Response response = await http.delete(
          Uri.parse("${ApiUrls.baseUrl}delete-note/$id"),
          headers: header);
      return response;
    } catch (e) {
      CommonWidgetFuncions.showAlertSnackbar(e.toString());
    }
  }
}
