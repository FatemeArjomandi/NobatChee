import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/appointment_model.dart';

class AppointmentLocalDataSource {
  static final AppointmentLocalDataSource instance = AppointmentLocalDataSource._internal();
  static Database? _db;

  AppointmentLocalDataSource._internal();

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
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Appointments (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            business_id INTEGER,
            client_name TEXT,
            date TEXT,
            time TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertAppointment(AppointmentModel model) async {
    final db = await database;
    await db.insert('Appointments', model.toMap());
  }

  Future<List<AppointmentModel>> getAppointmentsForBusiness(int businessId) async {
    final db = await database;
    final result = await db.query(
      'Appointments',
      where: 'business_id = ?',
      whereArgs: [businessId],
    );
    return result.map((e) => AppointmentModel.fromMap(e)).toList();
  }
}