import 'package:flutter/material.dart';

class NoteContainer extends StatefulWidget {
  @override
  _NoteContainerState createState() => _NoteContainerState();
}

class _NoteContainerState extends State<NoteContainer> {
  TextEditingController _noteController = TextEditingController();
  TextEditingController _TitleController = TextEditingController();
  final int _maxlength = 30;
  bool _isEditing = false;

  @override
  void dispose() {
    _noteController.dispose();
    _TitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.only(left: 16, right: 16),
          child:
              // _isEditing
              //     ?
              SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  maxLength: _maxlength,
                  controller: _TitleController,
                  autofocus: true,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      hintText: 'Title',
                     focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                      // border: UnderlineInputBorder(),),
                  ),
                ),
                TextField(
                  controller: _noteController,
                  autofocus: true,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Write your note...',
                    border: InputBorder.none,
                  ),
                )
              ],
            ),
          )
          //     : Text(
          //   'Tap to write a note',
          //   style: TextStyle(color: Colors.grey),
          // ),
          ),
      // GestureDetector(
      //   onTap: () {
      //     setState(() {
      //       _isEditing = true;
      //     });
      //   },
      //   child: Container(
      //     width: size.width,
      //     height: size.height,
      //     padding: EdgeInsets.only(left: 16, right: 16),
      //     child: _isEditing
      //         ? SingleChildScrollView(
      //             child: Column(
      //               children: [
      //                 TextFormField(
      //                   controller: _TitleController,
      //                   autofocus: true,
      //                   maxLines: 1,
      //                   decoration: const InputDecoration(
      //                       hintText: 'Title', border: InputBorder.none),
      //                 ),
      //                 TextField(
      //                   controller: _noteController,
      //                   autofocus: true,
      //                   maxLines: null,
      //                   decoration: InputDecoration(
      //                     hintText: 'Write your note...',
      //                     border: InputBorder.none,
      //                   ),
      //                 )
      //               ],
      //             ),
      //           )
      //         : Text(
      //             'Tap to write a note',
      //             style: TextStyle(color: Colors.grey),
      //           ),
      //   ),
      // ),
    );
  }
}
