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
  List id=[];

  Future readData() async {
    List<Map<String, dynamic>> idResponse =
    await sqlDataBase.readData(sqlQuery.selectData3);
    List<Map<String, dynamic>> noteResponse =
        await sqlDataBase.readData(sqlQuery.selectData);
    List<Map<String, dynamic>> titleResponse =
        await sqlDataBase.readData(sqlQuery.selectData2);
    id.addAll(idResponse);
    notes.addAll(noteResponse);
    title.addAll(titleResponse);
    isloading = false;
    if (mounted) {
      setState(() {
        print("setstate of read data is called");
      });
    }
  }

  @override
  void initState() {
    print("initstate is called");
    readData();
    super.initState();
  }

  void _refreshData(){
    setState(() {
      id=[];
     notes=[];
     title=[];
     readData();
      });
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
                  print("setstate of refresh is called");
                  _refreshData();
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
      body: bodyContainer(size),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) =>  NoteContainer()));
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  Container bodyContainer(Size size) {
    return Container(
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
              final Map<String, dynamic> idData = id[index];
              print(index);
              print("++++++++++++++++++++++${idData['id']}++++++++++++++++++++++++");
              return InkWell(
                onTap: (){
                  print("++++++++++++++++++++++${idData['id']}++++++++++++++++++++++++");
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>  NoteContainer.Details("${noteData['note']}","${titleData['title']}")));
                },
                onLongPress: (){
                  print("++++++++++++++++++++++${idData['id']}++++++++++++++++++++++++");
                  showDialog(
                      context: context,
                      builder: (BuildContext) {
                        return AlertDialog(
                          title: const Center(
                            child: Text(
                              "Delete This Note ?",
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
                                "Cancel",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            TextButton(
                              onPressed: () async {
                                dynamic deletres = await sqlDataBase.deletData(sqlQuery.deletData(idData['id']));
                                print("deletres was deleted successful");
                                setState(() {
                                  _refreshData();
                                  print("***********setstate after delet **********");
                                  Navigator.of(context).pop();
                                });
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
                },
                child: Card(
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
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
