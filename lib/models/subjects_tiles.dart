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
    /*return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("lib/assets/subject_background.jpg"),
            fit: BoxFit.cover
        ),

      ),
      child: Text("Adsfasd"),
    );*/
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
                image: AssetImage("lib/assets/subject_background.jpg"),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CoursePage(
                                CourseName: courseName,
                                CourseCode: courseCode,
                              )));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10)),
                    width: double.infinity,
                    child: Expanded(
                      child: Row(
                        children: [
                          //Picture of the subject
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(courseCode,
                                  style: GoogleFonts.abel(
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.white
                                    ),
                                  )),

                              //Subject Name
                              Text(courseName,
                                  style: GoogleFonts.abel(
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Colors.white
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //const SizedBox(height: 10,)
            ],
          ),
        ));
  }

  /*@override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [

          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CoursePage( CourseName: courseName, CourseCode: courseCode,)));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple[100],
                        borderRadius: BorderRadius.circular(10)),
                    width: double.infinity,
                    child: Expanded(
                      child: Row(
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
                          const SizedBox(
                            width: 20,
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start  ,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [


                              Text(courseCode,
                                  style: GoogleFonts.abel(
                                    textStyle: const  TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  )),



                              //Subject Name
                              Text(courseName,
                                  style: GoogleFonts.abel(
                                    textStyle:const  TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  )),

                            ],
                          ),

                          //Mode


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
              ),
          ),
          const SizedBox(height: 10,)
        ],
      ),
    );
  }*/
}
