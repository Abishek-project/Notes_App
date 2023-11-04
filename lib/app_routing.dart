import 'package:get/get.dart';
import 'package:notes_app_new/constants/app_path.dart';
import 'package:notes_app_new/screens/create_note_view/create_note_binding.dart';
import 'package:notes_app_new/screens/create_note_view/create_note_view.dart';
import 'package:notes_app_new/screens/home/home_binding.dart';
import 'package:notes_app_new/screens/home/home_view.dart';
import 'package:notes_app_new/screens/search_view/search.binding.dart';
import 'package:notes_app_new/screens/search_view/search.view.dart';
import 'package:notes_app_new/screens/view_note_view/note_view.binding.dart';
import 'package:notes_app_new/screens/view_note_view/note_view.view.dart';

class AppRoutes {
  static const initialPage = AppPaths.home;
  static final initialBinding = HomeBindings();
  static final routes = [
    GetPage(
        name: AppPaths.home, page: (() => HomeView()), binding: HomeBindings()),
    GetPage(
        name: AppPaths.addNote,
        page: (() => CreateNoteView()),
        binding: CreateNoteBinding()),
    GetPage(
        name: AppPaths.viewNote,
        page: (() => NoteIndividualView()),
        binding: NoteIndividualViewBinding()),
    GetPage(
        name: AppPaths.search,
        page: (() => SearchView()),
        binding: SearchBinding()),
  ];
}
