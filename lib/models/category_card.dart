import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryCard extends StatelessWidget {
  final String image;
  final String text;
  final GestureTapCallback? onTap;
  CategoryCard({super.key, required this.text,required this.image,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.deepPurple[100],
          ),
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Image(image: AssetImage(image),
                height: 70,),
              SizedBox(width: 10,),
              Text(
                text,
                  style :  GoogleFonts.abel(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )
              ),
            ],
          ),

        ),
      ),
    );
  }
}
