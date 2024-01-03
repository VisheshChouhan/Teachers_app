import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle, rootBundle;
import 'package:csv/csv.dart';
import 'package:google_fonts/google_fonts.dart';

class bulkUpload extends StatefulWidget {
  final String courseCode;
  const bulkUpload({Key? key, required this.courseCode}) : super(key: key);

  @override
  State<bulkUpload> createState() => _bulkUploadState();
}

class _bulkUploadState extends State<bulkUpload> {
  List<List<dynamic>> _data = [];
  String? filePath;
  TextEditingController textEditingController = TextEditingController();

  // This function is triggered when the  button is pressed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Colors.white,
            // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          title: const Text("Upload Marks",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              )),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: textEditingController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Enter exam Name"),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Expanded(
                        child: AlertDialog(
                          title: Text('File Format Alert',
                              style: GoogleFonts.abel(
                                textStyle: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              )),
                          content: Table(
                            border: TableBorder.all(),
                            children: [
                              TableRow(children: [
                                Container(
                                  child: Text("Student UserName",
                                      style: GoogleFonts.abel(
                                        textStyle: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                Container(
                                  child: Text("Marks(in %)",
                                      style: GoogleFonts.abel(
                                        textStyle: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                                )
                              ]),
                              TableRow(children: [
                                Container(
                                  child: Text("....",
                                      style: GoogleFonts.abel(
                                        textStyle: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                Container(
                                  child: Text("....",
                                      style: GoogleFonts.abel(
                                        textStyle: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                                )
                              ]),
                              TableRow(children: [
                                Container(
                                  child: Text("....",
                                      style: GoogleFonts.abel(
                                        textStyle: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                Container(
                                  child: Text("....",
                                      style: GoogleFonts.abel(
                                        textStyle: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                                )
                              ]),
                            ],
                          ),
                          actions: [
                            ElevatedButton(
                              //textColor: Colors.black,
                              onPressed: () {
                                _pickFile();
                              },
                              child: const Text('Ok'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                  /*_pickFile();*/
                },
                child: Text("Select File",
                    style: GoogleFonts.abel(
                      textStyle: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _data.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return Card(
                    margin: const EdgeInsets.all(3),
                    color: index == 0 ? Colors.blue : Colors.white,
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 200,
                            color: index == 0 ? Colors.blue : Colors.white,
                            child: Flexible(
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                strutStyle: StrutStyle(fontSize: 12.0),
                                text: TextSpan(
                                    style: TextStyle(
                                        fontSize: index == 0 ? 18 : 15,
                                        fontWeight: index == 0
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: index == 0
                                            ? Colors.white
                                            : Colors.black),
                                    text: _data[index][0].toString()),
                              ),
                            ),
                            /*Text(_data[index][0].toString(),textAlign: TextAlign.center,
                            style: TextStyle(fontSize: index == 0 ? 18 : 15, fontWeight: index == 0 ? FontWeight.bold :FontWeight.normal,color: index == 0 ? Colors.red : Colors.black),),*/
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const VerticalDivider(
                            color: Colors.deepPurple,
                            thickness: 2,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            color: index == 0 ? Colors.blue : Colors.white,
                            child: Text(
                              _data[index][1].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: index == 0 ? 18 : 15,
                                  fontWeight: index == 0
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color:
                                      index == 0 ? Colors.white : Colors.black),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: (){
                  if (textEditingController.text.isNotEmpty) {
                    for (var element in _data.skip(1)) // for skip first value bcs its contain name
                        {
                      final db = FirebaseFirestore.instance;
                      final docRef = db
                          .collection("students")
                          .doc(element[0].toString()).collection("groups").doc(widget.courseCode);

                      docRef.get().then(
                            (DocumentSnapshot doc) {
                          if (doc.exists) {

                            db.collection("students")
                                .doc(element[0])
                                .collection("groups")
                                .doc(widget.courseCode)
                                .collection("marks")
                                .doc(textEditingController.text.trim().toUpperCase().toString()).set(
                                {
                                  "examName": textEditingController.text.trim().toUpperCase().toString(),
                                  "marksObtained": element[1].toString()

                                }

                            );

                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Marks Uploaded Succesfully"),
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("${element[0]} doesn't exists."),
                            ));
                          }

                          // ...
                        },
                        onError: (e) => print("Error getting document: $e"),
                      );
                    }
                  } else if(_data.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please select a file."),
                    ));


                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please enter Exam Name First"),
                    ));

                  }

                }  ,
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue),

                ),
                child:  Text("Upload Marks",
                  style: GoogleFonts.abel( textStyle: TextStyle(fontSize: 20),color: Colors.white) ,),
              ),
            ),
          ],
        ));
  }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if no file is picked
    if (result == null) return;
    // we will log the name, size and path of the
    // first picked file (if multiple are selected)
    print(result.files.first.name);
    filePath = result.files.first.path!;

    final input = File(filePath!).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
    print(fields);

    setState(() {
      _data = fields;
    });
    Navigator.of(context, rootNavigator: true).pop();
  }


}
