import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget(
      {super.key,
      required this.content,
      required this.function,
      required this.color});
  final String content;
  final VoidCallback function;
  final MaterialColor color;
  @override
  Widget build(Object context) {
    // TODO: implement build
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(color),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
      onPressed: function,
      child: Text(content),
    );
  }
}
