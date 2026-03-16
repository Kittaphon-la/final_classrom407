import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {

  static Database? _db;

  Future<Database> get database async {

    if (_db != null) return _db!;

    _db = await initDB();

    return _db!;
  }

  Future<Database> initDB() async {

    String path = join(await getDatabasesPath(), "equipment.db");

    return await openDatabase(

      path,

      version: 1,

      onCreate: (db, version) async {

        await db.execute('''
        CREATE TABLE equipments(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          type TEXT,
          quantity INTEGER,
          unit TEXT,
          status TEXT,
          note TEXT,
          date TEXT
        )
        ''');

        // sample data

        List data = [

          ["Mac Mini","Computer",30,"เครื่อง","ปกติ"],
          ["Magic Keyboard","Keyboard",30,"ตัว","ปกติ"],
          ["Magic Mouse","Mouse",28,"ตัว","ปกติ"],
          ["HDMI Cable","Cable",10,"เส้น","ปกติ"],
          ["Adapter","Adapter",5,"ตัว","ปกติ"],
          ["Projector","Device",1,"เครื่อง","ใกล้หมด"],
          ["Marker","Stationery",3,"แท่ง","ใกล้หมด"],
          ["Eraser","Stationery",2,"ชิ้น","ใกล้หมด"],
          ["LAN Cable","Cable",15,"เส้น","ปกติ"],
          ["Extension Plug","Electric",4,"ตัว","ปกติ"]

        ];

        for (var item in data) {

          await db.insert('equipments',{

            'name':item[0],
            'type':item[1],
            'quantity':item[2],
            'unit':item[3],
            'status':item[4],
            'note':'',
            'date':'2026-01-01'

          });

        }

      },

    );
  }
}