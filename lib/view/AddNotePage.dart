import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mynote/controllers/notePageController.dart';

import '../resources/appColors.dart';


class AddNotePage extends StatefulWidget {
  String? noteDetails;
  String? titleDetails;
  int? idDetails;

  AddNotePage({super.key, this.noteDetails, this.titleDetails});

  AddNotePage.Details(this.idDetails, this.noteDetails, this.titleDetails);

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {

  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final int _maxlength = 30;

  @override
  void initState() {
    if (widget.noteDetails != null) {
      _noteController.text = widget.noteDetails!;
      _titleController.text = widget.titleDetails!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int? id = widget.idDetails;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:  SystemUiOverlayStyle(
            statusBarColor:AppColors.primaryColor,
            statusBarBrightness: Brightness.light),
        iconTheme: IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.primaryColor,
        actions: [
          GetBuilder<NotePageController>(
              builder: (controller)=>IconButton(
                  onPressed: () async {
                    if (_noteController.text == "") {
                      showDialog(
                          context: context,
                          builder: (BuildContext) {
                            return AlertDialog(
                              title:  Center(
                                child: Text(
                                  "قم بكتابه مفكره من اجل الحفظ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child:  Text(
                                    "موافق",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          });
                    } else {

                      // print("======================$_check");
                      if ( widget.noteDetails != null) {
                        dynamic res = await controller.sqlDataBase.updateData(controller.sqlQuery.updateData(id!, _noteController.text.toString(), _titleController.text.toString()));
                          print("save is done update");
                          _noteController.text = "";
                          _titleController.text = "";
                          controller.refreshData();
                          Get.back();

                      } else {
                        dynamic res = await controller.sqlDataBase.insertData(
                            controller.sqlQuery.insertData(_noteController.text.toString(),
                                _titleController.text.toString()));
                          print("save is done insert");
                          _noteController.text = "";
                          _titleController.text = "";
                          controller.refreshData();
                          Get.back();
                      }
                    }
                  },
                  highlightColor: AppColors.primaryColor,
                  splashColor: AppColors.primaryColor,
                  icon:  Icon(
                    Icons.save_alt_sharp,
                    color: AppColors.white,
                    size: 30,
                  )),
          ),

          const SizedBox(
            width: 30,
          ),
        ],
      ),
      body: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  textDirection: TextDirection.rtl,
                  maxLength: _maxlength,
                  controller: _titleController,
                  autofocus: false,
                  maxLines: 1,
                  decoration:  InputDecoration(
                    hintTextDirection: TextDirection.rtl,
                    hintText: 'العنوان',
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color:AppColors.grey)),
                  ),
                ),
                TextField(
                  textDirection: TextDirection.rtl,
                  controller: _noteController,
                  autofocus: true,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintTextDirection: TextDirection.rtl,
                    hintText: 'المفكره...',
                    border: InputBorder.none,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
