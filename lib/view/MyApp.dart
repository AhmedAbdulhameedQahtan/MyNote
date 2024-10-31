import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynote/myBinding/myBinding.dart';
import 'package:mynote/resources/appColors.dart';
import 'AddNotePage.dart';
import 'NotePage.dart';
import 'TrashPage.dart';

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
         splashColor: AppColors.primaryColor,
         primaryColor: AppColors.primaryColor,
         useMaterial3: true,
       ),
      // initialBinding: MainBinding(),
      initialRoute: "/",
      getPages: [
        GetPage(name: '/', page:()=>const NotePage() , binding: MainBinding()),
        GetPage(name: '/NoteContainer', page:()=> AddNotePage()),
        GetPage(name: '/TrashPage', page:()=>const TrashPage()),
      ],


    );
  }
}
