import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_hadith/src/controllers/hadith_controller.dart';
import 'package:flutter_hadith/src/settings/settings_screen.dart';
import 'package:flutter_hadith/src/widgets/my_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final hadithController = Get.find<HadithController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('আল হাদিস'),
        // backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/svgs/settings-minimalistic-svgrepo-com.svg',
              semanticsLabel: 'Home Icon',
              colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white, BlendMode.srcIn),
            ),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsScreen.routeName);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            MyButton(
                text: 'check db',
                onPress: () async {
                  var result = await hadithController.getAllBooks();
                  log(result.toString());
                })
          ],
        ),
      ),
    );
  }
}
