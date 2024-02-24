import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'settings_service.dart';

class SettingsController extends GetxController {
  SettingsController(this._settingsService);

  final SettingsService _settingsService;
  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;

  ThemeMode get themeMode => _themeMode.value;

  Future<void> loadSettings() async {
    _themeMode.value = await _settingsService.themeMode();
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;
    if (newThemeMode == _themeMode.value) return;

    _themeMode.value = newThemeMode;
    await _settingsService.updateThemeMode(newThemeMode);
  }
}
