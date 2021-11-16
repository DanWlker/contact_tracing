import 'package:contact_tracing/entity/IndvCloseContact.dart';
import 'package:contact_tracing/utilities/UserInfo.dart';
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

  Future<bool> checkDatabaseForUser(String name) async {
    Database db = await getDatabase();
    int? count = Sqflite
        .firstIntValue(await db.rawQuery('''
                  select count(*) from CloseContactList where closecontactidentifier = "${name}"
                  '''));

    return count! > 0;
  }

  Future<void> insertIntoDatabase(String name, String medium) async {
    Database db = await getDatabase();
    var now = new DateTime.now().toString();
    await db.rawQuery('''
                  insert into CloseContactList(closecontactidentifier, dateofcontact, mediumofdetection, estimateddurationofcontact) 
                  values (
                  "${name}",
                  "${now}",
                  "${medium}",
                  "-"
                  )
                  ''');
  }

  Future<void> updateRow(String name, String medium, String duration) async {
    Database db = await getDatabase();
    await db.rawUpdate(
        'UPDATE CloseContactList SET mediumofdetection = ?, estimateddurationofcontact = ? WHERE closecontactidentifier = ?',
        [medium, duration, name]);
  }

  Future<bool> soundDiscovered(String name) async {
    Database db = await getDatabase();
    List<Map> list = await db.rawQuery('''
      select closecontactidentifier, mediumofdetection from CloseContactList where closecontactidentifier = "${name}"
    ''');

    print("Look for me:" + list.toString());
    print(list[0]['MediumOfDetection'] == "Bluetooth, Sound");

    return list[0]['MediumOfDetection'] == "Bluetooth, Sound";
  }

  Future<List<Map>> getRecordsFrom(int length) async {
    Database db = await getDatabase();
    List<Map> list = await db.rawQuery('''
      select * from CloseContactList order by id desc limit ${length}, ${length+10} 
    ''');

    return list;
  }
  
  Future<void> deleteRecord(String name) async {
    Database db = await getDatabase();
    await db.rawDelete('DELETE FROM CloseContactList WHERE closecontactidentifier = ?', [name]);
  }

  Future<List<Map>> returnAllRecordsAfter(DateTime date) async {
    Database db = await getDatabase();
    List<Map> list = await db.rawQuery('''
    select * from CloseContactList
    ''');

    List<Map> tempList = [];
    for (var items in list) {
      if(DateTime.parse(items['DateOfContact']).isAfter(date)) {
        tempList.add(items);
      }
    }
    return tempList;
  }
}