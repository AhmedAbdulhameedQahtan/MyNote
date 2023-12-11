import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../DL/ConstantSql.dart';
import '../DL/SqlDb.dart';
import 'package:flutter/cupertino.dart';

class NoteContainer extends StatefulWidget {
  const NoteContainer({super.key});
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:const SystemUiOverlayStyle(
            statusBarColor: Colors.redAccent,
            statusBarBrightness: Brightness.light),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
              onPressed: () async {
                dynamic res = await sqlDataBase.insertData(sqlQuery.insertData(
                    _noteController.text.toString(),
                    _titleController.text.toString()));
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
    _noteController.dispose();
    _titleController.dispose();
    super.dispose();
  }
}
