import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:teachers_app/models/my_textfield.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

//Making the function that will read the code data from the realtime database



class _AttendanceScreenState extends State<AttendanceScreen> {
  late DatabaseReference _dbref;


  String str = "Slide to Start Attendance tracking";
  String textFieldPreviousEntry = "";



  int countvalue = 0;
  @override
  void initState(){
    super.initState();
    _dbref = FirebaseDatabase.instance.ref();


    //We are fetching the totalclasses into the variable countvalue
    _dbref.child('Courses').child('Operating Systems').child('totalClassesTaken')
    .onValue.listen((event) {
      setState(() {
        countvalue = int.parse(event.snapshot.value.toString());
      });

    });


    //We are fetching the passcode
    _dbref.child('Courses').child('Operating Systems').child('passwd')
        .onValue.listen((event) {
      setState(() {
        textFieldPreviousEntry = event.snapshot.value.toString();
      });

    });


    //now we will change  the enterStage to 0 from 1
      _dbref.child("Courses").child("Operating Systems").update({"enterStageTwo": "1"});


      //initializing exitStage to be 0 only
    _dbref.child("Courses").child("Operating Systems").update({"exitStageTwo": "0"});


    //intializing the password to its default value
    _dbref.child("Courses").child("Operating Systems").update(
        {"passwd": "helloooooooooooooooooooooooooooooooooooooo786348273"});



  }
  updateEnterStageTwo(){
    _dbref.child("Courses").child("Operating Systems").update({"enterStageTwo": "0"});
  }

  updateExitStageTwo(){
    _dbref.child("Courses").child("Operating Systems").update({"exitStageTwo": "1"});
  }

  var passCodeController = TextEditingController();

  //Updating the passcode data
  updateValue(){
    _dbref.child("Courses").child("Operating Systems").update({"passwd": passCodeController.text});
  }

  String totalClasses = "";


  // _readdb_onechild(){
  //   _dbref.child('Courses').child('Operating Systems').child('totalClassesTaken')
  //       .once().then((DataSnapshot dataSnapshot){
  //        totalClasses = dataSnapshot.value.toString();
  //         );
  //   });
  // }


  updateValueTotalClasses(){
    countvalue++;
    _dbref.child("Courses").child("Operating Systems").update({"totalClassesTaken": countvalue.toString()});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(

          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Text('Attendace Management',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold
                  ),),
                  Text('Streamlined attendance tracking'),
                  SizedBox(height: 40,),
                  Text("Today's Status",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    margin: EdgeInsets.only(top: 12,bottom: 32),
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                            offset: Offset(2,2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                  "Check In",
                                style: TextStyle(
                                  fontSize: 17
                                ),
                              ),
                              Text("09:30",
                                style: TextStyle(
                                    fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                  "Check Out",
                                style: TextStyle(
                                    fontSize: 17
                                ),
                              ),
                              Text("15:30",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        // DateTime.now().day.toString()+"/"+DateTime.now().month.toString()+"/"+
                        //     DateTime.now().year.toString(),
                      DateFormat('dd MMMM yyyy').format(DateTime.now()),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold

                        )
                    ),
                  ),
                  StreamBuilder(
                    stream: Stream.periodic(Duration(seconds: 1)),
                    builder: (context, snapshot) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        child:  Text(
                          DateFormat('hh:mm:ss a').format(DateTime.now()),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black54,

                          )
                        ),
                      );
                    }
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller: passCodeController,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black87)
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: "Enter Passcode",
                  ),
                  ),
                  SizedBox(height: 10,),

                  Container(
                    margin: EdgeInsets.only(top: 24),
                    child: Builder(builder: (context){
                      final GlobalKey<SlideActionState> key = GlobalKey();
                      return SlideAction(
                        text: str,
                        textStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 15
                        ),
                        outerColor: Colors.white,
                        innerColor: Colors.deepPurple[300],
                        key: key,
                        onSubmit: (){

                          setState(() {
                            str = "Slide to close Attendance tracking";
                          });
                          if(textFieldPreviousEntry != passCodeController.text){
                            updateValue();
                            updateEnterStageTwo();

                          }
                          else
                          {
                            updateExitStageTwo();
                            updateValueTotalClasses();
                          }
                        },
                      );
                    },
                    ),
                  ),









                ],
              ),
            ),
          ),
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(topRight: Radius.circular(20.0 ),topLeft:Radius.circular(20.0) ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard,
                  size: 30.0,
                  color: Colors.grey,
                ),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.mail,
                  size: 30.0,
                  color: Colors.grey,
                ),
                label: 'Inbox',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people,
                  size: 30.0,
                  color: Colors.grey,

                ),
                label: 'Community',
              ),
            ],
          ),
        ),
      ),

    );



  }
}
