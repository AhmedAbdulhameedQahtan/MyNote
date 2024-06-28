import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mynote/PL/NotePage.dart';
import '../DL/sqlCommand.dart';
import '../DL/SqlDb.dart';

class NoteContainer extends StatefulWidget {
  String? noteDetails;
  String? titleDetails;
  int? idDetails;
  NoteContainer({super.key, this.noteDetails , this.titleDetails});
  NoteContainer.Details(this.idDetails, this.noteDetails , this.titleDetails);
  @override
  _NoteContainerState createState() => _NoteContainerState();
}

class _NoteContainerState extends State<NoteContainer> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final int _maxlength = 30;
  bool _check = false;
  SqlDb sqlDataBase = SqlDb();
  ConstantSql sqlQuery = ConstantSql();

  @override
  void initState() {

    if( widget.noteDetails != null){
      _noteController.text = widget.noteDetails!;
      _titleController.text = widget.titleDetails!;
      _check=true;
    }
    super.initState();
  }

@override
Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  int? id = widget.idDetails;
  return Scaffold(
    appBar: AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.redAccent,
          statusBarBrightness: Brightness.light),
      backgroundColor: Colors.redAccent,
      actions: [
        IconButton(
            onPressed: () async {
              if (_noteController.text == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext) {
                      return AlertDialog(
                        title: const Center(
                          child: Text(
                            "Write Note Please ..",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                              // Navigator.of(context).pop();
                            },
                            child: const Text(
                              "ok",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              } else {
                print("======================$_check");
                if(_check==true){
                  dynamic res = await sqlDataBase.updateData(
                    sqlQuery.updateData(id!, _noteController.text.toString(), _titleController.text.toString())
                  );
                  setState(() {
                    _check=false;
                    print("save set state is call");
                    print("======================$_check");
                    _noteController.text = "";
                    _titleController.text = "";
                      // Navigator.of(context).pop();
                    Get.off(const NotePage());
                    // Navigator.of(context).pushReplacement(
                    //     MaterialPageRoute(builder: (context) => const NotePage()));
                  });
                }else{
                  dynamic res = await sqlDataBase.insertData(
                      sqlQuery.insertData(_noteController.text.toString(),
                          _titleController.text.toString()));
                  setState(() {
                    print("save set state is call");
                    print("======================$_check");
                    _noteController.text = "";
                    _titleController.text = "";
                    // Navigator.of(context).pop();
                    Get.off(const NotePage());
                    // Navigator.of(context).pushReplacement(
                    //     MaterialPageRoute(builder: (context) => const NotePage()));
                  });
                }

              }
            },
            highlightColor: Colors.redAccent,
            splashColor: Colors.redAccent,
            icon: const Icon(
              Icons.save_alt_sharp,
              size: 30,
            )),
        const SizedBox(
          width: 30,
        ),
      ],
      title: IconButton(
        onPressed: (){
          Get.off(const NotePage());
          // Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(builder: (context) => const NotePage()));
        },
          highlightColor: Colors.redAccent,
          splashColor: Colors.redAccent,
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          )
      ),
    ),
    body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                maxLength: _maxlength,
                controller: _titleController,
                autofocus: true,
                maxLines: 1,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              TextField(
                controller: _noteController,
                autofocus: true,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Write your note...',
                  border: InputBorder.none,
                ),
              )
            ],
          ),
        )),
  );
}

@override
void dispose() {
  print("save dispose is call");
  _noteController.dispose();
  _titleController.dispose();
  super.dispose();
}}
