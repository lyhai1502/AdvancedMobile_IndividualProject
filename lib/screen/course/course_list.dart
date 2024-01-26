import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:my_app/network/model/course_api.dart';
import 'package:my_app/network/model/tokens.dart';
import 'package:my_app/network/network_request/course/course_list_request.dart';
import 'package:my_app/network/network_request/course/search_course_request.dart';
import 'package:my_app/network/network_request/ebook/ebook_list_request.dart';
import 'package:my_app/network/network_request/ebook/search_ebook_request.dart';
import 'package:my_app/repository/course_repository.dart';
import 'package:my_app/screen/course/course_detail.dart';
import 'package:provider/provider.dart';

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CourseScreenWidgetState();
  }
}

class CourseScreenWidgetState extends State<CourseListScreen> {
  CourseRepository courseRepository = CourseRepository();
  final TextEditingController searchCourseController = TextEditingController();
  Tokens tokens = Tokens();
  int currentPage = 1;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    _isLoading = true;
    courseRepository = context.read<CourseRepository>();

    tokens = context.read<Tokens>();

    Future<dynamic> future =
        CourseListRequest.getCourseList(tokens.access?.token, 9, currentPage);
    await future.then((value) {
      setState(() {
        courseRepository.courseList = value;
        courseRepository.update();
        _isLoading = false;
      });
    });

    _isLoading = true;
    Future<dynamic> future2 =
        EbookListRequest.getEbookList(tokens.access?.token, 9, currentPage);
    await future2.then((value) {
      setState(() {
        courseRepository.ebookList = value;
        courseRepository.update();
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            _buildIntroduction(),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            _buildSearchTextField(),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            _buildMultiSelectDropDown(
              hint: 'Select level',
              options: _getOptions(),
              maxItems: 6,
              selectionType: SelectionType.multi,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            _buildMultiSelectDropDown(
              hint: 'Sort by level',
              options: _getOptions(),
              maxItems: 2,
              selectionType: SelectionType.single,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            _buildMultiSelectDropDown(
              hint: 'Select category',
              options: _getOptions(),
              maxItems: 6,
              selectionType: SelectionType.multi,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            _buildTabBarView(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 100,
      width: 100,
      child: Image.asset('lib/assets/icons/course.png'),
    );
  }

  Widget _buildIntroduction() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Discover Courses",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        Text(
          "LiveTutor has built the most quality, methodical and scientific courses in the fields of life for those who are in need of improving their knowledge of the fields.",
          style: TextStyle(fontSize: 17, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildSearchTextField() {
    return CupertinoSearchTextField(
      placeholder: 'Search courses',
      controller: searchCourseController,
      onChanged: (value) {
        setState(() {
          getSearchData();
        });
      },
    );
  }

  Future<void> getSearchData() async {
    Future<dynamic> future = SearchCourseRequest.searchCourse(
        context.read<Tokens>().access?.token,
        9,
        1,
        searchCourseController.text);
    await future.then((value) {
      setState(() {
        courseRepository.courseList = value;
        courseRepository.update();
      });
    });

    Future<dynamic> future2 = SearchEbookRequest.searchEbook(
        context.read<Tokens>().access?.token,
        9,
        1,
        searchCourseController.text);
    await future2.then((value) {
      setState(() {
        courseRepository.ebookList = value;
        courseRepository.update();
      });
    });
  }

  Widget _buildMultiSelectDropDown({
    required String hint,
    required List<ValueItem> options,
    required int maxItems,
    required SelectionType selectionType,
  }) {
    return MultiSelectDropDown(
      hint: hint,
      hintStyle: const TextStyle(fontSize: 18, color: Colors.black45),
      showClearIcon: true,
      onOptionSelected: (options) {},
      options: options,
      maxItems: maxItems,
      selectionType: selectionType,
      chipConfig: const ChipConfig(wrapType: WrapType.scroll),
      dropdownHeight: 300,
      optionTextStyle: const TextStyle(fontSize: 16),
      selectedOptionIcon: const Icon(Icons.check_circle),
    );
  }

  List<ValueItem> _getOptions() {
    return const <ValueItem>[
      ValueItem(label: 'Option 1', value: '1'),
      ValueItem(label: 'Option 2', value: '2'),
      ValueItem(label: 'Option 3', value: '3'),
      ValueItem(label: 'Option 4', value: '4'),
      ValueItem(label: 'Option 5', value: '5'),
      ValueItem(label: 'Option 6', value: '6'),
    ];
  }

  Widget _buildTabBarView() {
    return SizedBox(
      height: 220 + 700 * courseRepository.courseList.length.toDouble(),
      child: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Column(
          children: [
            const TabBar(
              indicatorColor: Colors.blue,
              tabs: [
                Tab(
                  child: Text(
                    "Course",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "E-Book",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Interactive E-Book",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  courseRepository.courseList.isEmpty && _isLoading == false
                      ? const Stack(alignment: Alignment.topCenter, children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('Sorry we can\'t find any courses',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                )),
                          ),
                        ])
                      : _buildCourseList(),
                  courseRepository.courseList.isEmpty && _isLoading == false
                      ? const Stack(alignment: Alignment.topCenter, children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('Sorry we can\'t find any courses',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                )),
                          ),
                        ])
                      : _buildEbookList(),
                  const Stack(alignment: Alignment.topCenter, children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('Sorry we can\'t find any interactive e-book',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          )),
                    ),
                  ])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseList() {
    return !_isLoading
        ? Column(
            children: [
              _buildPaginationButtons(),
              for (CourseApi course in courseRepository.courseList)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CourseDetailScreen(courseId: course.id)));
                  },
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 20),
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: Image.network(
                                course.imageUrl ?? '',
                                width: 400,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5)),
                          Container(
                            margin: const EdgeInsets.all(30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  course.name ?? '',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                ),
                                Text(
                                  course.description ?? '',
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                ),
                                Text(
                                  '${courseLevel(course.level)}  •  ${course.topics?.length} Lessons',
                                  style: const TextStyle(
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
          )
        : const Padding(
            padding: EdgeInsets.all(1.0),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                CircularProgressIndicator(
                  color: Colors.blue,
                )
              ],
            ),
          );
  }

  Widget _buildEbookList() {
    return !_isLoading
        ? Column(
            children: [
              _buildPaginationButtons(),
              for (CourseApi course in courseRepository.ebookList)
                GestureDetector(
                  onTap: () {},
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 20),
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: Image.network(
                                course.imageUrl ?? '',
                                width: 400,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5)),
                          Container(
                            margin: const EdgeInsets.all(30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  course.name ?? '',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                ),
                                Text(
                                  course.description ?? '',
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                ),
                                Text(
                                  courseLevel(course.level),
                                  style: const TextStyle(
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
          )
        : const Padding(
            padding: EdgeInsets.all(1.0),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                CircularProgressIndicator(
                  color: Colors.blue,
                )
              ],
            ),
          );
  }

  String courseLevel(String? courseLevel) {
    switch (courseLevel) {
      case '0':
        return 'Any level';
      case '1':
        return 'Beginner';
      case '4':
        return 'Intermediate';
      case '7':
        return 'Advanced';
      default:
        return 'Unknown';
    }
  }

  Widget _buildPaginationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              if (currentPage > 1) {
                currentPage--;
                getData();
              }
            });
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        Text(
          '$currentPage',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              if (courseRepository.courseList.length == 9) currentPage++;
              getData();
            });
          },
          icon: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
