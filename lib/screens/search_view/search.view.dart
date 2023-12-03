import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app_new/constants/app_assets.dart';
import 'package:notes_app_new/constants/app_colors.dart';
import 'package:notes_app_new/constants/app_strings.dart';
import 'package:notes_app_new/screens/home/home_view.dart';
import 'package:notes_app_new/screens/search_view/search.controller.dart';

class SearchView extends GetView<SearchViewController> {
  SearchView({super.key}) {
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Obx(() => body()),
    ));
  }

  /// The `body` function returns a `Column` widget with a search bar and a list of search results based
  /// on the state of the `controller`.
  ///
  /// Returns:
  ///   The `body()` method is returning a `Column` widget.

  body() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.darkGrey,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 12),
              child: Row(
                children: [
                  Expanded(
                    child: searchTextField(),
                  ),
                  if (controller.isSearchNote.value)
                    InkWell(
                        onTap: () {
                          controller.resetSearch();
                        },
                        child: SvgPicture.asset(AppAssets.closeIcon)),
                ],
              ),
            ),
          ),
        ),
        Obx(() => Expanded(
              child: !controller.isSearchNote.value &&
                      controller.searchNoteList.isEmpty
                  ? emptysearchView()
                  : controller.searchNoteList.isNotEmpty
                      ? searchNoteListView()
                      : Container(),
            ))
      ],
    );
  }

  /// The function returns a TextField widget with search functionality.
  ///
  /// Returns:
  ///   The code is returning a TextField widget.
  TextField searchTextField() {
    return TextField(
      onChanged: (value) {
        if (value.isNotEmpty) {
          controller.isSearchNote.value = true;
          controller.searchNote(value);
        } else {
          controller.searchNoteList.value = [];
          controller.isSearchNote.value = false;
        }
      },
      controller: controller.searchController,
      style: GoogleFonts.nunito(
        color: AppColors.lightGrey02,
        fontSize: 20,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        isDense: true,
        hintText: AppStrings.searchHintText,
        hintStyle: GoogleFonts.nunito(
          color: AppColors.appWhite,
          fontSize: 20,
          fontWeight: FontWeight.w300,
        ),
        border: InputBorder.none,
      ),
    );
  }

  /// The function returns a ListView widget that displays a list of note cards based on the
  /// searchNoteList data.
  ///
  /// Returns:
  ///   The `searchNoteListView()` method returns a `ListView.builder` widget.
  searchNoteListView() {
    return ListView.builder(
      itemCount: controller.searchNoteList.length,
      itemBuilder: ((context, index) {
        return HomeView()
            .noteCardWidget(controller.searchNoteList[index], isSearch: true);
      }),
    );
  }

  /// The `emptysearchView` function returns a widget that displays an image and a text when there are no
  /// search results.
  ///
  /// Returns:
  ///   a Padding widget that contains a Column widget. Inside the Column widget, there is an Image
  /// widget and a Text widget.
  emptysearchView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage(AppAssets.emptySearch),
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            AppStrings.searchEmptyText,
            style: GoogleFonts.nunito(
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
