import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teachers_app/pages/comments_page.dart';

class EventTile extends StatelessWidget {
  const EventTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.circular(20.0)
      ),

      height: 450.0,

      child: Expanded(
        child: Column(
          children: [
            Container(
              height: 60,

              decoration: BoxDecoration(
                  color: Colors.pink[100],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)
                  )
              ),
              child: Row(
                children:  [
                  Image.asset('lib/assets/cc.png',
                    height: 400,
                  ),
                  Text(
                      'Club Computer',
                      style: GoogleFonts.abel(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0
                        ),
                      )
                  ),

                ],

              ),




            ),
            SizedBox(height: 10.0,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                  color: Colors.pink[200],
                  
              ),

              margin: EdgeInsets.symmetric(horizontal: 10),
              height:200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),

                child: Image.asset('lib/assets/design_wars.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          'Design Wars',
                          style: GoogleFonts.abel(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0
                            ),
                          )
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.date_range),
                        Text(
                            ' 12 August 2023',
                            style: GoogleFonts.abel(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0
                              ),
                            )
                        ),
                      ],
                    )
                  ],
                ),


            ),

            ),
            SizedBox(height: 30,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.0),bottomLeft: Radius.circular(20.0)),
                    color: Colors.pink[200],

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Image(image: AssetImage('lib/assets/icons/heart.png'),
                        height: 30,),
                        Text(' 2345',
                        style: TextStyle(
                          fontWeight: FontWeight.w600
                        ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  const CommentPage()));
                          },
                          child: Container(
                            child: Image(image: AssetImage('lib/assets/icons/comments.png'),
                              height: 30,),
                          ),
                        ),
                        Text(' 2345',
                          style: TextStyle(
                              fontWeight: FontWeight.w600
                          ),
                        )
                      ],
                    ),
                    Image(image: AssetImage('lib/assets/icons/send.png'),
                      height: 30,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
