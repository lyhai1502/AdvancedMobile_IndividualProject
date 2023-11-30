import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({super.key, required this.rating});
  final int rating;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < rating; i++)
            const Icon(Icons.star, size: 20, color: Colors.amberAccent),
          for (var j = rating; j < 5; j++) const Icon(Icons.star, size: 20),
        ],
      ),
    );
  }
}
