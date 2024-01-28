import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:teachers_app/models/bullets.dart';
import 'package:teachers_app/models/category_card.dart';
import 'package:teachers_app/models/subjects_tiles.dart';
import 'package:teachers_app/pages/attendance_page.dart';
import 'package:teachers_app/pages/community_page.dart';

import 'create_class.dart';
import 'teacher_profile_settings.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    String docId = FirebaseAuth.instance.currentUser?.uid ?? '';
    return FutureBuilder<DocumentSnapshot>(
      //Fetching data from the documentId specified of the student
      future:
          FirebaseFirestore.instance.collection('teachers').doc(docId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        //Error Handling conditions
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        //Data is output to the user
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            backgroundColor: Colors.grey[200],
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //appbar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),

                              Text('Hello,',
                                  style: GoogleFonts.abel(
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  )),
                              const SizedBox(
                                height: 5,
                              ),

                              //name
                              Text(data['name'],
                                  style: GoogleFonts.abel(
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  ))
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileScreen()),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Icon(
                                Icons.person,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      child:Divider(thickness: 2,),),

                    //cards over and take attendance bar starts
                    //
                    //










                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Your Classes',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CreateClass()));
                            },
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.deepPurple),
                                foregroundColor:
                                    MaterialStatePropertyAll(Colors.white)),
                            child: const Text("Create Class"),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 25.0,
                    ),
                    SizedBox(
                        height: 700,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Expanded(
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("teachers")
                                  .doc(docId)
                                  .collection("CreatedCourses")
                                  .orderBy("courseCode")
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        final Courses =
                                            snapshot.data!.docs[index];
                                        return CourseTile(
                                          courseName: Courses["courseName"],
                                          courseCode: Courses["courseCode"],
                                          imagePath:
                                              'lib/assets/subject_images/data_structures.png',
                                        );
                                      });
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error:${snapshot.error}'),
                                  );
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                        ])),

                    /*Container(
                      height: 425,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: const [
                          SubjectTile(
                            text: "Operating Systems",
                            /*imagePath:
                                'lib/assets/subject_images/data_structures.png',*/
                            lectureType: 'Lecture',
                          ),
                          SubjectTile(
                            text: "Data Structures",
                            /*imagePath:
                                'lib/assets/subject_images/hierarchy-structure.png',*/
                            lectureType: 'Tutorial',
                          ),
                          SubjectTile(
                            text: "Databases",
                            /*imagePath:
                                'lib/assets/subject_images/cloud-database.png',*/
                            lectureType: 'Lab',
                          ),
                          SubjectTile(
                            text: "Operating Systems",
                            /**imagePath:
                                'lib/assets/subject_images/data_structures.png',*/
                            lectureType: 'Lecture',
                          ),
                        ],
                      ),
                    ),*/
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
  // Widget build(BuildContext context) {
  //   String docId = FirebaseAuth.instance.currentUser?.uid ??'';
  //
  //   return FutureBuilder<DocumentSnapshot>(
  //     //Fetching data from the documentId specified of the student
  //     future: FirebaseFirestore.instance.collection('teachers').doc(docId).get(),
  //     builder:
  //         (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
  //
  //
  //       //Error Handling conditions
  //       if (snapshot.hasError) {
  //         return Center(child: AlertDialog(title: Text("Something went wrong")));
  //       }
  //
  //       if (snapshot.hasData && !snapshot.data!.exists) {
  //         return Center(child: AlertDialog(title: Text("Document does not exist")));
  //       }
  //
  //       //Data is output to the user
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         Map<String, dynamic>? data = snapshot.data!.data() as Map<String, dynamic>? ??{};
  //         return Scaffold(
  //           backgroundColor: Colors.grey[300],
  //
  //           body: SingleChildScrollView(
  //             child: SafeArea(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   //appbar
  //                   Padding(padding: EdgeInsets.symmetric(horizontal: 8),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children:  [
  //                             SizedBox(height: 8),
  //
  //                             Text(
  //                                 'Hello,',
  //                                 style: GoogleFonts.abel(
  //                                   textStyle: TextStyle(
  //                                     fontWeight: FontWeight.bold,
  //                                     fontSize: 24,
  //                                   ),
  //                                 )
  //                             ),
  //                             SizedBox(height: 5,),
  //
  //                             //name
  //                             Text(data['name'],
  //                                 style: GoogleFonts.abel(
  //                                   textStyle: TextStyle(
  //                                     fontWeight: FontWeight.bold,
  //                                     fontSize: 24,
  //                                   ),
  //                                 )
  //                             )
  //                           ],
  //                         ),
  //                         GestureDetector(
  //                           onTap: (){ Navigator.push(context,
  //                             MaterialPageRoute(builder: (context) => ProfileScreen()),);
  //                           },
  //                           child: Container(
  //
  //                             padding: EdgeInsets.all(12),
  //                             child: Icon(Icons.person,
  //                               size: 30,
  //                             ),
  //                             decoration: BoxDecoration(
  //                                 color: Colors.deepPurple[100],
  //                                 borderRadius: BorderRadius.circular(12)
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //
  //                   SizedBox(height: 25,),
  //
  //                   //card --> Incoming Events
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                     child: Container(
  //                         padding: EdgeInsets.symmetric(vertical: 20.0),
  //                         decoration: BoxDecoration(color: Colors.pink[100],
  //                           borderRadius: BorderRadius.circular(20),
  //                         ),
  //                         child: Row(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             //animation or picture
  //                             Container(
  //                               height: 125,
  //                               width: 125,
  //                               child: Lottie.network
  //                                 ('https://assets1.lottiefiles.com/packages/lf20_p9cnyffr.json',
  //                                   fit: BoxFit.cover,
  //                                   alignment: Alignment.centerLeft
  //                               ),
  //                             ),
  //                             SizedBox(width: 20,),
  //
  //                             //What's next in the schedule
  //                             Expanded(
  //                               child: Column(
  //
  //                                 children: [
  //                                   Text("Next Event",
  //                                     style:  GoogleFonts.abel(
  //                                       textStyle: const TextStyle(
  //                                           fontWeight: FontWeight.bold,
  //                                           fontSize: 20.0
  //                                       ),
  //                                     ),),
  //                                   SizedBox(height: 12,),
  //                                   Row(
  //                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                                     children: const [
  //                                       MyBullets(text: "LT201",),
  //                                       SizedBox(width: 20,),
  //                                       MyBullets(text: "Lecture",),
  //                                       SizedBox(width: 20,),
  //                                       MyBullets(text: 'OS',)
  //                                     ],
  //                                   ),
  //                                   SizedBox(height: 12,),
  //                                   Container(
  //                                     padding: EdgeInsets.all(12.0),
  //                                     decoration: BoxDecoration(
  //                                         color: Colors.deepPurple[300],
  //                                         borderRadius: BorderRadius.circular(12)
  //                                     ),
  //                                     child: Center(
  //                                       child: Text('Get Started',
  //                                           style :  GoogleFonts.abel(
  //                                             textStyle: TextStyle(
  //                                               fontWeight: FontWeight.bold,
  //                                               fontSize: 16,
  //                                             ),
  //                                           )),
  //                                     ),
  //                                   )
  //                                 ],
  //                               ),
  //                             )
  //
  //
  //                           ],)
  //                     ),
  //                   ),
  //
  //                   //cards over and take attendance bar starts
  //                   //
  //                   //
  //                   const SizedBox(height: 20,),
  //
  //
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                     child: GestureDetector(
  //                       onTap: (){ Navigator.push(context,
  //                         MaterialPageRoute(builder: (context) => AttendanceScreen()),);
  //                       },
  //                       child: Container(
  //                         padding: EdgeInsets.all(12),
  //                         height: 75,
  //                         width: 500,
  //
  //                         decoration: BoxDecoration(
  //                             color: Colors.deepPurple[100],
  //                             borderRadius: BorderRadius.circular(12)
  //
  //                         ),
  //                         child:Center(
  //                           child: Row(
  //                             children: [
  //                               Image(
  //                                 image: AssetImage("lib/assets/icons/immigration.png"),
  //                                 height: 50,
  //                                 width: 40,
  //                               ),
  //                               Text(
  //                                   '    Take Attendance for the ongoing class',
  //                                   style :  GoogleFonts.abel(
  //                                     textStyle: TextStyle(
  //                                       fontWeight: FontWeight.bold,
  //                                       fontSize: 16,
  //                                     ),
  //                                   )
  //
  //                               ),
  //
  //
  //
  //
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //
  //                   ////
  //
  //                   SizedBox(height: 20,),
  //
  //                   //List view
  //                   Container(
  //                     height: 90,
  //                     child: ListView(
  //                       scrollDirection: Axis.horizontal,
  //                       children: [
  //                         CategoryCard(text: 'Assignments', image: "lib/assets/icons/education.png",
  //                           onTap:(){ Navigator.push(context,
  //                             MaterialPageRoute(builder: (context) => const CommunityPage()),);
  //                           },
  //                         ),
  //                         CategoryCard(text: 'Marks', image: "lib/assets/icons/grades.png",onTap: (){}),
  //                         CategoryCard(text: 'Announcements', image: "lib/assets/icons/marketing.png",onTap: (){}),
  //                         CategoryCard(text: 'Study Material', image: "lib/assets/icons/academic.png",onTap: (){}),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(height: 25,),
  //
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: const [
  //                         Text('Your Classes',
  //                           style: TextStyle(
  //                             fontSize: 20,
  //                             fontWeight: FontWeight.bold,
  //
  //                           ),),
  //                         Text('See all',
  //                           style: TextStyle(
  //                               color: Colors.grey
  //                           ),),
  //                       ],
  //                     ),
  //                   ),
  //
  //                   SizedBox(height: 25.0,),
  //
  //                   Container(
  //
  //                     height: 225,
  //                     child: ListView(
  //                       scrollDirection: Axis.horizontal,
  //                       children: const [
  //                         SubjectTile(text: "Operating Systems",imagePath: 'lib/assets/subject_images/data_structures.png',lectureType: 'Lecture',),
  //                         SubjectTile(text: "Data Structures",imagePath: 'lib/assets/subject_images/hierarchy-structure.png',lectureType: 'Tutorial',),
  //                         SubjectTile(text: "Databases",imagePath: 'lib/assets/subject_images/cloud_database.png',lectureType: 'Lab',),
  //                         SubjectTile(text: "Operating Systems",imagePath: 'lib/assets/subject_images/data_structures.png',lectureType: 'Lecture',),
  //
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(height: 50,)
  //
  //                 ],
  //               ),
  //             ),
  //
  //           ),
  //
  //
  //           bottomNavigationBar: Container(
  //             // color: Colors.pink[200],
  //             child: ClipRRect(
  //               borderRadius: const BorderRadius.only(topRight: Radius.circular(30.0 ),topLeft:Radius.circular(30.0) ),
  //               child: BottomNavigationBar(
  //                 type: BottomNavigationBarType.fixed,
  //
  //                 items: const [
  //                   BottomNavigationBarItem(
  //                     icon: Icon(Icons.dashboard,
  //                       size: 30.0,
  //                       color: Colors.grey,
  //                     ),
  //                     label: 'Dashboard',
  //                   ),
  //                   BottomNavigationBarItem(
  //                     icon: Icon(Icons.mail,
  //                       size: 30.0,
  //                       color: Colors.grey,
  //                     ),
  //                     label: 'Inbox',
  //                   ),
  //                   BottomNavigationBarItem(
  //                     icon: Icon(Icons.people,
  //                       size: 30.0,
  //                       color: Colors.grey,
  //
  //                     ),
  //                     label: 'Community',
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //
  //
  //         );
  //       }
  //
  //       return Scaffold(
  //         backgroundColor: Colors.grey[300],
  //
  //         body: SingleChildScrollView(
  //           child: SafeArea(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 //appbar
  //                 Padding(padding: EdgeInsets.symmetric(horizontal: 8),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children:  [
  //                           SizedBox(height: 8),
  //
  //                           Text(
  //                               'Hello,',
  //                               style: GoogleFonts.abel(
  //                                 textStyle: TextStyle(
  //                                   fontWeight: FontWeight.bold,
  //                                   fontSize: 24,
  //                                 ),
  //                               )
  //                           ),
  //                           SizedBox(height: 5,),
  //
  //                           //name
  //                           Text('Shashwat sai vyas',
  //                               style: GoogleFonts.abel(
  //                                 textStyle: TextStyle(
  //                                   fontWeight: FontWeight.bold,
  //                                   fontSize: 24,
  //                                 ),
  //                               )
  //                           )
  //                         ],
  //                       ),
  //                       GestureDetector(
  //                         onTap: (){ Navigator.push(context,
  //                           MaterialPageRoute(builder: (context) => ProfileScreen()),);
  //                         },
  //                         child: Container(
  //
  //                           padding: EdgeInsets.all(12),
  //                           child: Icon(Icons.person,
  //                             size: 30,
  //                           ),
  //                           decoration: BoxDecoration(
  //                               color: Colors.deepPurple[100],
  //                               borderRadius: BorderRadius.circular(12)
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //
  //                 SizedBox(height: 25,),
  //
  //                 //card --> Incoming Events
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                   child: Container(
  //                       padding: EdgeInsets.symmetric(vertical: 20.0),
  //                       decoration: BoxDecoration(color: Colors.pink[100],
  //                         borderRadius: BorderRadius.circular(20),
  //                       ),
  //                       child: Row(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           //animation or picture
  //                           Container(
  //                             height: 125,
  //                             width: 125,
  //                             child: Lottie.network
  //                               ('https://assets1.lottiefiles.com/packages/lf20_p9cnyffr.json',
  //                                 fit: BoxFit.cover,
  //                                 alignment: Alignment.centerLeft
  //                             ),
  //                           ),
  //                           SizedBox(width: 20,),
  //
  //                           //What's next in the schedule
  //                           Expanded(
  //                             child: Column(
  //
  //                               children: [
  //                                 Text("Next Event",
  //                                   style:  GoogleFonts.abel(
  //                                     textStyle: const TextStyle(
  //                                         fontWeight: FontWeight.bold,
  //                                         fontSize: 20.0
  //                                     ),
  //                                   ),),
  //                                 SizedBox(height: 12,),
  //                                 Row(
  //                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                                   children: const [
  //                                     MyBullets(text: "LT201",),
  //                                     SizedBox(width: 20,),
  //                                     MyBullets(text: "Lecture",),
  //                                     SizedBox(width: 20,),
  //                                     MyBullets(text: 'OS',)
  //                                   ],
  //                                 ),
  //                                 SizedBox(height: 12,),
  //                                 Container(
  //                                   padding: EdgeInsets.all(12.0),
  //                                   decoration: BoxDecoration(
  //                                       color: Colors.deepPurple[300],
  //                                       borderRadius: BorderRadius.circular(12)
  //                                   ),
  //                                   child: Center(
  //                                     child: Text('Get Started',
  //                                         style :  GoogleFonts.abel(
  //                                           textStyle: TextStyle(
  //                                             fontWeight: FontWeight.bold,
  //                                             fontSize: 16,
  //                                           ),
  //                                         )),
  //                                   ),
  //                                 )
  //                               ],
  //                             ),
  //                           )
  //
  //
  //                         ],)
  //                   ),
  //                 ),
  //
  //                 //cards over and take attendance bar starts
  //                 //
  //                 //
  //                 const SizedBox(height: 20,),
  //
  //
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                   child: GestureDetector(
  //                     onTap: (){ Navigator.push(context,
  //                       MaterialPageRoute(builder: (context) => AttendanceScreen()),);
  //                     },
  //                     child: Container(
  //                       padding: EdgeInsets.all(12),
  //                       height: 75,
  //                       width: 500,
  //
  //                       decoration: BoxDecoration(
  //                           color: Colors.deepPurple[100],
  //                           borderRadius: BorderRadius.circular(12)
  //
  //                       ),
  //                       child:Center(
  //                         child: Row(
  //                           children: [
  //                             Image(
  //                               image: AssetImage("lib/assets/icons/immigration.png"),
  //                               height: 50,
  //                               width: 40,
  //                             ),
  //                             Text(
  //                                 '    Take Attendance for the ongoing class',
  //                                 style :  GoogleFonts.abel(
  //                                   textStyle: TextStyle(
  //                                     fontWeight: FontWeight.bold,
  //                                     fontSize: 16,
  //                                   ),
  //                                 )
  //
  //                             ),
  //
  //
  //
  //
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //
  //                 ////
  //
  //                 SizedBox(height: 20,),
  //
  //                 //List view
  //                 Container(
  //                   height: 90,
  //                   child: ListView(
  //                     scrollDirection: Axis.horizontal,
  //                     children: [
  //                       CategoryCard(text: 'Assignments', image: "lib/assets/icons/education.png",
  //                         onTap:(){ Navigator.push(context,
  //                           MaterialPageRoute(builder: (context) => const CommunityPage()),);
  //                         },
  //                       ),
  //                       CategoryCard(text: 'Marks', image: "lib/assets/icons/grades.png",onTap: (){}),
  //                       CategoryCard(text: 'Announcements', image: "lib/assets/icons/marketing.png",onTap: (){}),
  //                       CategoryCard(text: 'Study Material', image: "lib/assets/icons/academic.png",onTap: (){}),
  //                     ],
  //                   ),
  //                 ),
  //                 SizedBox(height: 25,),
  //
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: const [
  //                       Text('Your Classes',
  //                         style: TextStyle(
  //                           fontSize: 20,
  //                           fontWeight: FontWeight.bold,
  //
  //                         ),),
  //                       Text('See all',
  //                         style: TextStyle(
  //                             color: Colors.grey
  //                         ),),
  //                     ],
  //                   ),
  //                 ),
  //
  //                 SizedBox(height: 25.0,),
  //
  //                 Container(
  //
  //                   height: 225,
  //                   child: ListView(
  //                     scrollDirection: Axis.horizontal,
  //                     children: const [
  //                       SubjectTile(text: "Operating Systems",imagePath: 'lib/assets/subject_images/data_structures.png',lectureType: 'Lecture',),
  //                       SubjectTile(text: "Data Structures",imagePath: 'lib/assets/subject_images/hierarchy-structure.png',lectureType: 'Tutorial',),
  //                       SubjectTile(text: "Databases",imagePath: 'lib/assets/subject_images/cloud_database.png',lectureType: 'Lab',),
  //                       SubjectTile(text: "Operating Systems",imagePath: 'lib/assets/subject_images/data_structures.png',lectureType: 'Lecture',),
  //
  //                     ],
  //                   ),
  //                 ),
  //                 SizedBox(height: 50,)
  //
  //               ],
  //             ),
  //           ),
  //
  //         ),
  //
  //
  //         bottomNavigationBar: Container(
  //           // color: Colors.pink[200],
  //           child: ClipRRect(
  //             borderRadius: const BorderRadius.only(topRight: Radius.circular(30.0 ),topLeft:Radius.circular(30.0) ),
  //             child: BottomNavigationBar(
  //               type: BottomNavigationBarType.fixed,
  //
  //               items: const [
  //                 BottomNavigationBarItem(
  //                   icon: Icon(Icons.dashboard,
  //                     size: 30.0,
  //                     color: Colors.grey,
  //                   ),
  //                   label: 'Dashboard',
  //                 ),
  //                 BottomNavigationBarItem(
  //                   icon: Icon(Icons.mail,
  //                     size: 30.0,
  //                     color: Colors.grey,
  //                   ),
  //                   label: 'Inbox',
  //                 ),
  //                 BottomNavigationBarItem(
  //                   icon: Icon(Icons.people,
  //                     size: 30.0,
  //                     color: Colors.grey,
  //
  //                   ),
  //                   label: 'Community',
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //
  //
  //       );
  //     },
  //   );
  // }
}
