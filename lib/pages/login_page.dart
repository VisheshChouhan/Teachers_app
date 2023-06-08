import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teachers_app/models/MyButton.dart';
import 'package:teachers_app/models/my_textfield.dart';
import 'package:teachers_app/models/squareTile.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({
    super.key,
    required this.onTap
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async {

    // showing load circle
    showDialog(
      context: context,
      builder: (context){
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try sign in
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.toString().trim(),
        password: passwordController.text.toString().trim(),
      );
      //pop the loading circle
      Navigator.pop(context);

    }on FirebaseAuthException catch(e){
      //Show error message
      showErrorMessage(e.code);
    }
  }

  //Error Message to user
  void showErrorMessage(String message){
    showDialog(context: context,
      builder: (context) {
        return AlertDialog(title: Text(message),);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children:  [
                const SizedBox(height: 50.0,),


                const Icon(
                  Icons.lock,
                  size: 100,
                ),


                const SizedBox(height: 50.0,),


                Text('Welcome back,you\'ve been missed',
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16.0)
                ),


                const SizedBox(height: 25.0,),

                  //email textfield

                  MyTextField(
                   controller: emailController,
                   hintText: "User-Email",
                   obscureText: false,
                 ),

                const SizedBox(height: 10.0,),

                MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextButton(onPressed: (){},
                          child: const Text(
                            'Forget Password',
                          )),
                    ),
                  ],
                ),

                const SizedBox(height: 10.0,),

                MyButton(
                  onTap: signUserIn,
                  text: 'Sign In',
                ),

                const SizedBox(height: 25.0,),

                Row(
                  children: [
                    Expanded(child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    )),

                    Text('Or Continue with'),

                    Expanded(child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    )),
                  ],
                ),

                const SizedBox(height: 25.0,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    //Google Button
                    SquareTile(imagePath: 'lib/assets/google.png'),

                    SizedBox(width: 25.0,),

                    //Apple Button
                    SquareTile(imagePath: 'lib/assets/apple.png',)
                  ],
                ),
                SizedBox(height: 25.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member?'),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text('Register Now',
                        style: TextStyle(
                          color: Colors.blue,
                      ),),
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
