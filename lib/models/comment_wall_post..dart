

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teachers_app/liked_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teachers_app/models/helper_method.dart';
import 'package:teachers_app/models/reply_bar.dart';
import 'package:teachers_app/models/reply_button.dart';

class WallPost extends StatefulWidget {
  final String message ;
  final String user;
  final String postId;
  final List<String> likes;
  const WallPost({
    super.key,
    required this.message,
    required this.user,
    required this.postId,
    required this.likes,
});

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {

  //Reply Controller
  final replyController = TextEditingController();


  //user
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;


  @override
  void initState(){
    super.initState();

    //Here Widget refers to the wallpost
    //i.e. we are accessing the property likes of wallpost
    //which was passed when it was called.
    // As we are using a stateful widget here we cannot directly access the
    // properties using 'likes' directly but with 'widget.likes'
    isLiked = widget.likes.contains(currentUser.email);


  }

  //toggle like
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    DocumentReference postRef =  FirebaseFirestore.instance.collection('User_Posts')
        .doc(widget.postId);

    if (isLiked){
      //If the post is liked , add user's email to the 'Likes' field


      // arrayUnion and the arrayRemove : the terms arrayUnion and arrayRemove are
      // typically associated with the Firestore database and they are
      // used in update operations on Array fields within a document.

      //arrayUnion: It is used to add elements to an array field.
      // When you use arrayUnion, you specify one or more elements that you
      // want to add to the array. If the array field already exists,
      // the specified elements will be appended to it.
      // If the array field doesn't exist, it will be created with the specified
      //  elements.


      postRef.update(
        {
          'Likes' : FieldValue.arrayUnion([currentUser.email.toString()])
        }

      );
    }
    else{
      //If the post is now unliked , remove the user's email to the 'Likes' field
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email.toString()])
      });

    }
  }
  int numberOfComments = 0;
  void getTheNumberOfComments(){
        setState(() async {
          numberOfComments = await FirebaseFirestore.instance.collection('User_Posts')
              .doc(widget.postId).collection('Replies').snapshots().length;
        });
        print('/////////////////////////////////////////////////////////////////');
        print('/////////////////////////////////////////////////////////////////');
        print('/////////////////////////////////////////////////////////////////');
        print(numberOfComments);

  }



  //Creating a method to make a reply box
  void addReply(String CommentText){
    FirebaseFirestore.instance.collection('User_Posts')
        .doc(widget.postId)
        .collection('Replies')
        .add
      ({
      'ReplyText' : CommentText,
      'RepliedBy' : currentUser.email,
      'ReplyTime' : Timestamp.now(),
      });
  }


  void showReplyBox(){
    showDialog(context: context,
        builder:(context) => AlertDialog(
          title: Text("Add Reply"),
          content: TextField(
            controller: replyController,
            decoration: const InputDecoration(
              hintText: "Write the reply here"
            ),
          ),
          actions: [
            //cancel button
            TextButton(onPressed:(){
              Navigator.pop(context);

              //clearing the text box
              replyController.clear();
            },
                child: Text('Cancel')),

            //Post Button
            TextButton(onPressed:(){
              addReply(replyController.text.toString());

              //Clearing the text box
              replyController.clear();

              //poping the alert box
              Navigator.pop(context);
              
              },
                child: Text('Post')),


            
          ],


        ) );
  }


  //Showing the dialog box for typing the replies




  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white,
        borderRadius: BorderRadius.circular(8.0)
      ),
      margin: EdgeInsets.only(top: 25.0,left: 25,right: 25.0),
      padding: EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Profile Picture
          // Container(
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     color: Colors.grey[400],
          //
          //   ),
          //   child: Icon(Icons.person,
          //     color: Colors.white,
          //   ),
          //   padding: EdgeInsets.all(10),
          // ),
          SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user,
                style: TextStyle(color: Colors.grey[500]),
              ),
              const SizedBox(height: 10,),

              Text(widget.message),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  LikedButton(
                    isLiked: isLiked,
                    onTap: toggleLike,
                  ),
                  const SizedBox(height: 10,),
                  //Like count

                  Text(
                    widget.likes.length.toString(),
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),


              SizedBox(width: 30.0,),


              Column(
                children: [
                  ReplyButton(
                    onTap: showReplyBox,
                  ),
                  const SizedBox(height: 10,),


                  //Like count
                  // int a = snapshot.data!.docs.length;


                  Text(
                    '$numberOfComments',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),


            ],
          ),
          SizedBox(height: 10.0,),
          //Replies under the post
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('User_Posts')
                  .doc(widget.postId).collection('Replies')
                  .orderBy('ReplyTime',descending: true).snapshots(),
            builder: (context,snapshot){
              //show loading circle
              if(!snapshot.hasData){
                return const Center(
                    child: CircularProgressIndicator()
                );
              }
              return ListView(
                shrinkWrap: true, //for nested lists
                physics : const NeverScrollableScrollPhysics(),
                children: snapshot.data!.docs.map((doc){
                  final ReplyData = doc.data() as Map<String, dynamic>;
                  return ReplyBar(
                      text: ReplyData['ReplyText'],
                      time: formatDate(ReplyData['ReplyTime']),
                      user: ReplyData['RepliedBy']
                  );
                }
              ).toList()

              );


          }),
        ],


      ),


    );
  }
}
