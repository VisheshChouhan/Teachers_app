import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChatPage2 extends StatefulWidget {
  const ChatPage2(this.CourseCode, {super.key});
  final String CourseCode;

  @override
  State<ChatPage2> createState() => _ChatPage2State(CourseCode);
}

class _ChatPage2State extends State<ChatPage2> {
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
          .collection("Courses")
          .doc(widget.CourseCode)
          .collection("Chats")
          .add({
        'user': slicedEmail,
        'message': messageData.text,
        'messageType': "text",
        'imageUrl': "dummyUrl",
        'timeStamp': Timestamp.now(),
      });

      setState(() {
        messageData.clear();
      });
    }
  }

  void addimageToFirestore(String imageUrl) {
    var currentUserEmail = currentUser.email;
    var slicedEmail =
        currentUserEmail?.substring(0, currentUserEmail.indexOf("@"));

    FirebaseFirestore.instance
        .collection("Courses")
        .doc(widget.CourseCode)
        .collection("Chats")
        .add({
      'user': slicedEmail,
      'message': "dummy message",
      'messageType': "image",
      'imageUrl': imageUrl,
      'timeStamp': Timestamp.now(),
    });

    setState(() {
      messageData.clear();
    });
  }

  //Future<DocumentSnapshot<Map<String, dynamic>>> teacherData;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Map<String, dynamic> data = <String, dynamic>{};

  _ChatPage2State(String teacherDepartment);

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
  String imageUrl = '';

  @override
  build(BuildContext context) {
    //log("Branch $data['department]");
    //debugPrint("Branch $Branch");

    return Scaffold(
      appBar: AppBar(
        title: Text("Official Group of \n${widget.CourseCode}"),
        automaticallyImplyLeading: false,
        //actions: const [Text("abc")],
      ),
      body: SafeArea(
        child: Column(children: [
          //Text(widget.teacherDepartment),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Courses")
                    .doc(widget.CourseCode)
                    .collection("Chats")
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
                      child: Text('Error:${snapshot.error}'),
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
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () async {
                          /*
                * Step 1. Pick/Capture an image   (image_picker)
                * Step 2. Upload the image to Firebase storage
                * Step 3. Get the URL of the uploaded image
                * Step 4. Store the image URL inside the corresponding
                *         document of the database.
                * Step 5. Display the image on the list
                *
                * */

                          /*Step 1:Pick image*/
                          //Install image_picker
                          //Import the corresponding library

                          //File image = await picket.pickImage(source: ImageSource.gallery);
                          ImagePicker imagePicker = ImagePicker();
                          //final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
                          XFile? file = await imagePicker.pickImage(
                              source: ImageSource.gallery);
                          // Pick an image.
                          // final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
                          //print('${file?.path}');

                          if (file == null) return;
                          //Import dart:core
                          String uniqueFileName =
                              DateTime.now().millisecondsSinceEpoch.toString();

                          /*Step 2: Upload to Firebase storage*/
                          //Install firebase_storage
                          //Import the library

                          //Get a reference to storage root
                          Reference referenceRoot =
                              FirebaseStorage.instance.ref();
                          Reference referenceDirImages =
                              referenceRoot.child('images');

                          //Create a reference for the image to be stored
                          Reference referenceImageToUpload =
                              referenceDirImages.child(uniqueFileName);

                          //Handle errors/success
                          try {
                            //Store the file
                            await referenceImageToUpload
                                .putFile(File(file.path));
                            //Success: get the download URL
                            imageUrl =
                                await referenceImageToUpload.getDownloadURL();
                            addimageToFirestore(imageUrl);
                          } catch (error) {
                            //Some error occurred
                            print("Image Error $error");
                          }
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: Colors.blue,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
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
                        onPressed: () => addDataToFirestore(),
                        icon: const Icon(
                          Icons.send,
                          size: 40,
                          color: Colors.blue,
                        )),
                    const SizedBox(
                      width: 5,
                    ),
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

    if (post["messageType"] == "text") {
      return Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
        child: Align(
            alignment: (post["user"] != slicedEmail
                ? Alignment.topLeft
                : Alignment.topRight),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: (post["user"] != slicedEmail ? Colors.grey[350] : Colors.blue),
              ),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    post["user"],
                    style: TextStyle(
                      decoration: TextDecoration.underline ,
                      fontWeight: FontWeight.bold ,
                      fontSize: 13,
                      color: (post["user"] != slicedEmail
                          ? Colors.black
                          : Colors.white60),
                    ),
                  ),
                  const SizedBox(
                    height: 5,

                  ),

                  Text(
                    post["message"],
                    style: TextStyle(
                      fontSize: 15,
                      color: (post["user"] != slicedEmail
                          ? Colors.black
                          : Colors.white),
                    ),
                  ),
                  /*Text(
                    post["timeStamp"].toString(),
                    style: TextStyle(
                      fontSize: 15,
                      color: (post["user"] != slicedEmail
                          ? Colors.black
                          : Colors.white),
                    ),
                  )*/
                ],
              ),
            )),
      );
    } else {
      return Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
        child: Align(
            alignment: (post["user"] != slicedEmail
                ? Alignment.topLeft
                : Alignment.topRight),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: (post["user"] != slicedEmail ? Colors.grey[350] : Colors.blue),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post["user"],
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: (post["user"] != slicedEmail
                          ? Colors.black
                          : Colors.limeAccent),
                    ),
                  ),
                  const SizedBox(
                    height: 10,

                  ),

                  GestureDetector(
                      onTap: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => Dialog.fullscreen(
                          backgroundColor: Colors.transparent,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              Image.network(post["imageUrl"], width: double.infinity,),
                              const SizedBox(height: 15),
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.cancel_outlined),
                                iconSize: 40,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),//_showMyDialog(post["imageUrl"]),
                      child: Image.network(
                        post["imageUrl"],
                        width: 250,
                      ) /*Image.network(
                      post["imageUrl"],
                      width: 200,
                      //height: 200,
                    ),*/
                      )
                ],
              ),
            )),
      );
    }
  }

  Future<void> _showMyDialog(String imageUrl) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must not tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Image'),
          content: SingleChildScrollView(
            child: Image.network(
              imageUrl,
              width: 500,

              //height: 200,
            ),
          ),
        );
      },
    );
  }

  Column MyshowDialog() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('This is a fullscreen dialog.'),
        const SizedBox(height: 15),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
