import 'package:flutter/material.dart';
import 'package:flutter_hadith/src/controllers/hadith_controller.dart';
import 'package:get/get.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();
  Get.put(settingsController);

  final hadithController = HadithController();
  Get.put(hadithController);

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsScreen.
  runApp(const MyApp());
}
