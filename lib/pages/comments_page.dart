import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teachers_app/models/comment_wall_post..dart';


class CommentPage extends StatefulWidget {
  const CommentPage({Key? key}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {

  final currentUser = FirebaseAuth.instance.currentUser!;

  //Comment text controller
  final commentTextController = TextEditingController();

  void postMessage(){
    if(commentTextController.text.isNotEmpty){

      //store in firebase
      FirebaseFirestore.instance.collection('User_Posts').add({
        'UserEmail': currentUser.email,
        'Message': commentTextController.text,
        'TimeStamp': Timestamp.now(),
        'Likes': [],
      });
      
    }

    //clear the text field
    setState(() {
      commentTextController.clear();
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Column(
          children:  [
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('User_Posts')
                      .orderBy(
                      'TimeStamp',
                          descending: false

                  )
                  .snapshots(),
                  builder: (context,snapshot){
                      if(snapshot.hasData){
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context,index){

                            final post = snapshot.data!.docs[index];
                            return WallPost(
                                message: post['Message'],
                                user: post['UserEmail'],
                                postId: post.id,
                                //Retrieving the list of the users from the firebase
                                //and giving it to the wallpost of that post.
                                likes: List<String>.from(post['Likes'] ?? []),
                            );
                        }
                        );
                      }else if(snapshot.hasError){
                        return Center(
                          child: Text(
                            'Error:'+ snapshot.error.toString()
                          ),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),

                      );
                  }

                ),
            ),
            //the wall
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87)
                        ),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Write on the wall',
                      ),
                      controller: commentTextController,

                      obscureText: false,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: postMessage,
                    icon: const Icon(Icons.arrow_circle_up)),

              ],
            ),

            //post Message

            SizedBox(height: 10,),
            Center(
              child: Text('Logged in as :  ${currentUser.email}',
              style: TextStyle(
                color: Colors.grey

              ),),
            ),
            SizedBox(height: 50.0,),

          ],


        ),
      ),

    );
  }
}
