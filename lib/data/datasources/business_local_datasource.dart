import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/business_model.dart';

class BusinessLocalDataSource {
  static final BusinessLocalDataSource instance = BusinessLocalDataSource._internal();
  static Database? _db;

  BusinessLocalDataSource._internal();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'nobatchi.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Businesses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phone TEXT,
        address TEXT,
        description TEXT
      )
    ''');
  }

  Future<void> insertBusiness(BusinessModel model) async {
    final db = await database;
    await db.insert('Businesses', model.toMap());
  }

  Future<List<BusinessModel>> getAllBusinesses() async {
    final db = await database;
    final result = await db.query('Businesses');
    return result.map((e) => BusinessModel.fromMap(e)).toList();
  }
}