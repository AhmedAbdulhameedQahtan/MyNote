// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// class SqlDb{
//
//   static Database? _myProjectData;
//
//   //دالة فحص تهيئة قاعدة البيانات اذا كانت موجود او لا
//   Future<Database?> get myProjectData async{
//     if(_myProjectData==null){
//       _myProjectData=await initialDataBase();
//       return _myProjectData;
//     }else{
//       return _myProjectData;
//     }
//   }
//
//   //انشاء قاعدة البيانات في حال كانت غير منشئة من قبل
//   initialDataBase() async{
//     String dataBasePath = await getDatabasesPath();//المسار الافتراضي في الهاتف
//     String dataBase = join(dataBasePath,'mydatabase.db');//تدمج امس القاعدة مع المسار path/name
//     Database myDb =await openDatabase(dataBase,onCreate: _onCreate,version: 1);
//     return myDb;
//   }
//
//   //انشاء الجداول والأعمدة
//   // _onCreate(Database db,int version) async{
//   //   await db.execute('''
//   //   CREATE TABLE "mynotes" (
//   //   'id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
//   //   'note' TEXT NOT NULL,
//   //   'title' TEXT
//   //   )
//   //   ''');
//   //   print("DATABASE IS CREATED ====================================");
//   // }
//   //
//   _onCreate(Database db, int version) async {
//     await db.execute('''
//     CREATE TABLE "mynotes" (
//       'id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
//       'note' TEXT NOT NULL,
//       'title' TEXT,
//       'is_favorite' INTEGER DEFAULT 0
//     )
//   ''');
//
//     await db.execute('''
//     CREATE TABLE "trash" (
//       'id' INTEGER NOT NULL PRIMARY KEY,
//       'note' TEXT NOT NULL,
//       'title' TEXT,
//       'deleted_at' TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
//       FOREIGN KEY('id') REFERENCES 'mynotes'('id') ON DELETE CASCADE
//     )
//   ''');
//
//     //
//     //   await db.execute('''
//     //   CREATE TABLE "favorite" (
//     //     'id' INTEGER NOT NULL PRIMARY KEY,
//     //     FOREIGN KEY('id') REFERENCES 'mynotes'('id') ON DELETE CASCADE
//     //   )
//     // ''');
//     //
//     //   print("DATABASE IS CREATED ====================================");
//     // }
//
//   }
//
//
//
//
//
//   //========================
//   // _onUpgrade(Database db, int oldVersion, int newVersion) async{
//   //   await
//   //   print("DATABASE IS Upgraded ====================================");
//   // }
//
//   //قرائة البيانات من القاعدة
//   readData(String sql)async{
//     print("==================the command you sen is=============$sql");
//     Database? mydb = await myProjectData;
//     List<Map?>  response = await mydb!.rawQuery(sql);
//     print("DATA IS READED ====================================");
//     return response;
//   }
//
//   selectToDelete(String sql)async{
//     Database? mydb = await myProjectData;
//     List<Map> noteToDelete = await mydb!.rawQuery(sql);
//     return noteToDelete;
//   }
//
//
// //الكتابة الى القاعدة
//   insertData(String sql)async{
//     Database? mydb = await myProjectData;
//     int response = await mydb!.rawInsert(sql);
//     print("DATA IS INSERTED ====================================");
//     return response;
//   }
//
//   //التعديل على البيانات المخزنه في القاعدة
//   updateData(String sql)async{
//     Database? mydb = await myProjectData;
//     int response = await mydb!.rawUpdate(sql);
//     print("DATA IS UPDATE ====================================");
//     return response;
//   }
//
// //حذف بيانات من القاعدة
//   deletData(String sql)async{
//     Database? mydb = await myProjectData;
//     int response = await mydb!.rawDelete(sql);
//     print("DATA IS DELETED ====================================");
//     return response;
//   }
//
//
// }


import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  // النسخة الوحيدة من الكائن.
  static final SqlDb _instance = SqlDb._internal();

  // دالة private constructor لمنع إنشاء كائنات جديدة.
  SqlDb._internal();

  // إتاحة الوصول إلى النسخة الوحيدة.
  factory SqlDb() {
    return _instance;
  }

  static Database? _myProjectData;

  // فحص وتوفير قاعدة البيانات.
  Future<Database?> get myProjectData async {
    _myProjectData ??= await initialDataBase();
    return _myProjectData;
  }

  // إنشاء قاعدة البيانات في حال عدم وجودها.
  Future<Database> initialDataBase() async {
    String dataBasePath = await getDatabasesPath(); // المسار الافتراضي.
    String dataBase = join(dataBasePath, 'mydatabase.db'); // دمج المسار مع اسم القاعدة.
    Database myDb = await openDatabase(dataBase, onCreate: _onCreate, version: 1);
    return myDb;
  }

  // إنشاء الجداول والأعمدة.
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE "mynotes" (
        'id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        'note' TEXT NOT NULL,
        'title' TEXT,
        'is_favorite' INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE "trash" (
        'id' INTEGER NOT NULL PRIMARY KEY,
        'note' TEXT NOT NULL,
        'title' TEXT,
        'deleted_at' TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY('id') REFERENCES 'mynotes'('id') ON DELETE CASCADE
      )
    ''');

    print("DATABASE IS CREATED ====================================");
  }

  // قراءة البيانات من القاعدة.
  Future<List<Map<String, dynamic>>> readData(String sql) async {
    Database? mydb = await myProjectData;
    List<Map<String, dynamic>> response = await mydb!.rawQuery(sql);
    print("DATA IS READED ====================================");
    return response;
  }

  // تحديد بيانات للحذف.
  Future<List<Map<String, dynamic>>> selectToDelete(String sql) async {
    Database? mydb = await myProjectData;
    List<Map<String, dynamic>> noteToDelete = await mydb!.rawQuery(sql);
    return noteToDelete;
  }

  // إدخال بيانات إلى القاعدة.
  Future<int> insertData(String sql) async {
    Database? mydb = await myProjectData;
    int response = await mydb!.rawInsert(sql);
    print("DATA IS INSERTED ====================================");
    return response;
  }

  // تعديل البيانات.
  Future<int> updateData(String sql) async {
    Database? mydb = await myProjectData;
    int response = await mydb!.rawUpdate(sql);
    print("DATA IS UPDATED ====================================");
    return response;
  }

  // حذف البيانات من القاعدة.
  Future<int> deletData(String sql) async {
    Database? mydb = await myProjectData;
    int response = await mydb!.rawDelete(sql);
    print("DATA IS DELETED ====================================");
    return response;
  }
}
