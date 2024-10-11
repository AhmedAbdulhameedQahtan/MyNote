import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../DL/SqlDb.dart';
import '../DL/sqlCommand.dart';

class TrashController extends GetxController{
  ConstantSql sqlQuery = ConstantSql();
  SqlDb sqlDataBase = SqlDb();
  bool isloading = true;
  List storedeletedData = [];

  @override
  void onInit() {
    super.onInit();
    readDeletedData();
    print("========================Trash Controller onInit called====================");
  }


  Future readDeletedData() async {
    List<Map<String, dynamic>> dataResponse = await sqlDataBase.readData(sqlQuery.selectAllTrash());
    storedeletedData.addAll(dataResponse);
    print("storeData= $storedeletedData");
    isloading = false;
    // if (mounted) {
    //   setState(() {
    //     print("setstate of read data from trash is called");
    //   });
    // }
    update();
  }

  Future searchDeletedNote(str) async {
    List<Map<String, dynamic>> searchResponse = await sqlDataBase.readData(
        sqlQuery.searchTrashData(str));
    // setState(() {
    storedeletedData.addAll(searchResponse);
    isloading = false;
    update();
    // });
    // if (mounted) {
    //   setState(() {
    //     print("setstate of search data is called");
    //   });
    // }
  }

  @override
  void refreshDeletedData() {
    // setState(() {
    print("setstate of refresh trash is called");
    storedeletedData = [];
    readDeletedData();
    update();
    // });
  }

  void searchDeletedRefresh(str) {
    // setState(() {
    print("setstate of refresh is called");
    storedeletedData = [];
    searchDeletedNote(str);
    update();
    // });
  }



}