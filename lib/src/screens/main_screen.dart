import 'package:flutter/material.dart';
import 'package:flutter_hadith/src/settings/settings_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static const routeName = '/';
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text('আল হাদিস'),
              // backgroundColor: Colors.green,
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    Navigator.restorablePushNamed(context, SettingsScreen.routeName);
                  },
                ),
              ],
            ),
          ),
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
    );
  }
}
