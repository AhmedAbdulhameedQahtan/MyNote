import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mynote/PL/NoteContainer.dart';
import 'package:mynote/PL/NotePage.dart';
import 'package:get/get.dart';
import 'package:mynote/PL/TrashPage.dart';
import 'package:mynote/myBinding/myBinding.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(

      debugShowCheckedModeBanner: false,
       theme: ThemeData(
         splashColor: Colors.redAccent,
         primaryColor: Colors.redAccent,
       ),
      initialBinding: MainBinding(),
      getPages: [
        GetPage(name: '/', page:()=>const NotePage()),
        GetPage(name: '/NoteContainer', page:()=> NoteContainer()),
        GetPage(name: '/TrashPage', page:()=>const TrashPage()),
      ],

    );
  }
}
