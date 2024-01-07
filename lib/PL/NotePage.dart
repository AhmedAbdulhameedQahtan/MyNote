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
  final TextEditingController _searchController = TextEditingController();
  ConstantSql sqlQuery = ConstantSql();
  SqlDb sqlDataBase = SqlDb();
  bool isloading = true;
  List storeData = [];
  bool _isvisibal =false;

  Future readData() async {
    List<Map<String, dynamic>> dataResponse = await sqlDataBase.readData(sqlQuery.selectAllData());
    storeData.addAll(dataResponse);
    isloading = false;
    if (mounted) {
      setState(() {
        print("setstate of read data is called");
      });
    }
  }

  Future searchNote(str) async {
    List<Map<String, dynamic>> searchResponse = await sqlDataBase.readData(
        sqlQuery.searchData(str));
    setState(() {
      storeData.addAll(searchResponse);
      isloading = false;
    });
    if (mounted) {
      setState(() {
        print("setstate of search data is called");
      });
    }
  }

  @override
  void initState() {
    print("initstate is called");
    readData();
    super.initState();
  }

  void _searchRefresh(str) {
    setState(() {
      print("setstate of refresh is called");
      storeData = [];
      searchNote(str);
    });
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
    Size size = MediaQuery.of(context).size;
    String _str ="";
    return Scaffold(
      drawer: Drawer(
        width: size.width/1.5,

      ),
      appBar: AppBar(
        //*******************************************
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.redAccent,
            statusBarBrightness: Brightness.light),
        backgroundColor: Colors.redAccent,
        actions: [
          Visibility(
            visible: _isvisibal,
            child: Container(
              width: size.width/1.8,
              child: TextFormField(
                controller: _searchController,
                onChanged: (str) async{
                  _str!=_searchController.text.toString();
                  print("object===================$str");
                  _searchRefresh(str);
                },
                autofocus: true,
                maxLines: 1,
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                       borderSide: BorderSide(color: Colors.white)),
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  _isvisibal =!_isvisibal;
                });
                if(!_isvisibal){
                  _searchController.clear();
                  _refreshData();
                }
              },
              highlightColor: Colors.redAccent,
              splashColor: Colors.redAccent,
              icon: const Icon(
                Icons.search,
                size: 30,
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => NoteContainer()));
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
      ),

      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification? overScroll){
          overScroll!.disallowIndicator();
          return true;
        },
          child: bodyContainer(size)
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
                  Navigator.of(context).pushReplacement(
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
                            const SizedBox(width: 10),
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