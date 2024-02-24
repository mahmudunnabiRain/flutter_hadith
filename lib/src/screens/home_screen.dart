import 'package:flutter/material.dart';
import 'package:flutter_hadith/src/controllers/hadith_controller.dart';
import 'package:flutter_hadith/src/models/book.dart';
import 'package:flutter_hadith/src/settings/settings_screen.dart';
import 'package:flutter_hadith/src/utils/helpers.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final hadithController = Get.find<HadithController>();
  List<Book> bookList = [];
  @override
  initState() {
    super.initState();
    initBookList();
  }

  initBookList() async {
    bookList = await hadithController.getAllBooks();
    setState(() {});
  }

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // implement non-scrollable listview of books
            Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: bookList.length,
                itemBuilder: (context, index) {
                  Book book = bookList[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      leading: Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(
                            height: 48,
                            width: 48,
                            'assets/svgs/hexagon-svgrepo-com.svg',
                            semanticsLabel: 'Home Icon',
                            colorFilter: ColorFilter.mode(
                              Color(int.parse('FF${book.colorCode.substring(1)}', radix: 16)),
                              BlendMode.srcIn,
                            ),
                          ),
                          Text(
                            book.abvrCode,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                        book.title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        book.titleAr,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        'মোট হাদিস\n${toBengaliNumber(book.hadithCount.toString())}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
