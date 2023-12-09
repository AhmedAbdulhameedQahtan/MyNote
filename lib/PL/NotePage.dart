import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  bool isloading =true;
  List notes = [];

  Future readData() async {
    List<Map<String, dynamic>> response =
    await sqlDataBase.readData(sqlQuery.selectData);
    notes.addAll(response);
    isloading =false;
    if(this.mounted){
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
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search,size: 30,)),
          IconButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> NoteContainer()));
          }
        //       onPressed: () async {
        //   var res = await sqlDataBase.insertData(sqlQuery.insertData);
        //   print("THE RES = $res");
        //   readData();
        // }
        , icon: const Icon(Icons.add_circle,size: 30,)),
        ],
        title: Text("llll"),
      ),

      body: Container(
        width: size.width,
        height: size.height,
        child: ListView(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics:const  NeverScrollableScrollPhysics(),
              itemCount: notes.length,
              itemBuilder: (BuildContext context, int index) {
                final Map<String, dynamic> data = notes[index];
                return Card(
                  child: ListTile(
                    title:Text("${data['note']}")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
