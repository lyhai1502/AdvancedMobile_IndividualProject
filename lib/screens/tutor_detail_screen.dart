import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:my_app/widgets/app_bar.dart';
import 'package:my_app/widgets/review.dart';
import 'package:video_player/video_player.dart';

class TutorDetailScreen extends StatefulWidget {
  const TutorDetailScreen({Key? key}) : super(key: key);

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
      appBar: AppBarWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTutorHeader(),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              _buildTutorDescription(),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              _buildTutorActions(),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              FlickVideoPlayer(flickManager: flickManager),
              const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              _buildSectionHeader('Education'),
              _buildSectionContent('BA'),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              _buildSectionHeader('Languages'),
              _buildLanguageButton('English'),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              _buildSectionHeader('Specialties'),
              _buildSpecialtiesButtons(),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              _buildSectionHeader('Reviews'),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              _buildReviewWidgets(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTutorHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: Image.asset('lib/assets/icons/facebook.png'),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Name",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            Row(
              children: [
                for (var i = 0; i < 5; i++)
                  const Icon(Icons.star, size: 20, color: Colors.amberAccent),
                const Text('  (122)')
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset('lib/assets/icons/vietnam.png'),
                ),
                const Padding(padding: EdgeInsets.only(right: 5)),
                const Text('Vietnam'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTutorDescription() {
    return const Text(
      "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience",
      style: TextStyle(fontSize: 15, color: Colors.black),
    );
  }

  Widget _buildTutorActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionIconButton(Icon(Icons.favorite), 'Favorite'),
        _buildActionIconButton(Icon(Icons.report), 'Report'),
      ],
    );
  }

  Widget _buildActionIconButton(Icon _icon, String label) {
    return Column(
      children: [
        IconButton(
          onPressed: () {},
          icon: _icon,
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.blue),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        content,
        style: const TextStyle(fontSize: 15, color: Colors.black),
      ),
    );
  }

  Widget _buildLanguageButton(String language) {
    return Container(
      padding: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.blue),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
        onPressed: () {},
        child: Text(language),
      ),
    );
  }

  Widget _buildSpecialtiesButtons() {
    return Wrap(
      children: [
        for (String item in items)
          Container(
            padding: const EdgeInsets.only(right: 8),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {},
              child: Text(item),
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
}
