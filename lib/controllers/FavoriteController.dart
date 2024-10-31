import 'package:get/get.dart';

import '../model/SqlDb.dart';
import '../model/sqlCommand.dart';


class FavoriteController extends GetxController{
  ConstantSql sqlQuery = ConstantSql();
  SqlDb sqlDataBase = SqlDb();
  List storeData=[];

  @override
  void onInit() {
    super.onInit();
    readData();
    print("dataread========================Favorite controller===========================================");
  }



  Future readData() async {
    List<Map<String, dynamic>> dataResponse = await sqlDataBase.readData(sqlQuery.selectAllFavorites());
    storeData.addAll(dataResponse);
    print("Favorite controller read data****************$storeData");
    update();
  }

  Future searchFavoriteNote(str) async {
    List<Map<String, dynamic>> searchResponse = await sqlDataBase.readData(sqlQuery.searchFavoriteData(str));
    storeData.addAll(searchResponse);
    print("controller search list***ggggg*************$searchResponse ");
    update();
  }

  void searchFavoriteRefresh(str) {
    print("controller of search refresh is called");
    storeData = [];
    searchFavoriteNote(str);
    update();
  }

}