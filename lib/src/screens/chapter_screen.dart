import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hadith/src/controllers/hadith_controller.dart';
import 'package:flutter_hadith/src/models/book.dart';
import 'package:flutter_hadith/src/models/chapter.dart';
import 'package:flutter_hadith/src/models/hadith.dart';
import 'package:flutter_hadith/src/models/section.dart';
import 'package:flutter_hadith/src/utils/helpers.dart';
import 'package:flutter_hadith/src/widgets/my_indicator.dart';
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
  bool _loading = false;
  final hadithController = Get.find<HadithController>();
  List<Section> sectionList = [];
  @override
  initState() {
    super.initState();
    initSectionList();
  }

  initSectionList() async {
    setState(() {
      _loading = true;
    });
    sectionList = await hadithController.getSections(bookId: widget.chapter.bookId, chapterId: widget.chapter.chapterId);
    if (mounted) {
      setState(() {
        _loading = false;
      });
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.book.title),
            const SizedBox(height: 2),
            Text(
              widget.chapter.title,
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
      body: _loading
          ? const MyIndicator()
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: sectionList.length,
                itemBuilder: (context, index) {
                  Section section = sectionList[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 16, top: index == 0 ? 16 : 0),
                    child: SectionWidget(book: widget.book, section: section, index: index),
                  );
                },
              ),
            ),
    );
  }
}

class SectionWidget extends StatelessWidget {
  const SectionWidget({
    super.key,
    required this.book,
    required this.section,
    required this.index,
  });
  final Book book;
  final Section section;
  final int index;

  @override
  Widget build(BuildContext context) {
    Color sectionTitleColor = Theme.of(context).brightness == Brightness.light ? const Color.fromARGB(255, 33, 33, 33) : const Color.fromARGB(255, 214, 214, 214);
    return Column(
      children: [
        // section
        Card(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // section title
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: '${section.number} ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      TextSpan(
                        text: section.number == section.title ? '' : section.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: sectionTitleColor,
                        ),
                      ),
                    ],
                  ),
                ),
                // section preface
                if (section.preface != '') const Divider(color: Colors.grey),
                if (section.preface != '')
                  Text(
                    section.preface,
                    style: TextStyle(
                      fontSize: 14,
                      color: sectionTitleColor,
                    ),
                  ),
              ],
            ),
          ),
        ),
        // hadiths under this section
        ...section.hadiths.map((hadith) {
          return Container(
            margin: const EdgeInsets.only(top: 16),
            child: HadithWidget(book: book, hadith: hadith),
          );
        }).toList(),
      ],
    );
  }
}

class HadithWidget extends StatelessWidget {
  const HadithWidget({
    super.key,
    required this.book,
    required this.hadith,
  });
  final Book book;
  final Hadith hadith;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // hadith header
            Row(
              children: [
                // hadith book code
                Stack(
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
                      toBengaliNumber(book.abvrCode),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                // hadith number
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'হাদিস: ${toBengaliNumber(hadith.hadithId.toString())}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // hadith status
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    // color: Theme.of(context).primaryColor,
                    color: Color(int.parse('FF${hadith.gradeColor.substring(1)}', radix: 16)),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    hadith.grade,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    log('hadith option pressed');
                  },
                  child: const Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // hadith contents
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hadith.ar,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '${hadith.narrator} থেকে বর্ণিত: ',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hadith.bn,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
