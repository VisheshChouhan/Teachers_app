

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:teachers_app/pages/upload_marks.dart';

import 'attendance_page.dart';
import 'chat_page2.dart';

class CoursePage extends StatefulWidget {
  final String CourseName;
  final String CourseCode;
  const CoursePage({super.key, required this.CourseName, required this.CourseCode});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),
            Padding(
                padding:const EdgeInsets.symmetric(horizontal: 10, vertical:0),
              child: Text(widget.CourseName,
              style:GoogleFonts.abel( textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold ),),

            ),
            ),
            const SizedBox(height: 0,),
            Padding(
              padding:const EdgeInsets.symmetric(horizontal: 10),
              child: Text(widget.CourseCode,
                style:GoogleFonts.abel( textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold ),),

              ),
            ),
            const SizedBox(height: 50,),
            TakeAttendance(courseCode: widget.CourseCode,),
            SizedBox(height: 10,),

            CourseChatTile(widget.CourseCode),
            const SizedBox(height: 10,),
            DownloadAttendance(courseCode: widget.CourseCode),
            const SizedBox(height: 10,),
            UploadMarks(courseCode: widget.CourseCode,),
            


          ],
        ),

      ),
    );
  }
}

class TakeAttendance extends StatelessWidget {
  final String courseCode;
  const TakeAttendance({
    super.key, required this.courseCode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>  AttendanceScreen(courseCode: courseCode,)),
          );
        },
        child: Container(
          padding: EdgeInsets.all(12),
          height: 75,
          width: 500,
          decoration: BoxDecoration(
              color: Colors.pink[100],
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Row(
              children: [
                const Image(
                  image: AssetImage(
                      "lib/assets/icons/immigration.png"),
                  height: 50,
                  width: 50,
                ),
                SizedBox(width: 10,),
                Text(
                    'Take Attendance for the ongoing class',
                    style: GoogleFonts.abel(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class DownloadAttendance extends StatelessWidget {
  final String courseCode;
  const DownloadAttendance({
    super.key, required this.courseCode,
  });



  Future<List<Map<String, dynamic>>> fetchAttendanceData() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('Courses').doc(courseCode).collection("Attendance").get();

    List<Map<String, dynamic>> attendanceData = [];

    querySnapshot.docs.forEach((dateDocument) {
      dateDocument.reference.collection('present').get().then((studentDetails) {
        studentDetails.docs.forEach((student) {
          attendanceData.add({
            'attendanceTime': student["attendanceTime"],
            'name': student['name'],

            // Add other fields as needed
          });
        });
      });
    });

    return attendanceData;
  }


  String convertToCsv(List<Map<String, dynamic>> data) {
    List<List<dynamic>> csvData = [];

    // Add CSV header
    csvData.add(data.toList());

    // Add data rows
    csvData.addAll(data.map((row) => row.values.toList()));

    return ListToCsvConverter().convert(csvData);
  }

  Future<void> writeCsvToFile(String csvData) async {
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = join(dir, 'attendance.csv');

    await File(path).writeAsString(csvData);
  }

  void exportAttendanceToCsv() async {
    List<Map<String, dynamic>> attendanceData = await fetchAttendanceData();
    String csvData = convertToCsv(attendanceData);
    await writeCsvToFile(csvData);

    // Optionally, you can provide feedback to the user that the export is complete.


  }


  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          exportAttendanceToCsv();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("file created")));
          /*Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>  AttendanceScreen(courseCode: courseCode,)),
          );*/
        },
        child: Container(
          padding: EdgeInsets.all(12),
          height: 75,
          width: 500,
          decoration: BoxDecoration(
              color: Colors.pink[100],
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Row(
              children: [
                const Image(
                  image: AssetImage(
                      "lib/assets/icons/attendance_uncoloured.png"),
                  height: 50,
                  width: 50,
                ),
                SizedBox(width: 10,),
                Text(
                    'Download Attendance till date',
                    style: GoogleFonts.abel(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CourseChatTile extends StatelessWidget {
  final String Code;
  const CourseChatTile(String this.Code, {
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>  ChatPage2(Code)),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          height: 75,
          width: 500,
          decoration: BoxDecoration(
              color: Colors.deepPurple[100],
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Row(
              children: [
                const Image(
                  image: AssetImage(
                      "lib/assets/icons/comments.png"),
                  height: 40,
                  width: 50,
                ),
                SizedBox(width: 10,),
                Text(
                    'Group Page',
                    style: GoogleFonts.abel(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class UploadMarks extends StatelessWidget {
  final String courseCode;
  const UploadMarks({
    super.key, required this.courseCode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>  bulkUpload(courseCode: courseCode,)),
          );
        },
        child: Container(
          padding: EdgeInsets.all(12),
          height: 75,
          width: 500,
          decoration: BoxDecoration(
              color: Colors.deepPurple[100],
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Row(
              children: [
                const Image(
                  image: AssetImage(
                      "lib/assets/icons/marketing.png"),
                  height: 45,
                  width: 50,
                ),
                SizedBox(width: 10,),
                Text(
                    'Upload Marks',
                    style: GoogleFonts.abel(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


