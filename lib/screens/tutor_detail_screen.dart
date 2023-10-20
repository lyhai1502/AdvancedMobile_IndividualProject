import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:my_app/widgets/review.dart';
import 'package:video_player/video_player.dart';

class TutorDetailScreen extends StatefulWidget {
  const TutorDetailScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return TutorDetailScreenState();
  }
}

class TutorDetailScreenState extends State<TutorDetailScreen> {
  final FlickManager flickManager = FlickManager(
      // ignore: deprecated_member_use
      videoPlayerController: VideoPlayerController.network(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'));
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
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                          color: Colors.black),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                    Row(
                      children: [
                        for (var i = 0; i < 5; i++)
                          const Icon(Icons.star,
                              size: 20, color: Colors.amberAccent),
                        const Text('  (122)')
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset('lib/assets/icons/vietnam.png'),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 5),
                        ),
                        const Text('Vietnam')
                      ],
                    ),
                  ],
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            const Text(
              "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience",
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset('lib/assets/icons/heart.png')),
                    const Text(
                      'Favorite',
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        color: Colors.blue,
                        onPressed: () {},
                        icon: const Icon(Icons.report)),
                    const Text(
                      'Report',
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            FlickVideoPlayer(flickManager: flickManager),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
            ),
            const Text(
              'Education',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                'BA',
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            const Text(
              'Languages',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Container(
                padding: const EdgeInsets.only(right: 8),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        )),
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () {},
                    child: const Text('English'))),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            const Text(
              'Specialties',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Wrap(
              children: [
                for (String item in items)
                  Container(
                      padding: const EdgeInsets.only(right: 8),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          onPressed: () {},
                          child: Text(item)))
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            const Text(
              'Specialties',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Column(children: [
              for (var i = 0; i < 3; i++)
                Container(
                    padding: const EdgeInsets.all(10),
                    child: RichText(
                        text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        const TextSpan(
                          text: 'Basic Conversation Topics',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.black),
                        ),
                        const TextSpan(
                          text: ':  ',
                        ),
                        TextSpan(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                          text: 'Link',
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        )
                      ],
                    ))),
            ]),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            const Text(
              'Interested',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                'I loved the weather, the scenery and the laid-back lifestyle of the locals.',
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            const Text(
              'Teaching experience',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                'I have more than 10 years of teaching english experience',
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            const Text(
              'Other reviews',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            Column(
              children: [
                for (var i = 0; i < 10; i++) const ReviewWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
