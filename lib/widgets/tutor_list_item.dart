import 'package:flutter/material.dart';
import 'package:my_app/model/teacher.dart';
import 'package:my_app/network/models/Tokens.dart';
import 'package:my_app/network/models/TutorApi.dart';
import 'package:my_app/network/network_request/tutor/get_tutor_info_request.dart';
import 'package:my_app/network/network_request/tutor/tutor_list_request.dart';
import 'package:my_app/repository/teacher_repository.dart';
import 'package:my_app/screens/booking_calendar_screen.dart';
import 'package:my_app/widgets/custom_button.dart';
import 'package:my_app/widgets/rating.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class TutorListItemWidget extends StatefulWidget {
  const TutorListItemWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TutorListItemWidgetState();
  }
}

class TutorListItemWidgetState extends State<TutorListItemWidget> {
  bool isFavorited = false;

  Tokens tokens = Tokens();
  List<TutorApi> tutorList = [];
  bool _isLoading = true;
  int currentPage = 1;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    tokens = context.read<Tokens>();

    Future<dynamic> future = TutorListRequest.getTutorListPagination(
        tokens.access?.token, 9, currentPage);
    await future.then((value) {
      setState(() {
        tutorList = value;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // getData();
    // TeacherRepository teacherRepository = context.watch<TeacherRepository>();
    // TODO: implement build
    return !_isLoading
        ? Column(
            children: [
              Center(
                child: Column(children: [
                  for (TutorApi tutor in tutorList)
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             TutorDetailScreen(teacher: tutor)));
                      },
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              _buildAvatar(tutor.avatar),
                              _buildName(tutor.name),
                              _buildNation(tutor.country),
                              if (tutor.rating != null)
                                RatingWidget(rating: tutor.rating as double)
                              else
                                Text("No rating"),
                              _buildSpecialities(tutor.specialties != null
                                  ? tutor.specialties!
                                      .split(',')
                                      .map((s) => s.trim())
                                      .toList()
                                  : []),
                              _buildDescription(tutor.bio),
                              _buildButtons(tutor),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ]),
              ),
              _buildPaginationButtons(),
            ],
          )
        : Center(
            heightFactor: MediaQuery.of(context).size.height / 2,
            child: const CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
  }

  Widget _buildAvatar(String? avatarUrl) {
    return SizedBox(
        height: 100,
        width: 100,
        child: avatarUrl != null
            ? CircleAvatar(backgroundImage: NetworkImage(avatarUrl))
            : const Icon(
                Icons.person,
                size: 100,
              ));
  }

  Widget _buildName(String? name) {
    return Text(
      name ?? '',
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildNation(String? nation) {
    if (nation != null) {
      String flagApiUrl = 'https://flagsapi.com/$nation/flat/64.png';

      return FutureBuilder(
        future: http.get(Uri.parse(flagApiUrl)),
        builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
          if (snapshot.hasData) {
            // Parse the response and extract the flag API
            // Example: String flagApi = jsonDecode(snapshot.data.body)['flags']['png'];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 20,
                      height: 20,
                      // Use the flag API to display the flag
                      // Example: Image.network(flagApi),
                      child: Image.network((flagApiUrl))),
                  const Padding(
                    padding: EdgeInsets.only(right: 5),
                  ),
                  Text(nation),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Text('Error fetching flag API');
          } else {
            return const CircularProgressIndicator();
          }
        },
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _buildSpecialities(List<String> specialities) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Wrap(
        children: [
          for (String item in specialities)
            Padding(
              padding: EdgeInsets.only(right: 5),
              child: CustomButtonWidget(
                content: item,
                function: () {},
                color: Colors.blue,
              ),
            )
        ],
      ),
    );
  }

  Widget _buildDescription(String? description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        description ?? '',
        style: const TextStyle(fontSize: 15, color: Colors.black),
      ),
    );
  }

  Widget _buildButtons(TutorApi tutorApi) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              setState(() {
                tutorApi.isFavorite = !tutorApi.isFavorite!;
              });
            },
            icon: isFavorited
                ? const Icon(Icons.favorite, color: Colors.red)
                : const Icon(Icons.favorite)),
        ElevatedButton.icon(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.green),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          onPressed: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) =>
            //             BookingCalendarScreen(teacher: teacher)));
          },
          icon: const Icon(
            Icons.calendar_month,
            size: 24.0,
          ),
          label: const Text('Book'),
        ),
      ],
    );
  }

  Widget _buildPaginationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              // teacherRepository.previousPage();
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
              // teacherRepository.nextPage();
              currentPage++;
              getData();
            });
          },
          icon: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
