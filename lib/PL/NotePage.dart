import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mynote/PL/NoteContainer.dart';
import '../DL/ConstantSql.dart';
import '../DL/SqlDb.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  ConstantSql sqlQuery = ConstantSql();
  SqlDb sqlDataBase = SqlDb();
  bool isloading = true;
  List notes = [];
  List title = [];

  Future readData() async {
    List<Map<String, dynamic>> noteResponse =
        await sqlDataBase.readData(sqlQuery.selectData);
    List<Map<String, dynamic>> titleResponse =
        await sqlDataBase.readData(sqlQuery.selectData2);
    notes.addAll(noteResponse);
    title.addAll(titleResponse);
    isloading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        //*******************************************
        systemOverlayStyle:const SystemUiOverlayStyle(
            statusBarColor: Colors.redAccent,
            statusBarBrightness: Brightness.light),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
              onPressed: () {},
              highlightColor: Colors.redAccent,
              splashColor: Colors.redAccent,
              icon: const Icon(
                Icons.search,
                size: 30,
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  readData();
                });
              },
              highlightColor: Colors.redAccent,
              splashColor: Colors.redAccent,
              icon: const Icon(
                Icons.add_circle,
                size: 30,
              )),
          const SizedBox(
            width: 20,
          ),
        ],
        title: const Text("llll"),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: ListView(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: notes.length,
              itemBuilder: (BuildContext context, int index) {
                final Map<String, dynamic> noteData = notes[index];
                final Map<String, dynamic> titleData = title[index];
                return Card(
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${noteData['note']}".length <= 30
                            ? "${noteData['note']}"
                            : "${noteData['note']}".substring(0, 30)),
                        Text("${titleData['title']}")
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const NoteContainer()));
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
