// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:friends_nashta/components/MyButton.dart';
// import 'package:friends_nashta/components/my_textfield.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class HomePage extends StatefulWidget {
//   HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//
//
//
//
//   final user = FirebaseAuth.instance.currentUser!;
//
//   void signUserOut() {
//     FirebaseAuth.instance.signOut();
//   }
//
//   //making the text controllers over here
//   final nameController = TextEditingController();
//
//   final branchController = TextEditingController();
//
//   final hometownController = TextEditingController();
//
//   // Future addUserDetails(String name, String branch, String hometown) async {
//     @override
//     Widget build(BuildContext context) {
//
//       CollectionReference users = FirebaseFirestore.instance.collection('users');
//       Future addUserDetails(String name, String branch, String hometown)async {
//         // Call the user's CollectionReference to add a new user
//         return await users
//             .add({
//           'name': name,
//           'branch': branch,
//           'hometown ': hometown
//         });
//       }
//
//       // void onTap() {
//       //   addUserDetails(nameController.text, branchController.text,
//       //       hometownController.text);
//       // }
//
//       return Scaffold(
//         backgroundColor: Colors.grey[300],
//
//
//         body: Column(
//           children: [
//             SizedBox(height: 20),
//
//             MyTextField(controller: nameController,
//                 hintText: 'name',
//                 obscureText: false),
//
//             SizedBox(height: 20),
//
//             MyTextField(controller: branchController,
//                 hintText: 'branch',
//                 obscureText: false),
//
//             SizedBox(height: 20),
//
//             MyTextField(controller: hometownController,
//                 hintText: 'hometown',
//                 obscureText: false),
//
//             SizedBox(height: 20),
//
//             MyButton(onTap: onTap, text: 'Enter')
//           ],
//         ),
//         appBar: AppBar(
//           actions: [
//             Center(child: Text(
//               user.email!,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//               ),
//
//             )),
//             IconButton(onPressed: signUserOut, icon: Icon(Icons.logout),
//             )
//           ],
//         ),
//
//       );
//     }
// }
