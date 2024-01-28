import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyListTile extends StatelessWidget {
  final IconData icon;
  final IconData endIcon;
  final String text;
  final GestureTapCallback? onTap;
  const MyListTile({
    super.key,
    required this.icon,
    required this.text,
    required this.endIcon,
    this.onTap
});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        elevation: 1.0,
        color: Colors.deepPurple, //Colors.deepPurple[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          selectedTileColor: Colors.yellow,
          onTap: onTap,
          selectedColor: Colors.blue,
          leading: Container(
            width: 30,height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white.withOpacity(0.2)
            ),
            child: Icon(
              icon,
              size: 30,
              color: Colors.white,

            ),
          ),
          title: Text(
            text,
            style: GoogleFonts.oswald(
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white

              )
            )//Google Fonts
          ),
          trailing: Icon(endIcon,color: Colors.white,),
        ),
      ),
    );
  }
}
