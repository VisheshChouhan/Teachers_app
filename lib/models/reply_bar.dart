import 'package:flutter/material.dart';

class ReplyBar extends StatelessWidget {
  final String text;
  final String user;
  final String time;
  const ReplyBar({
    super.key,
    required this.text,
    required this.time,
    required this.user,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(5.0),

      ),
      margin: EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Comment
          Text(text),
          const SizedBox(height: 5,),


          //user ,time
          Row(
            children: [
              Text(user, style: TextStyle(
                color: Colors.grey[400],
              ),),

              SizedBox(width: 70.0,),

              Text(time, style: TextStyle(
                color: Colors.grey[400],
              ),),
            ],
          )
        ],

      ),
    );
  }
}
