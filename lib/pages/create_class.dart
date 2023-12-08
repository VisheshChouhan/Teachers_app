import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teachers_app/models/my_textfield.dart';

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
        courseNameController.clear();
        courseCodeController.clear();

        Navigator.pop(context);
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

