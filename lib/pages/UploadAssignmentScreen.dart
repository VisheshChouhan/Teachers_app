import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UploadAssignmentsScreen extends StatefulWidget {
  final String courseCode;
  const UploadAssignmentsScreen({super.key, required this.courseCode});

  @override
  State<UploadAssignmentsScreen> createState() =>
      _UploadAssignmentsScreenState();
}

class _UploadAssignmentsScreenState extends State<UploadAssignmentsScreen> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> pdfData = [];
  TextEditingController _dateController = new TextEditingController();
  DateTime dateTime = DateTime.now();

  Future<String> uploadPdf(String fileName, File file) async {
    final reference =
        FirebaseStorage.instance.ref().child("assignments/$fileName.pdf");

    final uploadTask = reference.putFile(file);

    await uploadTask.whenComplete(() {});

    final downloadLink = await reference.getDownloadURL();

    return downloadLink;
  }

  void pickFile() async {

    if (_dateController.text.isNotEmpty) {
      Navigator.pop(context);

      final pickedFile = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ["pdf"]);

      if (pickedFile != null) {
        String filename = pickedFile.files[0].name;
        File file = File(pickedFile.files[0].path!);
        final downloadLink = await uploadPdf(filename, file);

        await _firebaseFirestore
            .collection("Courses")
            .doc(widget.courseCode)
            .collection("Assignments")
            .add({
          "pdfName": filename,
          "downloadUrl": downloadLink,
          "dueDate": _dateController.text.toString()
        });

        print("Pdf Uploaded successfully");
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter the due date..")));
    }
  }

  void getAllPdf() async {
    final result = await _firebaseFirestore
        .collection("Courses")
        .doc(widget.courseCode)
        .collection("Assignments")
        .get();
    pdfData = result.docs.map((e) => e.data()).toList();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllPdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assignments"),
      ),
      backgroundColor: Colors.grey[200],
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: pdfData.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PdfViewerScreen(
                          pdfUrl: pdfData[index]["downloadUrl"])));
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "lib/assets/icons/assignments.png",
                        height: 120,
                        width: 100,
                      ),
                      Text(
                        pdfData[index]["pdfName"],
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                title: const Text("Enter due date..."),
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Column(
                      children: [
                        TextFormField(
                          readOnly: true,
                          onTap: _selectDate,
                          controller: _dateController,

                          keyboardType: TextInputType.datetime,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: pickFile,
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.blue)),
                            child: const Text(
                              "Select file",
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    ),
                  )
                ],
              );
            }),
        child: const Icon(Icons.upload_file),
      ),
    );
  }

  _selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null) {
      dateTime = picked;
      //assign the chosen date to the controller
      _dateController.text = DateFormat.yMMMd().format(dateTime).toString();
    }
  }
}

class PdfViewerScreen extends StatefulWidget {
  final String pdfUrl;
  const PdfViewerScreen({super.key, required this.pdfUrl});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  PDFDocument? document;

  void initializePdf() async {
    document = await PDFDocument.fromURL(widget.pdfUrl);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializePdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: document != null
          ? PDFViewer(
              document: document!,
            )
          : Center(
              child: const CircularProgressIndicator(),
            ),
    );
  }
}
