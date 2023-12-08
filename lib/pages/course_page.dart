import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'attendance_page.dart';
import 'chat_page2.dart';

class CoursePage extends StatefulWidget {
  final String CourseName = "COMPUTER NETWORK";
  final String CourseCode = "CO34007";
  const CoursePage({super.key});

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
            TakeAttendance(),
            SizedBox(height: 10,),

            CourseChatTile(widget.CourseCode),


          ],
        ),

      ),
    );
  }
}

class TakeAttendance extends StatelessWidget {
  const TakeAttendance({
    super.key,
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
                builder: (context) => const AttendanceScreen()),
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
