import 'package:flutter/material.dart';
import 'package:my_app/network/models/feed_back.dart';
import 'package:intl/intl.dart';
import 'package:my_app/widgets/rating.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({super.key, required this.feedBack});

  final FeedBack? feedBack;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(feedBack?.userAvatar ?? ''),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: feedBack?.userName ?? '',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    const TextSpan(
                      text: '    ',
                    ),
                    TextSpan(
                      text: '${_calculateRemainingTime(feedBack?.createdAt)}',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                )),
                RatingWidget(rating: feedBack!.rating!.toDouble()),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                ),
                Text(
                  feedBack?.content ?? 'No content',
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String _calculateRemainingTime(String? createdAt) {
    final formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');
    final createdAt = formatter.parse(feedBack?.createdAt ?? '');
    if (createdAt == null) {
      return 'Unknown';
    }

    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 365) {
      return '${difference.inDays ~/ 365} years ago';
    } else if (difference.inDays > 30) {
      return '${difference.inDays ~/ 30} months ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}
