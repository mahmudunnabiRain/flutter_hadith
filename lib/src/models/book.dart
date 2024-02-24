class Book {
  final int id;
  final String title;
  final String titleAr;
  final int numberOfHadis;
  final String abvrCode;
  final String bookName;
  final String bookDescr;
  final String colorCode;
  int hadithCount;

  Book({
    required this.id,
    required this.title,
    required this.titleAr,
    required this.numberOfHadis,
    required this.abvrCode,
    required this.bookName,
    required this.bookDescr,
    required this.colorCode,
    required this.hadithCount,
  });

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      titleAr: map['title_ar'],
      numberOfHadis: map['number_of_hadis'],
      abvrCode: map['abvr_code'],
      bookName: map['book_name'],
      bookDescr: map['book_descr'],
      colorCode: map['color_code'],
      hadithCount: map['hadith_count'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'title_ar': titleAr,
      'number_of_hadis': numberOfHadis,
      'abvr_code': abvrCode,
      'book_name': bookName,
      'book_descr': bookDescr,
      'color_code': colorCode,
      'hadith_count': hadithCount,
    };
  }
}
