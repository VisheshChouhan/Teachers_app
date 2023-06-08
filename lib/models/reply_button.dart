import 'package:flutter/material.dart';



class ReplyButton extends StatelessWidget {
  void Function()? onTap;
  ReplyButton({
    super.key,
    this.onTap

});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(
        Icons.comment,
        color: Colors.grey,
      ),
    );
  }
}
