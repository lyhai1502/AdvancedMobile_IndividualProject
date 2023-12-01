import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget(
      {super.key, required this.content, required this.function});
  final String content;
  final VoidCallback function;
  @override
  Widget build(Object context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
        onPressed: function,
        child: Text(content),
      ),
    );
  }
}
