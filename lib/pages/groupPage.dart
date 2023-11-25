import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teachers_app/pages/ChatPage.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
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
            backgroundColor: Colors.white,
            body: SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Groups",
                          style: GoogleFonts.abel(
                              textStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 34,
                          )),
                        ),
                        const ElevatedButton(
                          onPressed: null,
                          style: ButtonStyle(
                            elevation: MaterialStatePropertyAll(20),
                            backgroundColor: MaterialStatePropertyAll(
                                Colors.lightBlueAccent),
                          ),
                          child: Text(
                            "Create Group",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    color: Colors.blueGrey,
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(data["department"])));
                      },

                      style: const ButtonStyle(),
                      child: Row(children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.group,
                          size: 30,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          data["department"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        )


                      ]),
                    ),
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Divider(
                    color: Colors.blueGrey,
                    thickness: 2,
                  ),
                ),



            ],
            )
                ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
