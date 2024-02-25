import 'package:flutter_hadith/src/models/hadith.dart';

class Section {
  final int id;
  final int bookId;
  final String bookName;
  final int chapterId;
  final int sectionId;
  final String title;
  final String preface;
  final String number;
  final int sortOrder;
  final List<Hadith> hadiths;

  Section({
    required this.id,
    required this.bookId,
    required this.bookName,
    required this.chapterId,
    required this.sectionId,
    required this.title,
    required this.preface,
    required this.number,
    required this.sortOrder,
    required this.hadiths,
  });

  factory Section.fromMap(Map<String, dynamic> map, List<Hadith> hadiths) {
    return Section(
      id: map['id'],
      bookId: map['book_id'],
      bookName: map['book_name'],
      chapterId: map['chapter_id'],
      sectionId: map['section_id'],
      title: map['title'],
      preface: map['preface'],
      number: map['number'],
      sortOrder: map['sort_order'],
      hadiths: hadiths,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'book_id': bookId,
      'book_name': bookName,
      'chapter_id': chapterId,
      'section_id': sectionId,
      'title': title,
      'preface': preface,
      'number': number,
      'sort_order': sortOrder,
      'hadiths': hadiths.map((hadith) => hadith.toMap()).toList(),
    };
  }
}
