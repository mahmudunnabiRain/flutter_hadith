import 'package:flutter/material.dart';
import 'package:flutter_hadith/src/widgets/select_widget.dart';
import 'package:get/get.dart';

import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController = Get.find<SettingsController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('সেটিংস'),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'থিম সেট করুন',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              SelectWidget(
                items: const [
                  {'id': ThemeMode.system as dynamic, 'name': 'সিস্টেম'},
                  {'id': ThemeMode.light as dynamic, 'name': 'আলোকিত'},
                  {'id': ThemeMode.dark as dynamic, 'name': 'অন্ধকার'},
                ],
                value: settingsController.themeMode,
                onChange: (value) {
                  settingsController.updateThemeMode(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
