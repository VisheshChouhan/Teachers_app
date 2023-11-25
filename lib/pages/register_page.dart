import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teachers_app/models/MyButton.dart';
import 'package:teachers_app/models/my_textfield.dart';
import 'package:teachers_app/models/squareTile.dart';
import 'package:teachers_app/pages/database.dart';
import 'package:teachers_app/pages/teacher_dashboard.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //all the controller information

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final nameController = TextEditingController();

  final hometownController = TextEditingController();

  late String teacherDepartment = "Department";

  ////////////////////////////////////////////////////////

  void signUserUp() async {
    // showing load circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // CollectionReference users = FirebaseFirestore.instance.collection('users');
    //
    // Future addUserDetails(String name, String branch, String hometown,String? uid)async {
    //   // Call the user's CollectionReference to add a new user
    //   return await users
    //       .add({
    //     'name': name,
    //     'branch': branch,
    //     'hometown ': hometown,
    //     'uid': uid,
    //   });
    // }

    //try sign in
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString(),
        );
        String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? "";
        DatabaseServices(uid: currentUserId).updateUserDetails(
            nameController.text,
            teacherDepartment,
            hometownController.text);
      } else {
        //show error message that the password does not match
        Navigator.pop(context);
        showErrorMessage('Password does not match');
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      //Show error message
      showErrorMessage(e.code);
    }
  }

  //Error Message to user
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //String teacherDepartment;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50.0,
                ),

                const Icon(
                  Icons.lock,
                  size: 50,
                ),

                const SizedBox(
                  height: 25.0,
                ),

                Text('Welcome to our services',
                    style: TextStyle(color: Colors.grey[700], fontSize: 16.0)),

                const SizedBox(
                  height: 25.0,
                ),

                //email textfield

                MyTextField(
                  controller: nameController,
                  hintText: "Name",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10.0,
                ),

                //email textfield




                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5),),

                    child: DropdownButton(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      hint: teacherDepartment == "Department"
                          ? const Text('Department',
                        style: TextStyle(fontSize: 17),
                      )
                          : Text(
                              teacherDepartment,
                              style: TextStyle(color: Colors.black),
                            ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: TextStyle(color: Colors.black),
                      items: ["Bio Medical Engineering",
                        "Computer Science and Engineering",
                        "Civil Engineering",
                        "Electronics and Telecommunication Engineering",
                        "Electronics and Instrumentation Engineering",
                        "Electrical Engineering",
                        "Information Technology Engineering",
                        "Industrial and Production Engineering",
                        "Mechanical Engineering",

                      ].map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            teacherDepartment = val!;
                          },
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10.0,
                ),

                //email textfield

                MyTextField(
                  controller: hometownController,
                  hintText: "Contact Number",
                  obscureText: false,
                ),

                const SizedBox(
                  height: 10.0,
                ),

                MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),

                const SizedBox(
                  height: 10.0,
                ),

                MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),

                const SizedBox(
                  height: 10.0,
                ),

                MyTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  obscureText: true,
                ),

                const SizedBox(
                  height: 25.0,
                ),

                MyButton(
                  onTap: signUserUp,
                  text: "Register Now",
                ),

                const SizedBox(
                  height: 25.0,
                ),

                Row(
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    )),
                    Text('Or Continue with'),
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    )),
                  ],
                ),

                const SizedBox(
                  height: 25.0,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    //Google Button
                    SquareTile(imagePath: 'lib/assets/google.png'),

                    SizedBox(
                      width: 25.0,
                    ),

                    //Apple Button
                    SquareTile(
                      imagePath: 'lib/assets/apple.png',
                    )
                  ],
                ),
                SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login Here',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
