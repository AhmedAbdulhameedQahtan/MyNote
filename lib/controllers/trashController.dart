import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/SqlDb.dart';
import '../model/sqlCommand.dart';


class TrashController extends GetxController{
  ConstantSql sqlQuery = ConstantSql();
  SqlDb sqlDataBase = SqlDb();
  bool isloading = true;
  List storeDeletedData = [];

  @override
  void onInit() {
    super.onInit();
    readDeletedData();
    print("========================Trash Controller onInit called====================");
  }


  Future readDeletedData() async {
    List<Map<String, dynamic>> dataResponse = await sqlDataBase.readData(sqlQuery.selectAllTrash());
    storeDeletedData.addAll(dataResponse);
    print("read data from trash is done");
    update();
  }

  Future searchDeletedNote(str) async {
    List<Map<String, dynamic>> searchResponse = await sqlDataBase.readData(sqlQuery.searchTrashData(str));
    storeDeletedData.addAll(searchResponse);
    isloading = false;
    update();
  }

  @override
  void refreshDeletedData() {
    print("setstate of refresh trash is called");
    storeDeletedData = [];
    readDeletedData();
    update();
  }

  void searchDeletedRefresh(str) {
    print("setstate of refresh is called");
    storeDeletedData = [];
    searchDeletedNote(str);
    update();
  }



}