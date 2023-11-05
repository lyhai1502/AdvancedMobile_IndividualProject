import 'package:flutter/material.dart';

class ListSelectWidget extends StatefulWidget {
  const ListSelectWidget({super.key});

  @override
  ListSelectState createState() => ListSelectState();
}

class ListSelectState extends State<ListSelectWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        index++;
        return ListTile(
          title: Row(
            children: [
              Text('$index.   ', style: const TextStyle(fontWeight: FontWeight.bold)),
              const Text(
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
