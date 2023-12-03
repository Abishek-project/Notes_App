import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app_new/components/menu_button.dart';
import 'package:notes_app_new/constants/app_assets.dart';
import 'package:notes_app_new/constants/app_colors.dart';
import 'package:notes_app_new/constants/app_path.dart';
import 'package:notes_app_new/screens/view_note_view/note_view.controller.dart';

class NoteIndividualView extends GetView<NoteIndividualViewController> {
  NoteIndividualView({super.key}) {
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: appBar(),
        body: body(),
      ),
    );
  }

  /// The `appBar` function returns a custom AppBar widget with a back button and an edit button.
  ///
  /// Returns:
  ///   The `appBar()` method is returning a `PreferredSize` widget.

  appBar() {
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
                  Get.back();
                },
                child: const MenuButton(
                  icon: AppAssets.backIcon,
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      Get.toNamed(AppPaths.addNote,
                          arguments: controller.noteValue);
                    },
                    child: const MenuButton(
                      icon: AppAssets.editIcon,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  /// The `body` function returns a widget that displays a column with a note title and description,
  /// wrapped in an `Obx` widget for reactive updates.
  ///
  /// Returns:
  ///   The `body()` method is returning a widget tree that consists of an `Obx` widget as the root,
  /// followed by a `Column` widget. The `Column` widget has a `SizedBox` widget as its first child,
  /// followed by an `Expanded` widget. The `Expanded` widget has a `Padding` widget as its child, which
  /// in turn has a `SingleChildScrollView

  body() {
    return Obx(() => Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      noteTitle(),
                      const SizedBox(
                        height: 37,
                      ),
                      noteDescription(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  /// The function returns a Text widget with the description value from a controller, styled with a
  /// specific font, color, size, and weight.
  ///
  /// Returns:
  ///   A Text widget is being returned.
  Text noteDescription() {
    return Text(
      controller.noteDescription.value,
      style: GoogleFonts.nunito(
          color: AppColors.darkGrey, fontSize: 23, fontWeight: FontWeight.w400),
    );
  }

  /// The function returns a Text widget with the title value from a controller, using a specific font
  /// style.
  ///
  /// Returns:
  ///   a Text widget with the title value from the controller. The text style is set to use the Nunito
  /// font with a white color, font size of 35, and a font weight of 400.

  Text noteTitle() {
    return Text(
      controller.noteTitle.value,
      style: GoogleFonts.nunito(
          color: AppColors.darkGrey, fontSize: 35, fontWeight: FontWeight.w400),
    );
  }
}
