import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextStyle extends StatelessWidget {
  final String text;
  const MyTextStyle({
    super.key,
    required this.text
});

  @override
  Widget build(BuildContext context) {
    return Text(text,
    style: GoogleFonts.oswald(
      textStyle: TextStyle(
        fontSize: 25,
      )
    )
    );
  }
}
