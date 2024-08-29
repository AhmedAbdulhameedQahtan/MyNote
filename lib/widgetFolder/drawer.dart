import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../BL/drawerController.dart';
import '../PL/TrashPage.dart';

Drawer drawerWidget(Size size){

  return Drawer(

    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: const Text("أحمد قحطان"),
          accountEmail: const Text(" qahtan.dev@gmail.com"),
          currentAccountPicture: GetBuilder<MyDrawerController>(
            init: MyDrawerController(),
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
            // Get.off(const NotePage());
          },
        ),
        // ListTile(
        //   title: Text('English'),
        //   onTap: () {
        //     setLocale(Locale('en'));
        //     Navigator.of(context).pop();
        //   },
        // ),
        // ListTile(
        //   title: Text('العربية'),
        //   onTap: () {
        //     setLocale(Locale('ar'));
        //     Navigator.of(context).pop();
        //   },
        // ),
        ListTile(
          leading: const Icon(Icons.star),
          title: const Text('المفضلة'),
          onTap: () {
            // التنقل إلى شاشة الملاحظات المفضلة
          },
        ),
        ListTile(
          leading: const Icon(Icons.archive),
          title: const Text('الأرشيف'),
          onTap: () {
            // التنقل إلى شاشة الأرشيف
          },
        ),
        ListTile(
          leading: const Icon(Icons.delete),
          title: const Text('سلة المحذوفات'),
          onTap: () {
            // التنقل إلى شاشة سلة المحذوفات
            Get.to(const TrashPage());
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.category),
          title: const Text('الفئات'),
          onTap: () {
            // التنقل إلى شاشة الفئات
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('الإعدادات'),
          onTap: () {
            // التنقل إلى شاشة الإعدادات
          },
        ),
        ListTile(
          leading: const Icon(Icons.sync),
          title: const Text('المزامنة'),
          onTap: () {
            // التنقل إلى شاشة المزامنة
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('حول التطبيق'),
          onTap: () {
            // التنقل إلى شاشة حول التطبيق
          },
        ),
        ListTile(
          leading: const Icon(Icons.help),
          title: const Text('مساعدة'),
          onTap: () {
            // التنقل إلى شاشة المساعدة
          },
        ),
        ListTile(
          leading: const Icon(Icons.rate_review),
          title: const Text('التقييم والمراجعة'),
          onTap: () {
            // التنقل إلى صفحة التقييم والمراجعة في المتجر
          },
        ),
      
      ],
    ),
  );
}
