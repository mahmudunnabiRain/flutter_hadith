import 'package:flutter/material.dart';
import 'package:flutter_hadith/src/models/book.dart';
import 'package:flutter_hadith/src/screens/chapters_screen.dart';
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
          scaffoldBackgroundColor: const Color.fromARGB(255, 243, 246, 245),
          listTileTheme: ListTileThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            tileColor: Colors.white,
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
          listTileTheme: ListTileThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            tileColor: Colors.black,
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
                case ChapterScreen.routeName:
                  // Ensure the arguments are of type Book
                  final book = routeSettings.arguments as Book;
                  return ChapterScreen(book: book);
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
