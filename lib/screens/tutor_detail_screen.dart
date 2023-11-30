import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:my_app/model/teacher.dart';
import 'package:my_app/widgets/custom_button.dart';
import 'package:my_app/widgets/rating.dart';
import 'package:my_app/widgets/review.dart';
import 'package:video_player/video_player.dart';

class TutorDetailScreen extends StatefulWidget {
  const TutorDetailScreen({super.key, required this.teacher});

  final Teacher teacher;
  @override
  State<StatefulWidget> createState() {
    return TutorDetailScreenState();
  }
}

class TutorDetailScreenState extends State<TutorDetailScreen> {
  final FlickManager flickManager = FlickManager(
    videoPlayerController: VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    ),
  );
  final List<String> items = [
    'All',
    'English for kids',
    'English for business',
    'Conversational',
    'STARTERS',
    'MOVERS',
    'FLYERS',
    'KET',
    'PET',
    'IELTS',
    'TOEFL',
    'TOEIC'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutor detail'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTutorHeader(widget.teacher),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              _buildTutorDescription(widget.teacher.description),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              _buildTutorActions(),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              FlickVideoPlayer(flickManager: flickManager),
              const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              _buildInformationDetail(widget.teacher),
              const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              _buildHeaderOfInformation('Other reviews'),
              _buildReviewWidgets()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTutorHeader(Teacher teacher) {
    String name = teacher.name;
    String avatarUrl = teacher.avatarUrl;
    int rating = teacher.rating;
    String nation = teacher.nation;
    String nationUrlLowcase = nation.toLowerCase();
    String nationUrl = 'lib/assets/icons/teacher/country/$nationUrlLowcase.png';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: Image.asset(avatarUrl),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            Row(
              children: [RatingWidget(rating: rating), Text('  ($rating)')],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset(nationUrl),
                ),
                const Padding(padding: EdgeInsets.only(right: 5)),
                Text(nation),
              ],
            ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionIconButton(const Icon(Icons.favorite), 'Favorite'),
        _buildActionIconButton(const Icon(Icons.report), 'Report'),
      ],
    );
  }

  Widget _buildActionIconButton(Icon icon, String label) {
    return Column(
      children: [
        IconButton(
          onPressed: () {},
          icon: icon,
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.blue),
        ),
      ],
    );
  }

  Widget _buildInformationDetail(Teacher teacher) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderOfInformation("Education"),
        CustomButtonWidget(content: teacher.education),
        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        _buildHeaderOfInformation('Languages'),
        _buildMultiCustomButtons(teacher.specialities),
        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        _buildHeaderOfInformation('Interests'),
        Padding(padding: EdgeInsets.all(5), child: Text(teacher.interests)),
        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        _buildHeaderOfInformation('Teaching experience'),
        Padding(padding: EdgeInsets.all(5), child: Text(teacher.experience)),
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
        for (String item in contents) CustomButtonWidget(content: item)
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
}
