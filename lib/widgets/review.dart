import 'package:flutter/material.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: Image.asset('lib/assets/icons/facebook.png'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: const TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Name',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    TextSpan(
                      text: '    ',
                    ),
                    TextSpan(
                      style: TextStyle(color: Colors.grey),
                      text: '4 months ago',
                    )
                  ],
                )),
                Row(
                  children: [
                    for (var i = 0; i < 5; i++)
                      const Icon(Icons.star,
                          size: 20, color: Colors.amberAccent),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                ),
                const Text('Comment here')
              ],
            )
          ],
        ),
      ),
    );
  }
}
