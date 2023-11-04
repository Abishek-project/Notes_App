import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:notes_app_new/services/note_services.dart';

mixin CreateVariables {
  TextEditingController noteTitleController = TextEditingController();
  TextEditingController noteDescriptionController = TextEditingController();
  NoteServices noteServices = NoteServices();
  RxMap note = {}.obs;
  RxBool isNetworkAvailable = false.obs;
}
