import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:my_app/model/teacher.dart';
import 'package:my_app/network/models/tokens.dart';
import 'package:my_app/network/models/tutor_api.dart';
import 'package:my_app/network/models/user_api.dart';
import 'package:my_app/network/network_request/other/get_flag_request.dart';
import 'package:my_app/network/network_request/tutor/get_tutor_info_request.dart';
import 'package:my_app/network/network_request/tutor/manage_favorite_tutor_request.dart';
import 'package:my_app/network/network_request/user/get_user_info_request.dart';
import 'package:my_app/screens/booking_calendar_screen.dart';
import 'package:my_app/widgets/custom_button.dart';
import 'package:my_app/widgets/rating.dart';
import 'package:my_app/widgets/review.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class TutorDetailScreen extends StatefulWidget {
  const TutorDetailScreen({super.key, required this.tutorId});

  // final Teacher teacher;
  final String? tutorId;

  @override
  State<StatefulWidget> createState() {
    return TutorDetailScreenState();
  }
}

class TutorDetailScreenState extends State<TutorDetailScreen> {
  UserApi userApi = UserApi();
  TutorApi tutorApi = TutorApi();
  Tokens tokens = Tokens();
  bool _isLoading = true;

  late final FlickManager flickManager;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    tokens = context.read<Tokens>();

    Future<dynamic> future =
        GetTutorInfoRequest.getTutorInfo(tokens.access?.token, widget.tutorId);
    await future.then((value) {
      setState(() {
        tutorApi = value;
        loadVideo();
        _isLoading = false;
      });
    });
  }

  Future<void> loadVideo() async {
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        tutorApi.video ?? '',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tutor detail'),
        ),
        body: !_isLoading
            ? SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTutorHeader(tutorApi),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10)),
                      _buildTutorDescription(tutorApi.bio ?? ''),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10)),
                      _buildTutorActions(),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10)),
                      FlickVideoPlayer(flickManager: flickManager),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10)),
                      _buildInformationDetail(tutorApi),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10)),
                      _buildBookingButton(),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10)),
                      _buildHeaderOfInformation('Other reviews'),
                      _buildReviewWidgets(),
                    ],
                  ),
                ),
              )
            : Center(
                heightFactor: MediaQuery.of(context).size.height / 2,
                child: const CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ));
  }

  Widget _buildTutorHeader(TutorApi tutorApi) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
            height: 100,
            width: 100,
            child: tutorApi.avatar != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(tutorApi.avatar ?? ''))
                : const Icon(
                    Icons.person,
                    size: 100,
                  )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tutorApi.name ?? 'No name',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            Row(
              children: [
                if (tutorApi.rating != null)
                  RatingWidget(rating: tutorApi.rating as double)
                else
                  Text("No rating"),
                Text('   (${tutorApi.totalFeedback})')
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            GetFlagRequest.getFlag(tutorApi.country ?? ''),
          ],
        ),
      ],
    );
  }

  Widget _buildTutorDescription(String description) {
    return Text(
      description,
      style: TextStyle(fontSize: 15, color: Colors.black),
    );
  }

  Widget _buildTutorActions() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      _buildActionIconButton(
          tutorApi.isFavorite!
              ? const Icon(
                  Icons.favorite,
                  color: Colors.red,
                )
              : const Icon(
                  Icons.favorite,
                  color: Colors.black,
                ),
          'Favorite', () {
        setState(() {
          ManageFavoriteTutorRequest.manageFavoriteTutor(
              tokens.access?.token ?? '', tutorApi.userId ?? '');
          tutorApi.isFavorite = !tutorApi.isFavorite!;
        });
      }),
      _buildActionIconButton(const Icon(Icons.message), 'Message', () {
        openDialog('Message');
      }),
      _buildActionIconButton(const Icon(Icons.report), 'Report', () {
        openDialog('Report');
      }),
    ]);
  }

  Widget _buildActionIconButton(
      Icon icon, String label, VoidCallback function) {
    return Column(
      children: [
        IconButton(
          onPressed: function,
          icon: icon,
          color: Colors.blue,
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.blue),
        ),
      ],
    );
  }

  Widget _buildInformationDetail(TutorApi tutorApi) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderOfInformation("Education"),
        Padding(
            padding: EdgeInsets.all(5), child: Text(tutorApi.education ?? '')),
        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        _buildHeaderOfInformation('Languages'),
        _buildMultiCustomButtons(tutorApi.languages != null
            ? tutorApi.languages!.split(',').map((s) => s.trim()).toList()
            : []),
        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        _buildHeaderOfInformation("Specialities"),
        _buildMultiCustomButtons(tutorApi.specialties != null
            ? tutorApi.specialties!.split(',').map((s) => s.trim()).toList()
            : []),
        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        _buildHeaderOfInformation('Interests'),
        Padding(
            padding: EdgeInsets.all(5), child: Text(tutorApi.interests ?? '')),
        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        _buildHeaderOfInformation('Teaching experience'),
        Padding(padding: EdgeInsets.all(5), child: Text(tutorApi.bio ?? '')),
      ],
    );
  }

  Widget _buildHeaderOfInformation(String header) {
    return Text(
      header,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildMultiCustomButtons(List<String> contents) {
    return Wrap(
      children: [
        for (String item in contents)
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: CustomButtonWidget(
              content: item,
              function: () {},
              color: Colors.blue,
            ),
          ),
      ],
    );
  }

  Widget _buildReviewWidgets() {
    return Column(
      children: [
        for (var i = 0; i < 10; i++) const ReviewWidget(),
      ],
    );
  }

  Widget _buildBookingButton() {
    return Center(
      child: ElevatedButton.icon(
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
          //             BookingCalendarScreen(teacher: widget.teacher)));
        },
        icon: const Icon(
          Icons.calendar_month,
          size: 24.0,
        ),
        label: const Text('Book class schedule'),
      ),
    );
  }

  Future openDialog(String content) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(content),
            content: const TextField(),
            actions: [
              CustomButtonWidget(
                content: 'Send',
                function: () {
                  Navigator.pop(context);
                },
                color: Colors.blue,
              )
            ],
          ));
}
