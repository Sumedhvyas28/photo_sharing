import 'dart:io';
import 'package:flutter/material.dart';
import '../models/post_model.dart';
import 'package:intl/intl.dart';

class PostTile extends StatelessWidget {
  final PostModel post;

  const PostTile({super.key, required this.post});

  ColorFilter _getColorFilter(int index) {
    switch (index) {
      case 1:
        return ColorFilter.mode(
            Colors.purple.withOpacity(0.2), BlendMode.overlay);
      case 2:
        return ColorFilter.mode(
            Colors.blueAccent.withOpacity(0.2), BlendMode.overlay);
      case 3:
        return ColorFilter.mode(
            Colors.yellow.withOpacity(0.2), BlendMode.overlay);
      case 4:
        return ColorFilter.mode(
            Colors.green.withOpacity(0.2), BlendMode.overlay);
      default:
        return const ColorFilter.mode(Colors.transparent, BlendMode.multiply);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      color: Color(0xFFF9F1FE),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(post.profileAssetPath),
            ),
            title: Text(post.username,
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          // Filtered Image
          AspectRatio(
            aspectRatio: 1,
            child: ColorFiltered(
              colorFilter: _getColorFilter(post.filterIndex),
              child: Image.file(post.image, fit: BoxFit.cover),
            ),
          ),
          // Time
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              timeAgo(post.timestamp),
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }

  String timeAgo(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inHours < 1) return '${diff.inMinutes} minutes ago';
    if (diff.inHours < 24) return '${diff.inHours} hours ago';
    return DateFormat.yMMMd().format(time);
  }
}
