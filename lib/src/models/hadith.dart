class Hadith {
  final int id;
  final int bookId;
  final String bookName;
  final int chapterId;
  final int sectionId;
  final String hadithKey;
  final int? hadithId;
  final String? narrator;
  final String bn;
  final String ar;
  final String arDiacless;
  final String note;
  final int gradeId;
  final String grade;
  final String gradeColor;

  Hadith({
    required this.id,
    required this.bookId,
    required this.bookName,
    required this.chapterId,
    required this.sectionId,
    required this.hadithKey,
    required this.hadithId,
    required this.narrator,
    required this.bn,
    required this.ar,
    required this.arDiacless,
    required this.note,
    required this.gradeId,
    required this.grade,
    required this.gradeColor,
  });

  factory Hadith.fromMap(Map<String, dynamic> map) {
    return Hadith(
      id: map['id'],
      bookId: map['book_id'],
      bookName: map['book_name'],
      chapterId: map['chapter_id'],
      sectionId: map['section_id'],
      hadithKey: map['hadith_key'],
      hadithId: map['hadith_id'],
      narrator: map['narrator'],
      bn: map['bn'],
      ar: map['ar'],
      arDiacless: map['ar_diacless'],
      note: map['note'],
      gradeId: map['grade_id'],
      grade: map['grade'],
      gradeColor: map['grade_color'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'book_id': bookId,
      'book_name': bookName,
      'chapter_id': chapterId,
      'section_id': sectionId,
      'hadith_key': hadithKey,
      'hadith_id': hadithId,
      'narrator': narrator,
      'bn': bn,
      'ar': ar,
      'ar_diacless': arDiacless,
      'note': note,
      'grade_id': gradeId,
      'grade': grade,
      'grade_color': gradeColor,
    };
  }
}
