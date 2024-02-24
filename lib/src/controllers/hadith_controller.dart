import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
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

  Future<List<Map<String, dynamic>>> getAllBooks() async {
    var db = await database;
    var res = await db.rawQuery('''
    SELECT books.book_name, COUNT(hadith.id) as hadith_count
    FROM books
    LEFT JOIN hadith ON books.id = hadith.book_id
    GROUP BY books.book_name
  ''');
    return res;
  }

  Future<int> getNumberOfHadiths() async {
    var db = await database;
    var res = await db.rawQuery('SELECT COUNT(*) as Total FROM hadith');
    int count = res.first['Total'] as int;
    return count;
  }

  // Add other methods for insert, update, delete etc.
}
