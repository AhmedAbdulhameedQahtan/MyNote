
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mynote/PL/NoteContainer.dart';
import 'package:mynote/PL/NotePage.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
       theme: ThemeData(
         splashColor: Colors.redAccent,
         primaryColor: Colors.redAccent,
       ),
       home:  const NotePage(),

    );
  }
}
