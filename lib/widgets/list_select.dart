import 'package:flutter/material.dart';

class ListSelectWidget extends StatefulWidget {
  @override
  ListSelectState createState() => ListSelectState();
}

class ListSelectState extends State<ListSelectWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        index++;
        return ListTile(
          title: Row(
            children: [
              Text('$index.   ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                'The Internet',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          tileColor: selectedIndex == index ? Colors.grey : null,
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
        );
      },
    );
  }
}
