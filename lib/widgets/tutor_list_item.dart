import 'package:flutter/material.dart';
import 'package:my_app/network/models/tokens.dart';
import 'package:my_app/network/models/tutor_api.dart';
import 'package:my_app/network/network_request/other/get_flag_request.dart';
import 'package:my_app/network/network_request/tutor/manage_favorite_tutor_request.dart';
import 'package:my_app/network/network_request/tutor/tutor_list_request.dart';
import 'package:my_app/screens/tutor_detail_screen.dart';
import 'package:my_app/widgets/custom_button.dart';
import 'package:my_app/widgets/rating.dart';
import 'package:provider/provider.dart';

class TutorListItemWidget extends StatefulWidget {
  TutorListItemWidget({super.key, required this.tutorList});

  List<TutorApi> tutorList = [];
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TutorListItemWidgetState();
  }
}

class TutorListItemWidgetState extends State<TutorListItemWidget> {
  bool isFavorited = false;

  Tokens tokens = Tokens();
  bool _isLoading = true;
  int currentPage = 1;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    widget.tutorList = [];
    tokens = context.read<Tokens>();

    Future<dynamic> future = TutorListRequest.getTutorListPagination(
        tokens.access?.token, 9, currentPage);
    await future.then((value) {
      setState(() {
        widget.tutorList = value;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TeacherRepository teacherRepository = context.watch<TeacherRepository>();
    // TODO: implement build
    return !_isLoading
        ? Column(
            children: [
              _buildPaginationButtons(),
              Center(
                child: Column(children: [
                  for (TutorApi tutor in widget.tutorList)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TutorDetailScreen(tutorId: tutor.userId)));
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
                                const Text("No rating"),
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
            ],
          )
        : const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
  }

  Widget _buildAvatar(String? avatarUrl) {
    try {
      return SizedBox(
          height: 100,
          width: 100,
          child: avatarUrl != null
              ? CircleAvatar(backgroundImage: NetworkImage(avatarUrl))
              : const Icon(
                  Icons.person,
                  size: 100,
                ));
    } catch (e) {
      return const Icon(
        Icons.person,
        size: 100,
      );
    }
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

  Widget _buildNation(String? country) {
    return GetFlagRequest.getFlag(country);
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
    tutorApi.isFavorite ??= false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              setState(() {
                ManageFavoriteTutorRequest.manageFavoriteTutor(
                    tokens.access?.token ?? '', tutorApi.userId ?? '');
                tutorApi.isFavorite = !tutorApi.isFavorite!;
              });
            },
            icon: tutorApi.isFavorite!
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
