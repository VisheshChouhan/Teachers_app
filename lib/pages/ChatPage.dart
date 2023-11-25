import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class ChatPage extends StatefulWidget {
  const ChatPage(this.teacherDepartment, {super.key});
  final String teacherDepartment ;

  @override
  State<ChatPage> createState() => _ChatPageState(teacherDepartment);
}

class _ChatPageState extends State<ChatPage> {


  final currentUser = FirebaseAuth.instance.currentUser!;
  //final currentUserEmail = c.email;
  static String docId = FirebaseAuth.instance.currentUser?.uid ?? '';
  final TextEditingController messageData = TextEditingController();
  final listController = ScrollController();

  void addDataToFirestore() {
    var currentUserEmail = currentUser.email;
    var slicedEmail =
        currentUserEmail?.substring(0, currentUserEmail.indexOf("@"));

    if (messageData.text.isNotEmpty) {
      FirebaseFirestore.instance
          .collection(widget.teacherDepartment)
          .doc("a")
          .collection("posts")
          .add({
        'user': slicedEmail,
        'message': messageData.text,
        'timeStamp': Timestamp.now(),
      });

      /*setState(() {
        messageData.clear();
      });*/
    }
  }

  //Future<DocumentSnapshot<Map<String, dynamic>>> teacherData;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Map<String, dynamic> data = <String, dynamic>{};

  _ChatPageState(String teacherDepartment);

  /*Future<String > getData() async{
    final docRef = db.collection("teachers").doc(docId);

    await docRef.get().then (
          (DocumentSnapshot doc) {
        data = doc.data() as  Map<String, dynamic>;


        // ...
      },
      onError: (e) => print("Error getting document: $e"),
    );
    var temp = data["department"].toString();
    return temp;

  }*/

  @override
  build(BuildContext context) {
    //log("Branch $data['department]");
    //debugPrint("Branch $Branch");

    return Scaffold(
      appBar: AppBar(
        title: Text("Official Group of \n${widget.teacherDepartment}"),
        automaticallyImplyLeading: false,
        actions: const [Text("abc")],
      ),
      body: SafeArea(
        child: Column(children: [
          //Text(widget.teacherDepartment),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(widget.teacherDepartment)
                    .doc("a")
                    .collection("posts")
                    .orderBy('timeStamp', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        controller: listController,
                        dragStartBehavior: DragStartBehavior.down,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final post = snapshot.data!.docs[index];
                          return CreateChatMessage(post);
                          /*Text(
                            post["message"],
                          )*/
                        });
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error:' + snapshot.error.toString()),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
          //Text(widget.teacherDepartment),
          Material(
              elevation: 15,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: messageData,
                      decoration: const InputDecoration(
                          hintText: "Type your message here...",
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueGrey))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    )),
                    IconButton(
                        onPressed: addDataToFirestore,
                        icon: const Icon(
                          Icons.send,
                          size: 40,
                          color: Colors.blue,
                        ))
                  ],
                ),
              )),
        ]),
      ),
    );
  }

  /*Widget getRow(int i) {
    return GestureDetector(
      child: Padding(padding: EdgeInsets.all(10.0), child: Text("Row $i")),
      onTap: () {
        setState(() {
          widgets.add(getRow(widgets.length + 1));
          print('row $i');
        });
      },
    );
  }*/

  Container CreateChatMessage(
      QueryDocumentSnapshot<Map<String, dynamic>> post) {
    var currentUserEmail = currentUser.email;
    var slicedEmail =
        currentUserEmail?.substring(0, currentUserEmail.indexOf("@"));

    if (listController.hasClients) {
      //final position = listController.position.maxScrollExtent;
      //listController.jumpTo(position);
    }

    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
      child: Align(
        alignment: (post["user"] != slicedEmail
            ? Alignment.topLeft
            : Alignment.topRight),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: (post["user"] != slicedEmail
                  ? Colors.grey.shade200
                  : Colors.blue),
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post["user"]),
                  /*SizedBox(
                    width: double.infinity,
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),*/


                  Text(
                    post["message"],
                    style: TextStyle(
                        fontSize: 15,
                      color: (post["user"] != slicedEmail
                          ? Colors.black
                          : Colors.white),
                    ),

                  )
                ],
              ),
            )),

    );
  }
}
