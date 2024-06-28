import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../DL/SqlDb.dart';
import '../DL/sqlCommand.dart';
import 'NoteContainer.dart';

class TrashPage extends StatefulWidget {
  const TrashPage({super.key});

  @override
  State<TrashPage> createState() => _TrashPageState();
}

class _TrashPageState extends State<TrashPage> {
  List storeData = [];
  ConstantSql sqlQuery = ConstantSql();
  SqlDb sqlDataBase = SqlDb();
  bool isloading = true;
  bool _isvisibal =false;
  final TextEditingController _searchController = TextEditingController();


  Future readData() async {
    List<Map<String, dynamic>> dataResponse = await sqlDataBase.readData(sqlQuery.selectAllTrash());
    storeData.addAll(dataResponse);
    print("storeData= $storeData");
    isloading = false;
    if (mounted) {
      setState(() {
        print("setstate of read data from trash is called");
      });
    }
  }

  Future searchNote(str) async {
    List<Map<String, dynamic>> searchResponse = await sqlDataBase.readData(
        sqlQuery.searchTrashData(str));
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
  void _refreshData() {
    setState(() {
      print("setstate of refresh trash is called");
      storeData = [];
      readData();
    });
  }

  void _searchRefresh(str) {
    setState(() {
      print("setstate of refresh is called");
      storeData = [];
      searchNote(str);
    });
  }

  @override
  void initState() {
    print("initstate trash is called");
    readData();
    _loadPhoto();
    super.initState();
  }

  File? _selectedPhoto;

  Future<void> _selectPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String path = appDir.path;
      final File newImage = await File(pickedFile.path).copy('$path/user_profile.jpg');

      setState(() {
        _selectedPhoto = newImage;
      });

      // Save the path to shared_preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_profile', newImage.path);
    }
    _loadPhoto();
  }

  Future<void> _loadPhoto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? photoPath = prefs.getString('user_profile');
    if (photoPath != null) {
      setState(() {
        _selectedPhoto = File(photoPath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String _str ="";

    return  Scaffold(
      drawer:Drawer(
    child: ListView(
    padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: const Text("أحمد قحطان"),
          accountEmail: const Text(" qahtan.dev@gmail.com"),
          currentAccountPicture: InkWell(
            onTap: () {
              _selectPhoto();
            },
            child: CircleAvatar(
              radius: 45,
              backgroundColor: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  image: _selectedPhoto != null
                      ? DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(_selectedPhoto!),
                  )
                      : const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/image/user.png"),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(90.0)),
                  border: Border.all(
                    color: Colors.black12,
                    width: 1,
                  ),
                ),
                width: size.width*0.45,
                height: size.height*0.21,
              ),
            ),
          ),
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
            // التنقل إلى شاشة كل الملاحظات
          },
        ),
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
          Visibility(
            visible: !_isvisibal,
            child: Text("سلة المحذوفات"),
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
                color: Colors.white,
                size: 30,
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  Get.off(NoteContainer());
                  // Navigator.of(context).pushReplacement(
                  //     MaterialPageRoute(builder: (context) => NoteContainer()));
                });
              },
              highlightColor: Colors.redAccent,
              splashColor: Colors.redAccent,
              icon: const Icon(
                Icons.add_circle,
                color: Colors.white,
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
              print("the storeData index ===========${storeData[index]}");
              print("the num ===========${notesData['note']}");
              return InkWell(
                onTap: () {
                  Get.off(NoteContainer.Details(
                      notesData['id'], "${notesData['note']}",
                      "${notesData['title']}"));
                },

                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext) {
                        return AlertDialog(
                          title: const Center(
                            child: Text(
                              "الحذف من سلة المحذوفات",
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
                                Get.back();
                              },
                              child: const Text(
                                "تراجع",
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
                                    sqlQuery.deletTrashData(notesData['id']));
                                setState(() {
                                  Get.snackbar("تم حذف المفكرة بنجاح","");
                                   _refreshData();
                                  print("***********setstate after trash delet **********");
                                  // Get.back();
                                  Navigator.of(context).pop();
                                });
                              },
                              child: const Text(
                                "موافق",
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
                        Text(
                          ("${notesData['note']}".replaceAll(RegExp(r'\s*\n\s*|\s+'), ' ').length <= 30
                              ? "${notesData['note']}".replaceAll(RegExp(r'\s*\n\s*|\s+'), ' ')
                              : "${notesData['note']}".replaceAll(RegExp(r'\s*\n\s*|\s+'), ' ').substring(0, 30)),
                        )
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
