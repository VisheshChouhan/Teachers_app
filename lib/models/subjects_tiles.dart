import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectTile extends StatelessWidget {
  final String text;
  final String imagePath;
  final lectureType;

   const SubjectTile({
     super.key,
     required this.text,
     required this.imagePath,
     required this.lectureType,

});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.deepPurple[100],
              borderRadius: BorderRadius.circular(10)

          ),
          width: 170.0,

          child: Expanded(
            child: Column(
              children: [
                //Picture of the subject
                CircleAvatar(

                  backgroundColor: Colors.deepPurple[200],
                  radius: 50,
                  child: ClipRRect(

                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(imagePath,
                      height: 100.0,
                    ),
                  ),
                ),


                //Mode
                Text(
                    lectureType,
                    style :  GoogleFonts.abel(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )
                ),

                SizedBox(height: 20,),


                //Subject Name
                Text(text,
                    style :  GoogleFonts.abel(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )
                ),

                //subject code
                Text(
                  'C0234006',
                    style :  GoogleFonts.abel(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )
                )
              ],
            ),
          )
      ),
    );
  }
}
