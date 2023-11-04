import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:notes_app_new/services/note_services.dart';

mixin SearchVariables {
  TextEditingController searchController = TextEditingController();
  RxString searchText = "".obs;
  RxList notesList = [].obs;
  RxList searchNoteList = [].obs;
  RxBool isSearchNote = false.obs;
  RxBool isNetworkAvailable = false.obs;
  NoteServices noteServices = NoteServices();
}
