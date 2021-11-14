import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  static SQLiteHelper instance = new SQLiteHelper();
  static Database? _database;

  Future<Database> getDatabase() async {
    if(_database == null)
      _database = await _initDB('testing.db');

    return _database!;
  }

  Future<Database> _initDB(String databaseName) async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, databaseName);

    return await openDatabase(path, version:1, onCreate:_createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
     create table CloseContactList (
      id integer primary key not null,
      CloseContactIdentifier varchar(255), 
      DateOfContact varchar(255),
      DistanceOfContactMetres varchar(255),
      MediumOfDetection varchar(255),
      EstimatedDurationOfContact varchar(255)
     )
    ''');
  }

  Future close() async {
    Database db = await getDatabase();
    db.close();
  }
}