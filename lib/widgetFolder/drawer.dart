import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mynote/myBinding/myBinding.dart';

import '../controllers/drawerController.dart';
import '../view/FavoraitePage.dart';
import '../view/NotePage.dart';
import '../view/TrashPage.dart';


Drawer drawerWidget(Size size){

  return Drawer(

    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: const Text("أحمد قحطان"),
          accountEmail: const Text(" qahtan.dev@gmail.com"),
          currentAccountPicture: GetBuilder<MyDrawerController>(
            // init: MyDrawerController(),
            builder: (controller)=>InkWell(
              onTap: () {
                controller.pickImage(ImageSource.gallery);
              },
              child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    image: controller.image != null
                        ? DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(
                          controller.image!),
                    )
                        : const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/image/user.png"),
                    ),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(90.0)),
                    border: Border.all(
                      color: Colors.black12,
                      width: 1,
                    ),
                  ),
                  width: size.width * 0.45,
                  height: size.height * 0.21,
                ),
              ),
            ),),

          decoration: const BoxDecoration(
            color: Colors.redAccent,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3), // يغير مكان الظل
              ),
            ],
          ),
        ),

        ListTile(
          leading: const Icon(Icons.note),
          title: const Text('كل الملاحظات'),
          onTap: () {
             Get.to(()=>const NotePage());
          },
        ),  // كل الملاحظات

        ListTile(
          leading: const Icon(Icons.star),
          title: const Text('المفضلة'),
          onTap: () {
            // التنقل إلى شاشة الملاحظات المفضلة
            Get.to(()=> FavoritePage(),binding: MyFavoriteBinding());

          },
        ),//المفظلة

        ListTile(
          leading: const Icon(Icons.archive),
          title: const Text('الأرشيف'),
          onTap: () {
            // التنقل إلى شاشة الأرشيف
          },
        ),//الارشيف

        ListTile(
          leading: const Icon(Icons.delete),
          title: const Text('سلة المحذوفات'),
          onTap: () {
            // التنقل إلى شاشة سلة المحذوفات
            Get.to(()=>const TrashPage(),binding: MyTrashBinding());
          },
        ),// سله المحذوفات

        const Divider(),

        ListTile(
          leading: const Icon(Icons.category),
          title: const Text('الفئات'),
          onTap: () {
            // التنقل إلى شاشة الفئات
          },
        ),//الفئات

        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('الإعدادات'),
          onTap: () {
            // التنقل إلى شاشة الإعدادات
          },
        ),//الاعدادات

        ListTile(
          leading: const Icon(Icons.sync),
          title: const Text('المزامنة'),
          onTap: () {
            // التنقل إلى شاشة المزامنة
          },
        ),//المزامنه

        const Divider(),

        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('حول التطبيق'),
          onTap: () {
            // التنقل إلى شاشة حول التطبيق
          },
        ), //حول التطبيق

        ListTile(
          leading: const Icon(Icons.rate_review),
          title: const Text('التقييم والمراجعة'),
          onTap: () {
            // التنقل إلى صفحة التقييم والمراجعة في المتجر
          },
        ),//التقيم
      
      ],
    ),
  );
}
