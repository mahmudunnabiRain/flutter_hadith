import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_hadith/src/models/book.dart';
import 'package:flutter_hadith/src/models/chapter.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HadithController extends GetxController {
  static Database? _database;

  final RxBool _loadingDatabase = RxBool(false);

  bool get loadingDatabase => _loadingDatabase.value;

  Future<Database> get database async {
    if (_database != null) return _database!;
    await initDB();
    return _database!;
  }

  Future initDB() async {
    log("Database loading...");
    _loadingDatabase.value = true;
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'hadith_bn_test.db');

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      log("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join('assets', 'hadith_bn_test.db'));

      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      log("Opening existing database");
    }
    _database = await openDatabase(path);
    _loadingDatabase.value = false;
    log("Database loaded successfully.");
  }

  Future<List<Map<String, dynamic>>> query(String table) async {
    var db = await database;
    return await db.query(table);
  }

  Future<List<Book>> getAllBooks() async {
    var db = await database;
    var res = await db.rawQuery('''
    SELECT books.id, books.title, books.title_ar, books.number_of_hadis, books.abvr_code, books.book_name, books.book_descr, books.color_code, COUNT(hadith.id) as hadith_count
    FROM books
    LEFT JOIN hadith ON books.id = hadith.book_id
    GROUP BY books.id
  ''');

    List<Book> books = res.map((map) => Book.fromMap(map)).toList();
    return books;
  }

  Future<List<Chapter>> getAllChaptersByBookId({required int bookId}) async {
    var db = await database;
    var res = await db.rawQuery('''
    SELECT chapter.id, chapter.chapter_id, chapter.book_id, chapter.title, chapter.number, chapter.hadis_range, chapter.book_name
    FROM chapter
    WHERE chapter.book_id = ?
  ''', [bookId]);

    List<Chapter> chapters = res.map((map) => Chapter.fromMap(map)).toList();
    return chapters;
  }

  Future<int> getNumberOfHadiths() async {
    var db = await database;
    var res = await db.rawQuery('SELECT COUNT(*) as Total FROM hadith');
    int count = res.first['Total'] as int;
    return count;
  }

  // Add other methods for insert, update, delete etc.
}
