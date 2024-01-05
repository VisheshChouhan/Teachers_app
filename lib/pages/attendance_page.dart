import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';

class AttendanceScreen extends StatefulWidget {
  final String courseCode;
  const AttendanceScreen({super.key, required this.courseCode});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

//Making the function that will read the code data from the realtime database

class _AttendanceScreenState extends State<AttendanceScreen> {
  late DatabaseReference _dbref;
  late FirebaseFirestore _fdref;

  String str = "Slide to Start Attendance tracking";
  String textFieldPreviousEntry = "";

  int counter = 0;
  int studentPresent = 0;

  bool sliderEnabled = true;
  var sliderEnableColor = Colors.deepPurple[300];

  int countvalue = 0;
  @override
  void initState() {
    super.initState();
    _dbref = FirebaseDatabase.instance.ref();
    _fdref = FirebaseFirestore.instance;

    //We are fetching the totalclasses into the variable countvalue
    _dbref
        .child('Courses')
        .child(widget.courseCode)
        .child('totalClassesTaken')
        .onValue
        .listen((event) {
      setState(() {
        countvalue = int.parse(event.snapshot.value.toString());
      });
    });

    //We are fetching the passcode
    _dbref
        .child('Courses')
        .child(widget.courseCode)
        .child('password')
        .onValue
        .listen((event) {
      setState(() {
        textFieldPreviousEntry = event.snapshot.value.toString();
      });
    });

    //now we will change  the enterStage to 0 from 1
    _dbref
        .child("Courses")
        .child(widget.courseCode)
        .update({"enterStageTwo": "1"});

    //initializing exitStage to be 0 only
    _dbref
        .child("Courses")
        .child(widget.courseCode)
        .update({"exitStageTwo": "0"});

    //intializing the password to its default value
    _dbref.child("Courses").child(widget.courseCode).update(
        {"password": "helloooooooooooooooooooooooooooooooooooooo786348273"});
  }

  updateEnterStageTwo() {
    _dbref
        .child("Courses")
        .child(widget.courseCode)
        .update({"enterStageTwo": "0"});
  }

  updateExitStageTwo() {
    _dbref
        .child("Courses")
        .child(widget.courseCode)
        .update({"exitStageTwo": "1"});
    String time = DateFormat('MMMM dd, yyyy').format(DateTime.now());
    _fdref.collection("Courses").doc(widget.courseCode).collection("Attendance").doc(time).set({"date":time});
  }

  var passCodeController = TextEditingController();

  //Updating the passcode data
  updateValue() {
    _dbref
        .child("Courses")
        .child(widget.courseCode)
        .update({"password": passCodeController.text});
  }

  String totalClasses = "";

  // _readdb_onechild(){
  //   _dbref.child('Courses').child('Operating Systems').child('totalClassesTaken')
  //       .once().then((DataSnapshot dataSnapshot){
  //        totalClasses = dataSnapshot.value.toString();
  //         );
  //   });
  // }

  updateValueTotalClasses() {
    countvalue++;
    _dbref
        .child("Courses")
        .child(widget.courseCode)
        .update({"totalClassesTaken": countvalue.toString()});
  }

  @override
  Widget build(BuildContext context) {
    String time = DateFormat('MMMM dd, yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Attendace Management',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
                const Text('Streamlined attendance tracking'),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      // DateTime.now().day.toString()+"/"+DateTime.now().month.toString()+"/"+
                      //     DateTime.now().year.toString(),
                      time,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                ),
                StreamBuilder(
                    stream: Stream.periodic(const Duration(seconds: 1)),
                    builder: (context, snapshot) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            DateFormat('hh:mm:ss a').format(DateTime.now()),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            )),
                      );
                    }),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: passCodeController,
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87)),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: "Enter Passcode",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  child: Builder(
                    builder: (context) {
                      final GlobalKey<SlideActionState> key = GlobalKey();
                      return SlideAction(
                        text: str,
                        textStyle: const TextStyle(
                            color: Colors.black54, fontSize: 15),
                        outerColor: Colors.white,
                        innerColor: sliderEnableColor,
                        key: key,
                        enabled: sliderEnabled,
                        onSubmit: () {
                          setState(() {
                            str = "Slide to close Attendance tracking";
                            counter += 1;
                            if (counter > 1) {
                              sliderEnabled = false;
                              str = "Attendance is closed.";
                              sliderEnableColor = Colors.grey;
                            }
                          });
                          if (textFieldPreviousEntry !=
                              passCodeController.text) {
                            updateValue();
                            updateEnterStageTwo();
                          } else if (counter <= 2) {
                            updateExitStageTwo();
                            updateValueTotalClasses();
                          }
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    color: Colors.deepPurple[200],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Present Student",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                         Text(
                          studentPresent.toString(),
                          style: const TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ],
                    )
                ),
                Container(
                    width: double.infinity,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    color: Colors.deepPurple[100],
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Student Name",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Text(
                          "Time",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    )
                ),
                Container(
                  color: Colors.white30,
                  height: 350,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Courses")
                          //.doc("CO34006")
                          .doc(widget.courseCode)
                          .collection("Attendance")
                          .doc(time)
                          .collection("present")
                          .orderBy('attendanceTime', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(


                              //dragStartBehavior: DragStartBehavior.down,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final post = snapshot.data!.docs[index];
                                studentPresent = index + 1 ;


                                return PresentStudentWidgetBox(post);
                                //Text("Abcfgafg");
                                /*Text(
                            post["message"],
                          )*/
                              });
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error:${snapshot.error}'),
                          );
                          print('Error:${snapshot.error}');
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
                const SizedBox(
                  height: 30,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Container PresentStudentWidgetBox(
      QueryDocumentSnapshot<Map<String, dynamic>> post) {



    return Container(
        width: double.infinity,
        padding:
        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        color: Colors.white30,
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              post["name"],
              style: const TextStyle(fontSize: 20, color: Colors.deepPurple),
            ),
            Text(
              post["attendanceTime"],
              style: const TextStyle(fontSize: 20, color: Colors.deepPurple),
            ),
          ],
        )
    );
  }
}
