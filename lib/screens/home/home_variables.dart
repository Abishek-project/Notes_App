import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app_new/constants/app_colors.dart';
import 'package:notes_app_new/services/note_services.dart';

mixin HomeVariables {
  RxList notesList = [].obs;
  RxBool isNetworkAvailable = false.obs;
  RxMap isNoteSelected = {}.obs;
  final List<Color> availableColors = [
    AppColors.pink,
    AppColors.darkPink,
    AppColors.lightGreen,
    AppColors.yellow,
    AppColors.purple,
  ];
  NoteServices noteServices = NoteServices();
}
