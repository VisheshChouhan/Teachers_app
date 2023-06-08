import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teachers_app/models/event_tile.dart';
class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      // appBar: AppBar(
      //   backgroundColor:Colors.pink[100],
      //   title: Center(child: Text("Community")),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all( 15.0),
            child: Column(
              children: const [


                EventTile(),
                SizedBox(height: 20.0,),
                EventTile(),
                SizedBox(height: 20.0,),
                EventTile(),


              ],
            ),
          ),
        ),

      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(topRight: Radius.circular(20.0 ),topLeft:Radius.circular(20.0) ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard,
                  size: 30.0,
                  color: Colors.grey,
                ),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.mail,
                  size: 30.0,
                  color: Colors.grey,
                ),
                label: 'Inbox',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people,
                  size: 30.0,
                  color: Colors.grey,

                ),
                label: 'Community',
              ),
            ],
          ),
        ),
      ),

    );
  }
}
