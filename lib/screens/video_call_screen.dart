import 'package:flutter/material.dart';

class VideoCallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video call'),
      ),
      body: Column(
        children: [
          Expanded(child: Image.asset('lib/assets/images/videocall.png')),
        ],
      ),
    );
  }
}
