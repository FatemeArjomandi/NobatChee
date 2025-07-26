import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../models/appointment_model.dart';
import 'appointment_local_datasource.dart';

class AppointmentLocalDataSourceImpl implements AppointmentLocalDataSource {
  static const String _tableName = 'Appointments';
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'nobatchi.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            business_id INTEGER NOT NULL,
            client_name TEXT NOT NULL,
            date TEXT NOT NULL,
            time TEXT NOT NULL,
            FOREIGN KEY (business_id) REFERENCES Businesses (id)
          )
        ''');
      },
    );
  }

  @override
  Future<List<AppointmentModel>> getAppointments(int businessId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'business_id = ?',
      whereArgs: [businessId],
    );
    return maps.map((map) => AppointmentModel.fromMap(map)).toList();
  }

  @override
  Future<void> addAppointment(AppointmentModel appointment) async {
    final db = await database;
    await db.insert(_tableName, appointment.toMap());
  }

  @override
  Future<void> updateAppointment(AppointmentModel appointment) async {
    final db = await database;
    await db.update(
      _tableName,
      appointment.toMap(),
      where: 'id = ?',
      whereArgs: [appointment.id],
    );
  }

  @override
  Future<void> deleteAppointment(int id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
