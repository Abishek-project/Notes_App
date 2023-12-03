import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app_new/components/menu_button.dart';
import 'package:notes_app_new/constants/app_assets.dart';
import 'package:notes_app_new/constants/app_colors.dart';
import 'package:notes_app_new/constants/app_path.dart';
import 'package:notes_app_new/constants/app_strings.dart';
import 'package:notes_app_new/screens/create_note_view/create_note_controller.dart';
import 'package:notes_app_new/screens/home/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key}) {
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          backgroundColor: AppColors.primaryColor,
          appBar: appBar(context),
          body: controller.notesList.isEmpty ? emptyNotesView() : bodyView(),
          floatingActionButton: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  offset: Offset(-5, 0),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: FloatingActionButton(
              onPressed: () {
                Get.put(CreateNoteController);
                Get.find<CreateNoteController>().note.value.clear();
                Get.toNamed(AppPaths.addNote);
              },
              backgroundColor: AppColors.primaryColor,
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.addIcon,
                  color: AppColors.black,
                  height: 20,
                  width: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// The code defines two functions in Dart, one for creating an app bar and another for displaying an
  /// empty notes view.
  ///
  /// Args:
  ///   context: The `context` parameter is the BuildContext object, which represents the location in the
  /// widget tree where the widget is being built. It is typically used to access the theme, media query,
  /// and other properties of the current build context.
  ///
  /// Returns:
  ///   The `appBar` method returns a `PreferredSize` widget with a preferred size of 70.0. It contains a
  /// `Padding` widget with horizontal padding of 24. Inside the `Padding` widget, there is a `Row` widget
  /// with `MainAxisAlignment.spaceBetween` alignment. The `Row` widget contains a `Text` widget with the
  /// text "AppStrings.notes" styled using the
  appBar(context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              AppStrings.notes,
              style: GoogleFonts.nunito(
                  color: AppColors.darkGrey,
                  fontSize: 43,
                  fontWeight: FontWeight.w600),
            ),
            Row(
              children: [
                InkWell(
                    onTap: () {
                      Get.toNamed(AppPaths.search);
                    },
                    child: const MenuButton(icon: AppAssets.searchIcon)),
                const SizedBox(
                  width: 21,
                ),
                InkWell(
                    onTap: () {
                      showNameDialog(context);
                    },
                    child: const MenuButton(icon: AppAssets.infoIcon)),
              ],
            )
          ],
        ),
      ),
    );
  }

  emptyNotesView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage(AppAssets.emptyNote),
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            AppStrings.createYourNote,
            style: GoogleFonts.nunito(
                color: AppColors.appWhite,
                fontSize: 20,
                fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }

  /// The `bodyView` function returns a `ListView.builder` widget that displays a list of note cards based
  /// on the `notesList` data in the `controller`.
  ///
  /// Returns:
  ///   The `bodyView()` method is returning a `Padding` widget that contains a `ListView.builder` widget.
  /// The `ListView.builder` widget is used to dynamically build a list of items based on the `itemCount`
  /// property, which is set to the length of the `controller.notesList` list. Each item in the list is
  /// rendered using the `noteCardWidget` method, passing in the
  bodyView() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: RefreshIndicator(
        onRefresh: () async {
          await controller.getAllNotes();
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView.builder(
          itemCount: controller.notesList.length,
          itemBuilder: ((context, index) {
            return noteCardWidget(controller.notesList[index]);
          }),
        ),
      ),
    );
  }

  /// The `noteCardWidget` function returns a widget that displays a note card with different behaviors
  /// based on user interactions.
  ///
  /// Args:
  ///   data: The data parameter is the data object that contains the information for the note card. It
  /// could include properties such as the note's title, id, and other relevant details.
  ///   isSearch (bool): A boolean value that indicates whether the note card widget is being used in a
  /// search context or not. If set to true, it means the widget is being used in a search context, and if
  /// set to false (default), it means the widget is being used in a regular context. Defaults to false
  ///
  /// Returns:
  ///   a Padding widget with an InkWell as its child. The InkWell has an onLongPress and onTap callback.
  /// Inside the InkWell, there is a Container widget with a BoxDecoration and a Center widget as its
  /// child. The Center widget contains either a SvgPicture.asset or a Text widget, depending on the
  /// condition.
  noteCardWidget(data, {bool isSearch = false}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 24),
      child: InkWell(
        onLongPress: () {
          if (isSearch == false) {
            controller.isNoteSelected.value = data;
            controller.notesList.refresh();
          }
        },
        onTap: () async {
          if (controller.isNoteSelected.value["_id"] == data["_id"]) {
            await controller.deleteNote(data);
          } else {
            Get.toNamed(AppPaths.viewNote, arguments: data);
          }
        },
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(
                    20)), // Adjust the border radius for rounded corners
          ),
          elevation: 2,
          child: Container(
            decoration: BoxDecoration(
                color: controller.isNoteSelected.value.isNotEmpty &&
                        controller.isNoteSelected["_id"] == data["_id"]
                    ? AppColors.appRed
                    : const Color(0xFF3498DB),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: controller.isNoteSelected.value.isNotEmpty &&
                        controller.isNoteSelected["_id"] == data["_id"]
                    ? SvgPicture.asset(AppAssets.delete)
                    : Text(
                        data["title"] ?? "",
                        style: GoogleFonts.nunito(
                            color: AppColors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// The `showNameDialog` function displays an AlertDialog with a title and content, showing the name
  /// "Abishek".
  ///
  /// Args:
  ///   context: The context parameter is the current build context of the widget tree. It is used to show
  /// the dialog on top of the current screen.
  ///
  /// Returns:
  ///   The `showNameDialog` function is returning a `showDialog` widget.

  showNameDialog(context) {
    return showDialog(
      barrierColor: AppColors.lightGrey.withOpacity(0.1),
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20.0), // Adjust the radius as needed
          ),
          title: Text(
            AppStrings.madeBy,
            style: GoogleFonts.nunito(
              color: AppColors.black,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          content: Text(
            "Abishek",
            style: GoogleFonts.nunito(
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }
}
