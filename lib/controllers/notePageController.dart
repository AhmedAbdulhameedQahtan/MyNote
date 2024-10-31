import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/SqlDb.dart';
import '../model/sqlCommand.dart';


class NotePageController extends GetxController{

  ConstantSql sqlQuery = ConstantSql();
  SqlDb sqlDataBase = SqlDb();
  bool isloading = true;
  RxList<Map<String, dynamic>> storeData = <Map<String, dynamic>>[].obs;

  RxInt favNote = 0.obs;

  @override
  void onInit() {
    super.onInit();
    readData();
    print("========================database controller onInit ====================================");
}

Future readData() async {
  List<Map<String, dynamic>> dataResponse = await sqlDataBase.readData(sqlQuery.selectAllData());
  storeData.assignAll(dataResponse);
  print(" **************** database controller read data ****************");
  isloading = false;
}

Future searchNote(str) async {
  List<Map<String, dynamic>> searchResponse = await sqlDataBase.readData(sqlQuery.searchData(str));
  storeData.assignAll(searchResponse);
  isloading = false;
  print("controller search list**************** ");
}

void searchRefresh(str) {
  print("controller of search refresh is called");
   storeData.clear();
  searchNote(str);
}

void refreshData() {
  print("controller of refresh is called");
  storeData.clear();
  readData();
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

void favNoteState(int noteId)async{

   dynamic selectToFavorite = await sqlDataBase.readData(sqlQuery.selectOneFavorites(noteId));
   selectToFavorite[0]['is_favorite'] == 0 ? favNote.value = 1 : favNote.value = 0;
    dynamic res = await sqlDataBase.updateData(sqlQuery.updateFavorite(noteId,favNote.value));
    refreshData();
   print('favnote===========$favNote');
     // update();
}

}