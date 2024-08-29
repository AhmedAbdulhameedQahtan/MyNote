import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../DL/SqlDb.dart';
import '../DL/sqlCommand.dart';

class DatabaseController extends GetxController{

  ConstantSql sqlQuery = ConstantSql();
  SqlDb sqlDataBase = SqlDb();
  bool isloading = true;
  List storeData = [];


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    readData();
    print("dataread===================================================================0000000");
}



Future readData() async {
  List<Map<String, dynamic>> dataResponse = await sqlDataBase.readData(sqlQuery.selectAllData());
  storeData.addAll(dataResponse);
  print("controller read data**************** ${storeData}");
  isloading = false;
  // if (mounted) {
  //   setState(() {
  //     print("setstate of read data is called");
  //   });
  // }
  update();
}

Future searchNote(str) async {
  List<Map<String, dynamic>> searchResponse = await sqlDataBase.readData(
      sqlQuery.searchData(str));
  // setState(() {
  storeData.addAll(searchResponse);
  isloading = false;
  print("controller search list**************** ${storeData}");
  // });
  // if (mounted) {
  //   setState(() {
  //     print("setstate of search data is called");
  //   });
  // }
  update();
}

void searchRefresh(str) {
  // setState(() {
  print("controller of search refresh is called");
  storeData = [];
  searchNote(str);
  // });
  update();
}

void refreshData() {
  // setState(() {
  print("controller of refresh is called");
  storeData = [];
  readData();
  // });
  update();
}

Future deleteNoteAndMoveToTrash(sqlDataBase,int noteId) async {
    // Step 1: Select the note to be deleted
    print("deleteNoteAndMoveToTrash is called===========");
    dynamic selectToDelet = await sqlDataBase.readData(sqlQuery.selectToDelet(noteId));

    // Check if the note exists
    if (selectToDelet.isNotEmpty) {
      Map<String, dynamic> note = selectToDelet.first;
      print("SelectToDelet.first==============$selectToDelet.first");
      String noteText = note['note'];
      String titleText = note['title'];

      // Step 2: Insert the selected note into the trash table using the moveToTrash function
      dynamic insertToTrash = await sqlDataBase.insertData(sqlQuery.moveToTrash(noteId, noteText, titleText));

      // Step 3: Delete the note from the mynotes table
      dynamic deletFromNote = await sqlDataBase.deletData(
          sqlQuery.deletData(noteId));
      print("deletFromNote==========$deletFromNote");

    } else {
      print('Note with id $noteId does not exist.');
    }
  }



}