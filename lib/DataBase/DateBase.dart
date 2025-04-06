import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Model.dart';

class DataBaseCar {
  static final DataBaseCar instance = DataBaseCar._init();

  static Database? _database;

  DataBaseCar._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('DataBaseCar.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 8,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE DataBaseCar(id TEXT,Name TEXT,Phone TEXT,Oprator TEXT,IdDev TEXT,PassUser TEXT,StateInternet TEXT,StateDev TEXT,SpeadDifference TEXT,SpeadLimit TEXT,StartEnable TEXT,LocationSendAfterFabric TEXT,LocationSendAfterSms TEXT,DoorpType TEXT,ImpactIntensity TEXT,ShockAlarm TEXT,ShockNumber TEXT,Vehicle TEXT,ChildrenLock TEXT,SencorsTime TEXT,StartPositionSend TEXT,ModelCar TEXT,UrgentOpreation TEXT,TypeAlarmSpead TEXT,StateSendLocationAfterSms TEXT,simcard TEXT)",
        );
      },
      onUpgrade: (db, oldVersion, newVersion) =>
          _onUpgrade(db, oldVersion, newVersion),
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE DataBaseCar ADD COLUMN StateDev TEXT');
    }
    if (oldVersion < 3) {
      await db.execute(
          'ALTER TABLE DataBaseCar ADD COLUMN SpeadDifference TEXT,SpeadLimit TEXT,StartEnable TEXT,LocationSendAfterFabric TEXT,LocationSendAfterSms TEXT,DoorpType TEXT,ImpactIntensity TEXT,ShockAlarm TEXT,ShockNumber TEXT,Vehicle TEXT,ChildrenLock TEXT,SencorsTime TEXT,StartPositionSend TEXT');
    }
    if (oldVersion < 4) {
      await db.execute('ALTER TABLE DataBaseCar ADD COLUMN ModelCar TEXT');
    }
    if (oldVersion < 5) {
      await db
          .execute('ALTER TABLE DataBaseCar ADD COLUMN UrgentOpreation TEXT');
    }
    var columns = await db.rawQuery("PRAGMA table_info(DataBaseCar)");
    var columnExists =
        columns.any((column) => column['name'] == 'TypeAlarmSpead');
    if (!columnExists) {
      if (oldVersion < 6) {
        await db
            .execute('ALTER TABLE DataBaseCar ADD COLUMN TypeAlarmSpead TEXT');
      }
    }
    var columnExists3 =
        columns.any((column) => column['name'] == 'StateSendLocationAfterSms');
    if (!columnExists3) {
      if (oldVersion < 7) {
        await db.execute(
            'ALTER TABLE DataBaseCar ADD COLUMN StateSendLocationAfterSms TEXT');
      }
    }
    var columnExists2 = columns.any((column) => column['name'] == 'simcard');
    if (!columnExists2) {
      if (oldVersion < 8) {
        await db.execute('ALTER TABLE DataBaseCar ADD COLUMN simcard TEXT');
      }
    }
  }

  Future<void> addColumnIfNotExists(Database db, String tableName,
      String columnName, String columnType) async {
    var columns = await db.rawQuery("PRAGMA table_info($tableName)");
    var columnExists = columns.any((column) => column['name'] == columnName);
    if (!columnExists) {}
  }

  Future<void> AddDev(Car dev) async {
    final db = await instance.database;

    await db.insert(
      'DataBaseCar',
      dev.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Car>> GetDevs() async {
    final Database db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query('DataBaseCar');

    return List.generate(maps.length, (i) {
      return Car(
          id: maps[i]['id'],
          Name: maps[i]['Name'],
          Phone: maps[i]['Phone'],
          Oprator: maps[i]['Oprator'],
          IdDev: maps[i]['IdDev'],
          PassUser: maps[i]['PassUser'],
          StateInternet: maps[i]['StateInternet'],
          StateDev: maps[i]['StateDev'] ?? 'قفل',
          ModelCar: maps[i]['ModelCar'] ?? 'جی کلاس',
          UrgentOpreation: maps[i]['UrgentOpreation'] ?? 'خاموش',
          ShockNumber: maps[i]['ShockNumber'] ?? '90',
          SpeadLimit: maps[i]['SpeadLimit'] ?? '50',
          SpeadDifference: maps[i]['SpeadDifference'] ?? '180',
          TypeAlarmSpead: maps[i]['TypeAlarmSpead'] ?? 'تماس و پیامک',
          StateSendLocationAfterSms:
              maps[i]['StateSendLocationAfterSms'] ?? 'true',
          simcard: maps[i]['simcard'] ?? '1');
    });
  }

  Future<void> UpdateDev(Car dev) async {
    final db = await database;

    await db.update(
      'DataBaseCar',
      dev.toMap(),
      where: "id = ?",
      whereArgs: [dev.id],
    );
  }

  Future<void> DeleteDev(String id) async {
    final db = await database;

    await db.delete(
      'DataBaseCar',
      where: "id = ?",
      whereArgs: [id],
    );

/*     Get.find<controllertext>(tag: 'first').notes.clear();
    Get.find<controllertext>(tag: 'first').notes = await instance.notes(); */
  }
}
