import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:notes_app_new/constants/app_colors.dart';

class CommonWidgetFuncions {
  /// The `showAlertSnackbar` function displays a snackbar with a given message and optional background
  /// color.
  ///
  /// Args:
  ///   message (String): The message parameter is a required parameter that specifies the text message to
  /// be displayed in the snackbar.
  ///   color: The `color` parameter is an optional parameter that allows you to specify the background
  /// color of the snackbar. If no color is provided, it will default to `const Color(0xFF303030)`, which
  /// is a dark gray color.
  static showAlertSnackbar(String message, {color}) {
    Get.showSnackbar(
      GetSnackBar(
        message: message,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// The function `showOverlayLoader` displays a dialog with a spinning loading indicator in the center
  /// of the screen.
  static Future<void> showOverlayLoader() async {
    showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: Center(
            child: SpinKitWave(
          size: 30,
          color: AppColors.blue,
        )),
      ),
    );
  }

  /// The function checks if there is network connectivity and returns a boolean value indicating the
  /// result.
  ///
  /// Returns:
  ///   a boolean value. It returns true if there is network connectivity and false if there is no network
  /// connectivity.

  static Future<bool> checkNetworkConnectivity() async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      return true;
    } else {
      return false;
    }
  }
}
