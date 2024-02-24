import 'package:flutter/material.dart';
import 'package:flutter_hadith/src/screens/main_screen.dart';
import 'package:get/get.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_screen.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController = Get.find<SettingsController>();

    return Obx(
      () => MaterialApp(
        debugShowCheckedModeBanner: false,
        restorationScopeId: 'app',
        title: 'Al Hadith',
        theme: ThemeData(
          colorScheme: const ColorScheme.light().copyWith(
            primary: Colors.green.shade600,
          ),
          appBarTheme: const AppBarTheme(
            surfaceTintColor: Colors.green,
          ),
        ),
        darkTheme: ThemeData.dark().copyWith(
          primaryColor: Colors.green,
          colorScheme: const ColorScheme.dark().copyWith(
            primary: Colors.green.shade600,
          ),
          appBarTheme: const AppBarTheme(
            surfaceTintColor: Colors.green,
          ),
        ),
        themeMode: settingsController.themeMode,

        // Define a function to handle named routes in order to support
        // Flutter web url navigation and deep linking.
        onGenerateRoute: (RouteSettings routeSettings) {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) {
              switch (routeSettings.name) {
                case MainScreen.routeName:
                  return const MainScreen();
                case SettingsScreen.routeName:
                  return const SettingsScreen();
                default:
                  return const MainScreen();
              }
            },
          );
        },
      ),
    );
  }
}
