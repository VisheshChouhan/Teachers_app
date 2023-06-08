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
        color: Colors.deepPurple[100],
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
              color: Colors.pinkAccent.withOpacity(0.1)
            ),
            child: Icon(
              icon,
              size: 30,
            ),
          ),
          title: Text(
            text,
            style: GoogleFonts.oswald(
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,

              )
            )//Google Fonts
          ),
          trailing: Icon(endIcon),
        ),
      ),
    );
  }
}
