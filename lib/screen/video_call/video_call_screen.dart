import 'package:flutter/material.dart';

import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:my_app/network/model/schedule_api.dart';
import 'package:my_app/network/model/tokens.dart';
import 'package:my_app/widget/count_down_timer.dart';
import 'package:my_app/widget/custom_button.dart';
import 'package:jwt_decode/jwt_decode.dart';

class VideoCallScreen extends StatefulWidget {
  final ScheduleApi scheduleApi;

  VideoCallScreen({Key? key, required this.scheduleApi}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => VideoCallScreenState();
}

class VideoCallScreenState extends State<VideoCallScreen> {
  bool audioMuted = true;
  bool videoMuted = true;
  bool screenShareOn = false;
  List<String> participants = [];
  final _jitsiMeetPlugin = JitsiMeet();

  Tokens tokens = Tokens();
  Map<String, dynamic> payload = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    String jwtToken =
        widget.scheduleApi.studentMeetingLink!.split("/")[2].split("=")[1];
    payload = Jwt.parseJwt(jwtToken);
  }

  join() async {
    var options = JitsiMeetConferenceOptions(
      serverURL: "https://meet.lettutor.com",
      room: payload['room'],
      configOverrides: {
        "startWithAudioMuted": true,
        "startWithVideoMuted": true,
      },
      featureFlags: {"unsaferoomwarning.enabled": false},
      userInfo: JitsiMeetUserInfo(
          displayName: payload['userCall']['name'],
          email: payload['userCall']['email'],
          avatar: payload['userCall']['avatar']),
    );

    var listener = JitsiMeetEventListener(
      conferenceJoined: (url) {
        debugPrint("conferenceJoined: url: $url");
      },
      conferenceTerminated: (url, error) {
        debugPrint("conferenceTerminated: url: $url, error: $error");
      },
      conferenceWillJoin: (url) {
        debugPrint("conferenceWillJoin: url: $url");
      },
      participantJoined: (email, name, role, participantId) {
        debugPrint(
          "participantJoined: email: $email, name: $name, role: $role, "
          "participantId: $participantId",
        );
        participants.add(participantId!);
      },
      participantLeft: (participantId) {
        debugPrint("participantLeft: participantId: $participantId");
      },
      audioMutedChanged: (muted) {
        debugPrint("audioMutedChanged: isMuted: $muted");
      },
      videoMutedChanged: (muted) {
        debugPrint("videoMutedChanged: isMuted: $muted");
      },
      endpointTextMessageReceived: (senderId, message) {
        debugPrint(
            "endpointTextMessageReceived: senderId: $senderId, message: $message");
      },
      screenShareToggled: (participantId, sharing) {
        debugPrint(
          "screenShareToggled: participantId: $participantId, "
          "isSharing: $sharing",
        );
      },
      chatMessageReceived: (senderId, message, isPrivate, timestamp) {
        debugPrint(
          "chatMessageReceived: senderId: $senderId, message: $message, "
          "isPrivate: $isPrivate, timestamp: $timestamp",
        );
      },
      chatToggled: (isOpen) => debugPrint("chatToggled: isOpen: $isOpen"),
      participantsInfoRetrieved: (participantsInfo) {
        debugPrint(
            "participantsInfoRetrieved: participantsInfo: $participantsInfo, ");
      },
      readyToClose: () {
        debugPrint("readyToClose");
      },
    );
    await _jitsiMeetPlugin.join(options, listener);
  }

  hangUp() async {
    await _jitsiMeetPlugin.hangUp();
  }

  setAudioMuted(bool? muted) async {
    var a = await _jitsiMeetPlugin.setAudioMuted(muted!);
    debugPrint("$a");
    setState(() {
      audioMuted = muted;
    });
  }

  setVideoMuted(bool? muted) async {
    var a = await _jitsiMeetPlugin.setVideoMuted(muted!);
    debugPrint("$a");
    setState(() {
      videoMuted = muted;
    });
  }

  sendEndpointTextMessage() async {
    var a = await _jitsiMeetPlugin.sendEndpointTextMessage(message: "HEY");
    debugPrint("$a");

    for (var p in participants) {
      var b =
          await _jitsiMeetPlugin.sendEndpointTextMessage(to: p, message: "HEY");
      debugPrint("$b");
    }
  }

  toggleScreenShare(bool? enabled) async {
    await _jitsiMeetPlugin.toggleScreenShare(enabled!);

    setState(() {
      screenShareOn = enabled;
    });
  }

  openChat() async {
    await _jitsiMeetPlugin.openChat();
  }

  sendChatMessage() async {
    var a = await _jitsiMeetPlugin.sendChatMessage(message: "HEY1");
    debugPrint("$a");

    for (var p in participants) {
      a = await _jitsiMeetPlugin.sendChatMessage(to: p, message: "HEY2");
      debugPrint("$a");
    }
  }

  closeChat() async {
    await _jitsiMeetPlugin.closeChat();
  }

  retrieveParticipantsInfo() async {
    var a = await _jitsiMeetPlugin.retrieveParticipantsInfo();
    debugPrint("$a");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Video Call'),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CustomButtonWidget(
                content: 'Join Meeting',
                function: () {
                  join();
                },
                color: Colors.blue),
            CountDownTimerWidget(
                startPeriodTimestamp: widget
                    .scheduleApi.scheduleDetailInfo?.startPeriodTimestamp!),
          ]),
        ));
  }
}
