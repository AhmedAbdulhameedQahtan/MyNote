import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class SqlDb{

  static Database? _myProjectData;

  //دالة فحص تهيئة قاعدة البيانات اذا كانت موجود او لا
  Future<Database?> get myProjectData async{
    if(_myProjectData==null){
      _myProjectData=await initialDataBase();
      return _myProjectData;
    }else{
      return _myProjectData;
    }
  }

  //انشاء قاعدة البيانات في حال كانت غير منشئة من قبل
  initialDataBase() async{
    String dataBasePath = await getDatabasesPath();//المسار الافتراضي في الهاتف
    String dataBase = join(dataBasePath,'mydatabase.db');//تدمج امس القاعدة مع المسار path/name
    Database myDb =await openDatabase(dataBase,onCreate: _onCreate,version: 1);
    return myDb;
  }

  //انشاء الجداول والأعمدة
  _onCreate(Database db,int version) async{
    await db.execute('''
    CREATE TABLE "mynotes" (
    'id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'note' TEXT NOT NULL,
    'title' TEXT 
    )
    ''');
    print("DATABASE IS CREATED ====================================");
  }

  //
  // _onUpgrade(Database db, int oldVersion, int newVersion) async{
  //   await
  //   print("DATABASE IS Upgraded ====================================");
  // }

  //قرائة البيانات من القاعدة
  readData(String sql)async{
    print("==================the command you sen is=============$sql");
    Database? mydb = await myProjectData;
    List<Map?>  response = await mydb!.rawQuery(sql);
    print("DATA IS READED ====================================$response");
    return response;
  }

//الكتابة الى القاعدة
  insertData(String sql)async{
    Database? mydb = await myProjectData;
    int response = await mydb!.rawInsert(sql);
    print("DATA IS INSERTED ====================================");
    return response;
  }

  //التعديل على البيانات المخزنه في القاعدة
  updateData(String sql)async{
    Database? mydb = await myProjectData;
    int response = await mydb!.rawUpdate(sql);
    print("DATA IS UPDATE ====================================");
    return response;
  }

//حذف بيانات من القاعدة
  deletData(String sql)async{
    Database? mydb = await myProjectData;
    int response = await mydb!.rawDelete(sql);
    print("DATA IS DELETED ====================================");
    return response;
  }


}