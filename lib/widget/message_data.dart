import 'package:flutter/material.dart';

class MessageData extends StatelessWidget {
  final String message;
  final String image;

  const MessageData({
    super.key,
    required this.image,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          image,
          width: 200,
          height: 200,
        ),
        Text(message),
      ],
    );
  }
}
