import 'package:flutter/material.dart';
import 'package:flutter_hadith/src/controllers/hadith_controller.dart';
import 'package:flutter_hadith/src/screens/home_screen.dart';
import 'package:flutter_hadith/src/widgets/my_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static const routeName = '/';
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final hadithController = Get.find<HadithController>();

  @override
  void initState() {
    super.initState();
    // initialize the hadith dabase
    hadithController.initDB();
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: hadithController.loadingDatabase
            ? const MyIndicator()
            : IndexedStack(
                index: _currentIndex,
                children: [
                  const HomeScreen(),
                  Container(),
                  Container(),
                ],
              ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svgs/home-1-svgrepo-com.svg',
                semanticsLabel: 'Home Icon',
                colorFilter: ColorFilter.mode(_currentIndex == 0 ? Theme.of(context).primaryColor : Colors.grey, BlendMode.srcIn),
              ),
              label: 'হোম',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svgs/home-1-svgrepo-com.svg',
                semanticsLabel: 'Home Icon',
                colorFilter: ColorFilter.mode(_currentIndex == 1 ? Theme.of(context).primaryColor : Colors.grey, BlendMode.srcIn),
              ),
              label: 'হোম',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svgs/home-1-svgrepo-com.svg',
                semanticsLabel: 'Home Icon',
                colorFilter: ColorFilter.mode(_currentIndex == 2 ? Theme.of(context).primaryColor : Colors.grey, BlendMode.srcIn),
              ),
              label: 'হোম',
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
