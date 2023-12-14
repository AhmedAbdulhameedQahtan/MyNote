import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../DL/ConstantSql.dart';
import '../DL/SqlDb.dart';

class NoteContainer extends StatefulWidget {
  String? noteDetails;
  String? titleDetails;
  NoteContainer({super.key, this.noteDetails , this.titleDetails});
  NoteContainer.Details( this.noteDetails , this.titleDetails);
  @override
  _NoteContainerState createState() => _NoteContainerState();
}

class _NoteContainerState extends State<NoteContainer> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final int _maxlength = 30;
  SqlDb sqlDataBase = SqlDb();
  ConstantSql sqlQuery = ConstantSql();

  @override
  void initState() {

    if( widget.noteDetails != null){
      _noteController.text = widget.noteDetails!;
      _titleController.text = widget.titleDetails!;

    }
    super.initState();
  }

@override
Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
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
                              Navigator.of(context).pop();
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
                dynamic res = await sqlDataBase.insertData(
                    sqlQuery.insertData(_noteController.text.toString(),
                        _titleController.text.toString()));
                setState(() {
                  print("save set state is call");
                  _noteController.text = "";
                  _titleController.text = "";
                  Navigator.of(context).pop();
                });
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
