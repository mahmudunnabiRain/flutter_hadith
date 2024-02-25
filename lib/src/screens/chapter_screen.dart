import 'package:flutter/material.dart';
import 'package:flutter_hadith/src/controllers/hadith_controller.dart';
import 'package:flutter_hadith/src/models/book.dart';
import 'package:flutter_hadith/src/models/chapter.dart';
import 'package:flutter_hadith/src/models/section.dart';
import 'package:flutter_hadith/src/utils/helpers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChapterScreen extends StatefulWidget {
  const ChapterScreen({super.key, required this.book, required this.chapter});
  final Book book;
  final Chapter chapter;

  static const routeName = '/chapter-screen';

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  final hadithController = Get.find<HadithController>();
  List<Section> sectionList = [];
  @override
  initState() {
    super.initState();
    initSectionList();
  }

  initSectionList() async {
    sectionList = await hadithController.getSections(bookId: widget.chapter.bookId, chapterId: widget.chapter.chapterId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chapter.title),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: sectionList.length,
          itemBuilder: (context, index) {
            Section chapter = sectionList[index];
            return Container(
              margin: EdgeInsets.only(bottom: 16, top: index == 0 ? 16 : 0),
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
                        Theme.of(context).primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    Text(
                      toBengaliNumber((index + 1).toString()),
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
                    fontWeight: FontWeight.bold,
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
