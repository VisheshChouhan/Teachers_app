import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teachers_app/models/MyButton.dart';
import 'package:teachers_app/pages/NavigationBar.dart';
import 'package:teachers_app/pages/loginOrRegisterPage.dart';
import 'package:teachers_app/pages/login_page.dart';
import 'package:teachers_app/pages/teacher_dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Check whether the user is logged in or not
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginOrRegisterPage()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => CustomNavBar()),
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: SafeArea(
        child: Column(
          children:  [

            Container(

              height: 500,
                child: Image(
                  image: AssetImage("lib/assets/splash_screen_teacher.png"),
                  fit: BoxFit.cover,
                )),
            SizedBox(height: 20),
            Text("Acadnect",
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 10),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text("Streamline Your Classroom ",
                style: TextStyle(
                  fontSize: 15.0

                )

                ),
            ),
            Text("The App that Helps You Stay Ahead of Your Tasks"),

            SizedBox(height: 30),
            MyButton(onTap: (){
              Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => CustomNavBar()),);
            }
                , text: "Let's Go")
          ],
        ),
      ),

    );
  }
}
