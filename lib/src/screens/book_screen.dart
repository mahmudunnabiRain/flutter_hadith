import 'package:flutter/material.dart';
import 'package:flutter_hadith/src/controllers/hadith_controller.dart';
import 'package:flutter_hadith/src/models/book.dart';
import 'package:flutter_hadith/src/models/chapter.dart';
import 'package:flutter_hadith/src/screens/chapter_screen.dart';
import 'package:flutter_hadith/src/utils/helpers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key, required this.book});
  final Book book;

  static const routeName = '/book-screen';

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  final hadithController = Get.find<HadithController>();
  List<Chapter> chapterList = [];
  @override
  initState() {
    super.initState();
    initChapterList();
  }

  initChapterList() async {
    chapterList = await hadithController.getChapters(bookId: widget.book.id);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: SvgPicture.asset(
            height: 20,
            width: 20,
            'assets/svgs/left-arrow-backup-2-svgrepo-com.svg',
            semanticsLabel: 'Home Icon',
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
        titleSpacing: 0,
        title: Text(widget.book.title),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: chapterList.length,
          itemBuilder: (context, index) {
            Chapter chapter = chapterList[index];
            return Container(
              margin: EdgeInsets.only(bottom: 16, top: index == 0 ? 16 : 0),
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ChapterScreen.routeName,
                    arguments: {
                      'book': widget.book,
                      'chapter': chapter,
                    },
                  );
                },
                leading: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      height: 48,
                      width: 48,
                      'assets/svgs/hexagon-svgrepo-com.svg',
                      semanticsLabel: 'Home Icon',
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    Text(
                      toBengaliNumber(chapter.number.toString()),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                title: Text(
                  chapter.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  'হাদিসের রেঞ্জ: ${chapter.hadisRange}',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
