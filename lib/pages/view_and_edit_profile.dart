import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teachers_app/models/MyButton.dart';
import 'package:teachers_app/models/myListTile.dart';
import 'package:teachers_app/models/my_textfield.dart';
import 'package:teachers_app/models/text_design.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {





  var nameController = TextEditingController();

  var branchController = TextEditingController();

  var hometownController = TextEditingController();

   String currentName = '';
   String currentBranch = '';
   String currentHometown = '';



  @override
  Widget build(BuildContext context) {
     String docId = FirebaseAuth.instance.currentUser?.uid ??'';

    return FutureBuilder<DocumentSnapshot>(
      //Fetching data from the documentId specified of the student
      future: FirebaseFirestore.instance.collection('users').doc(docId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {


        //Error Handling conditions
        if (snapshot.hasError) {
          return Center(child: AlertDialog(title: Text("Something went wrong")));
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Center(child: AlertDialog(title: Text("Document does not exist")));
        }

        //Data is output to the user
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black54,
                elevation: 0.0,
                centerTitle: true,
                title: Text(
                  'Your Profile',
                  style: GoogleFonts.oswald(),
                ),
                leading: IconButton(onPressed: (){Navigator.pop(context);},
                  icon: Icon(Icons.arrow_back_ios_new),),

              ),
                backgroundColor: Colors.grey[300],

                body: Column(
                  children: [

                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          label: Text('Name'),
                          prefixIcon: const Icon(Icons.person),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black87)
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: '${data['name']}'

                        ),
                      ),
                    ),


                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          label: Text('Branch'),
                          prefixIcon: const Icon(Icons.school),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black87)
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: '${data['branch']}'

                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          label: const Text('Hometown'),
                          prefixIcon: const Icon(Icons.place),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black87)
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: '${data['hometown']}'


                        ),
                      ),
                    )
                  ],
                )),
          );
        }

        return Scaffold(
          backgroundColor: Colors.grey[300],
          body: const Center(
              child: CircularProgressIndicator()
          ),
        );
      },
    );
  }
  }
// SizedBox(height: 20),
// MyListTile(
// icon: Icons.near_me,
// text: "Full Name: ${data['name']}",
// endIcon: Icons.accessibility_new_outlined
// ),
//
//
// SizedBox(height: 20),
// MyListTile(
// icon: Icons.near_me,
// text: "Branch: ${data['branch']}",
// endIcon: Icons.accessibility_new_outlined
// ),
//
// SizedBox(height: 20),
// MyListTile(
// icon: Icons.near_me,
// text: "Hometown: ${data['hometown']}",
// endIcon: Icons.accessibility_new_outlined
// ),
//
// Divider(thickness: 1.0,),
