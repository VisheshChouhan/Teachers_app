import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teachers_app/pages/course_page.dart';

class CourseTile extends StatelessWidget {
  final String courseName;
  final String courseCode;
  final String imagePath;
  //final lectureType;

  const CourseTile({
    super.key,
    required this.courseCode,
    required this.courseName,
    required this.imagePath,
    //required this.lectureType,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) => const CoursePage()) );
      },
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.deepPurple[100],
              borderRadius: BorderRadius.circular(10)),
          width: 170.0,
          child: Expanded(
            child: Column(
              children: [
                //Picture of the subject
                CircleAvatar(
                  backgroundColor: Colors.deepPurple[200],
                  radius: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      imagePath,
                      height: 100.0,
                    ),
                  ),
                ),

                //Mode
                Text(courseCode,
                    style: GoogleFonts.abel(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )),

                SizedBox(
                  height: 20,
                ),

                //Subject Name
                Text(courseName,
                    style: GoogleFonts.abel(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )),

                //subject code
                /*Text(
                  'C0234006',
                    style :  GoogleFonts.abel(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )
                )*/
              ],
            ),
          )),
    ));
  }
}
