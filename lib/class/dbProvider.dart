import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'model.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    print('init db');
    String path = join(await getDatabasesPath(), "person.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      print('on create');

      try {
        await db.execute('''
        CREATE TABLE IF NOT EXISTS person (
          id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          telephoneNumber TEXT,
          address TEXT
        );
      ''');

        print('done init');
      } catch (err) {
        print('error');
        print(err);
      }
    });
  }

  newPerson(Person p) async {
    final db = await database;
    var r = await db.insert("person", p.toJson());
    return r;
  }

  deletePerson(Person p) async {
    final db = await database;
    var r =  await db.rawDelete('DELETE FROM person WHERE id = ?', [p.id]);
    return r;
  }

  updatePerson(Person p) async {
    final db = await database;
    await db.update('person', p.toJsonWithId(), where:  'id = ?', whereArgs: [p.id]);
  }

  Future<List<Person>> getAllPerson() async {
    final db = await database;
    List<Person> list = [];
    var r = await db.rawQuery("SELECT * FROM Person;");
    list = r.isNotEmpty
        ? r.toList().map((json) => Person.fromJson(json)).toList()
        : [];
    return list;
  }
}
