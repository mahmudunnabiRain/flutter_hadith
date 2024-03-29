import 'package:flutter/material.dart';
import 'package:flutter_hadith/src/models/book.dart';
import 'package:flutter_hadith/src/models/chapter.dart';
import 'package:flutter_hadith/src/screens/book_screen.dart';
import 'package:flutter_hadith/src/screens/chapter_screen.dart';
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
            titleTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            backgroundColor: Colors.green,
          ),
          scaffoldBackgroundColor: const Color.fromARGB(255, 243, 246, 245),
          listTileTheme: ListTileThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            tileColor: Colors.white,
          ),
          cardTheme: CardTheme(
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            margin: EdgeInsets.zero,
            elevation: 0,
          ),
        ),
        darkTheme: ThemeData.dark().copyWith(
          primaryColor: Colors.green,
          colorScheme: const ColorScheme.dark().copyWith(
            primary: Colors.green.shade600,
          ),
          appBarTheme: const AppBarTheme(
            surfaceTintColor: Colors.green,
            titleTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            backgroundColor: Colors.green,
          ),
          listTileTheme: ListTileThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            tileColor: Colors.black,
          ),
          cardTheme: CardTheme(
            surfaceTintColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            margin: EdgeInsets.zero,
            elevation: 0,
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
                case BookScreen.routeName:
                  final book = routeSettings.arguments as Book;
                  return BookScreen(book: book);
                case ChapterScreen.routeName:
                  final args = routeSettings.arguments as Map<String, dynamic>;
                  final chapter = args['chapter'] as Chapter;
                  final book = args['book'] as Book;
                  return ChapterScreen(book: book, chapter: chapter);
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
