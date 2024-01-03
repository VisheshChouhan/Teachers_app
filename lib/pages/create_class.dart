import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teachers_app/models/my_textfield.dart';
import 'package:teachers_app/pages/NewCourse.dart';

class CreateClass extends StatefulWidget {
  const CreateClass({super.key});


  @override
  State<CreateClass> createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass> {

  TextEditingController courseCodeController = TextEditingController();
  TextEditingController courseNameController = TextEditingController();

  void createNewCourse()
  {
    checkExistingCourse();





  }

  Future checkExistingCourse() async{
    var a = await FirebaseFirestore.instance.collection('Courses').doc(courseCodeController.text.toString()).get();
    if(a.exists){
      print('Exists');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Course Already exist with given Code.\nUse a different Code."),
      ));
      return a;
    }
    if(!a.exists){
      print('Not exists');
      String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? "";
      String courseCode = courseCodeController.text.toString();
      String courseName = courseNameController.text.toString();

      if(courseNameController.text.isNotEmpty && courseCodeController.text.isNotEmpty )
      {



        FirebaseFirestore.instance.
        collection("teachers").doc(currentUserId).collection("CreatedCourses").doc(courseCode)
            .set({
          "courseCode" : courseCode,
          "courseName" : courseName
        });



        FirebaseFirestore.instance.collection("Courses").doc(courseCode)
            .set({
          "courseCode" : courseCode,
          "courseName" : courseName
        });



        DatabaseReference ref = FirebaseDatabase.instance.ref("Courses");
        
        NewCourse newCourse = new NewCourse(
            "helloooooooooooooooooooooooooooooooooooooo786348273", courseCode, "0", "0", "0");

        await ref.child(courseCode).set({
          "password": "helloooooooooooooooooooooooooooooooooooooo786348273",
          "courseCode": courseCode,
          "enterStageTwo": "0",
          "exitStageTwo": "0",
          "totalClassesTaken": "0"


        });



        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Course Created Succesfully"),
        ));

        courseNameController.clear();
        courseCodeController.clear();





        Navigator.pop(context);
      }
      return null;
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create New Class",
              style: TextStyle(fontSize: 30, fontFamily: "Arial"),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                controller: courseCodeController,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter a Unique Class Code"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                controller: courseNameController,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter Class Name"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Back",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                ElevatedButton(
                  onPressed: createNewCourse,
                  child: const Text(
                    "Create",
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}

