import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_dropdown/enum/app_enums.dart';
import 'package:multi_dropdown/models/chip_config.dart';
import 'package:multi_dropdown/models/network_config.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:multi_dropdown/widgets/hint_text.dart';
import 'package:multi_dropdown/widgets/selection_chip.dart';
import 'package:multi_dropdown/widgets/single_selected_item.dart';

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CourseScreenWidgetState();
  }
}

class CourseScreenWidgetState extends State<CourseListScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset('lib/assets/icons/course.png'),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          const Text(
            "Discover Courses",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          const Text(
            "LiveTutor has built the most quality, methodical and scientific courses in the fields of life for those who are in need of improving their knowledge of the fields.",
            style: TextStyle(fontSize: 17, color: Colors.black),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          const CupertinoSearchTextField(
            placeholder: 'Search courses',
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          MultiSelectDropDown(
            hint: "Select level",
            hintStyle: const TextStyle(fontSize: 18, color: Colors.black45),
            showClearIcon: true,
            onOptionSelected: (options) {
              debugPrint(options.toString());
            },
            options: const <ValueItem>[
              ValueItem(label: 'Option 1', value: '1'),
              ValueItem(label: 'Option 2', value: '2'),
              ValueItem(label: 'Option 3', value: '3'),
              ValueItem(label: 'Option 4', value: '4'),
              ValueItem(label: 'Option 5', value: '5'),
              ValueItem(label: 'Option 6', value: '6'),
            ],
            maxItems: 6,
            selectionType: SelectionType.multi,
            chipConfig: const ChipConfig(wrapType: WrapType.scroll),
            dropdownHeight: 300,
            optionTextStyle: const TextStyle(fontSize: 16),
            selectedOptionIcon: const Icon(Icons.check_circle),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
          ),
          MultiSelectDropDown(
            hint: "Sort by level",
            hintStyle: const TextStyle(fontSize: 18, color: Colors.black45),
            showClearIcon: true,
            onOptionSelected: (options) {
              debugPrint(options.toString());
            },
            options: const <ValueItem>[
              ValueItem(label: 'Option 1', value: '1'),
              ValueItem(label: 'Option 2', value: '2'),
            ],
            maxItems: 2,
            selectionType: SelectionType.single,
            dropdownHeight: 100,
            optionTextStyle: const TextStyle(fontSize: 16),
            selectedOptionIcon: const Icon(Icons.check_circle),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
          ),
          MultiSelectDropDown(
            hint: "Select category",
            hintStyle: const TextStyle(fontSize: 18, color: Colors.black45),
            showClearIcon: true,
            onOptionSelected: (options) {
              debugPrint(options.toString());
            },
            options: const <ValueItem>[
              ValueItem(label: 'Option 1', value: '1'),
              ValueItem(label: 'Option 2', value: '2'),
              ValueItem(label: 'Option 3', value: '3'),
              ValueItem(label: 'Option 4', value: '4'),
              ValueItem(label: 'Option 5', value: '5'),
              ValueItem(label: 'Option 6', value: '6'),
            ],
            maxItems: 6,
            selectionType: SelectionType.multi,
            chipConfig: const ChipConfig(wrapType: WrapType.scroll),
            dropdownHeight: 300,
            optionTextStyle: const TextStyle(fontSize: 16),
            selectedOptionIcon: const Icon(Icons.check_circle),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          SizedBox(
            height: 3900,
            child: DefaultTabController(
              initialIndex: 0,
              length: 3,
              child: Column(children: [
                const TabBar(
                  indicatorColor: Colors.blue,
                  tabs: [
                    Tab(
                      child: Text(
                        "Course",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "E-Book",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Interactive E-Book",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Column(
                        children: [
                          for (var i = 0; i < 9; i++)
                            GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Gesture Detected!')));
                              },
                              child: Card(
                                margin: const EdgeInsets.only(top: 20),
                                elevation: 0,
                                shape: const RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.grey),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                child: SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: SizedBox(
                                          height: 200,
                                          width: 300,
                                          child: Image.asset(
                                              'lib/assets/images/bg.png'),
                                        ),
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(30),
                                        child: const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Life In The Internet Age",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5),
                                            ),
                                            Text(
                                              "Let's discuss how technology is changing the way we live",
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15),
                                            ),
                                            Text(
                                              "Intermediate • 9  Lessons",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Text("It's rainy here"),
                      Text("It's sunny here"),
                    ],
                  ),
                )
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
