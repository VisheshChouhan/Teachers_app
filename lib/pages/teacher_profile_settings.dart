import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teachers_app/pages/about_me_page.dart';
import 'package:teachers_app/models/myListTile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teachers_app/pages/loginOrRegisterPage.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  //The signout function
  void signUserOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => LoginOrRegisterPage()),
          (route) => false,);
  }
  //


  // String user_name = FirebaseAuth.instance.currentUser?.uid ??'default';
  //The above code has nothing to do.
  //Just a way to convert 'String?' to String.

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 15),
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 70,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset('lib/assets/teacher.jpg',
                        height: 400,
                        width: 400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                    user.email!,
                    style: GoogleFonts.oswald(
                        textStyle: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ))
                ),
                const SizedBox(height: 5),

                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){

                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(horizontal: 80,vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.pink[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:   Center(
                      child: Text(
                        'View Profile',
                        style: GoogleFonts.oswald(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          )

                        )
                        )
                      ),
                    ),
                  ),
                const Divider(
                  thickness: 1.0,
                ),
                SizedBox(height: 8),
                const MyListTile(
                  icon: Icons.settings,
                  text: 'Setting',
                  endIcon: Icons.forward,
                ),
                const MyListTile(
                  icon: Icons.schedule,
                  text: 'Schedule',
                  endIcon: Icons.forward,
                ),
                const MyListTile(
                  icon: Icons.message,
                  text: 'Inbox',
                  endIcon: Icons.forward,
                ),
                const MyListTile(
                  icon: Icons.note_add,
                  text: 'To-DO',
                  endIcon: Icons.forward,
                ),
                MyListTile(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfile()));},
                  icon: Icons.info,
                  text: 'About Us',
                  endIcon: Icons.forward,
                ),
                MyListTile(
                  onTap: signUserOut,
                  icon: Icons.logout,
                  text: 'Log Out',
                  endIcon: Icons.forward,
                ),
                SizedBox(height: 30,)
              ],

            ),
          ),
        ),
      ),
    );
  }
}


