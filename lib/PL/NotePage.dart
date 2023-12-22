import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mynote/PL/NoteContainer.dart';
import '../DL/sqlCommand.dart';
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
  List storeData = [];

  Future readData() async {
    List<Map<String, dynamic>> dataResponse = await sqlDataBase.readData(sqlQuery.selectAllData);
    storeData.addAll(dataResponse);
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


  void _refreshData() {
    setState(() {
      print("setstate of refresh is called");
      storeData = [];
      readData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        //*******************************************
        systemOverlayStyle: const SystemUiOverlayStyle(
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
              MaterialPageRoute(builder: (context) => NoteContainer()));
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
            itemCount: storeData.length,
            itemBuilder: (BuildContext context, int index) {
              final Map<String, dynamic> notesData = storeData[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>
                          NoteContainer.Details(
                              notesData['id'], "${notesData['note']}",
                              "${notesData['title']}")));
                },
                onLongPress: () {
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
                                dynamic deletres = await sqlDataBase.deletData(
                                    sqlQuery.deletData(notesData['id']));
                                setState(() {
                                  _refreshData();
                                  print(
                                      "***********setstate after delet **********");
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
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("${notesData['title']}",style: const TextStyle(fontWeight: FontWeight.w800,),),
                  Text("${notesData['note']}".length <= 30
                      ? "${notesData['note']}".replaceAll(RegExp(r'\s*\n\s*|\s+'), ' ')
                      : "${notesData['note']}".substring(0, 30)),
                  // \s*\n\s*: Matches any whitespace characters followed by a newline character and then followed by more whitespace characters.
                  // This matches and removes empty lines while considering any leading/trailing whitespace.
                  // |: OR operator.
                  // \s+: Matches one or more whitespace characters occurring in the middle of lines.
                ],

              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text("${notesData['note']}".length <= 30
              //         ? "${notesData['note']}"
              //         : "${notesData['note']}".substring(0, 30)),
              //     Text("${notesData['title']}")
              //   ],
              // ),
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