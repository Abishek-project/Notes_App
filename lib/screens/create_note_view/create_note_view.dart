import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app_new/components/menu_button.dart';
import 'package:notes_app_new/constants/app_assets.dart';
import 'package:notes_app_new/constants/app_colors.dart';
import 'package:notes_app_new/constants/app_strings.dart';
import 'package:notes_app_new/screens/create_note_view/create_note_controller.dart';

class CreateNoteView extends GetView<CreateNoteController> {
  CreateNoteView({
    super.key,
  }) {
    controller.init();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: appBar(context),
        body: body(),
      ),
    );
  }

  appBar(context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    if (controller.noteTitleController.text == "" &&
                        controller.noteDescriptionController.text == "") {
                      Get.back();
                    } else {
                      showAlertDialog(true, context);
                    }
                  },
                  child: const MenuButton(icon: AppAssets.backIcon)),
              Row(
                children: [
                  const MenuButton(icon: AppAssets.eyeIcon),
                  const SizedBox(
                    width: 21,
                  ),
                  InkWell(
                    onTap: () async {
                      if (controller.noteTitleController.text.trim() != "" &&
                          controller.noteDescriptionController.text.trim() !=
                              "") {
                        showAlertDialog(false, context);
                      }
                    },
                    child: const MenuButton(icon: AppAssets.saveIcon),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView(
        children: [
          const SizedBox(
            height: 40,
          ),
          TextFormField(
            autofocus: true,
            controller: controller.noteTitleController,
            cursorColor: AppColors.darkGrey,
            style: GoogleFonts.nunito(
                color: AppColors.darkGrey,
                fontSize: 35,
                fontWeight: FontWeight.w400),
            maxLines: null,
            decoration: InputDecoration(
                hintStyle: GoogleFonts.nunito(
                    color: AppColors.lightGrey,
                    fontSize: 48,
                    fontWeight: FontWeight.w400),
                hintText: AppStrings.title,
                border: InputBorder.none),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: controller.noteDescriptionController,
            cursorColor: AppColors.darkGrey,
            style: GoogleFonts.nunito(
                color: AppColors.darkGrey,
                fontSize: 23,
                fontWeight: FontWeight.w400),
            maxLines: null,
            textInputAction: TextInputAction.newline,
            decoration: InputDecoration(
                hintText: AppStrings.typeSomething,
                hintStyle: GoogleFonts.nunito(
                    color: AppColors.lightGrey,
                    fontSize: 23,
                    fontWeight: FontWeight.w400),
                border: InputBorder.none),
          )
        ],
      ),
    );
  }

  showAlertDialog(bool isNoteDisCard, context) {
    return showDialog(
      barrierColor: Colors.white60,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.darkGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          icon: SvgPicture.asset(
            AppAssets.infoDark,
            color: AppColors.appWhite,
          ),
          content: Text(
            isNoteDisCard
                ? AppStrings.deleteDescription
                : AppStrings.saveChanges,
            style: GoogleFonts.nunito(
                color: AppColors.appWhite,
                fontSize: 23,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    controller.noteDescriptionController.text = "";
                    controller.noteTitleController.text = "";
                    Get.close(2);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.appRed),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Text(
                      AppStrings.discard,
                      style: GoogleFonts.nunito(
                          color: AppColors.appWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                TextButton(
                  onPressed: () async {
                    if (isNoteDisCard == true) {
                      Get.back();
                    } else {
                      controller.note.isNotEmpty
                          ? controller.updateNote(
                              controller.noteTitleController.text,
                              controller.noteDescriptionController.text)
                          : controller.saveNewNote(
                              context,
                              controller.noteTitleController.text,
                              controller.noteDescriptionController.text);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColors.green),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Text(
                      isNoteDisCard ? AppStrings.keep : AppStrings.save,
                      style: GoogleFonts.nunito(
                          color: AppColors.appWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
