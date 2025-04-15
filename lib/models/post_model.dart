import 'dart:io';

class PostModel {
  final File image;
  final String username;
  final String profileAssetPath;
  final DateTime timestamp;
  final int filterIndex;

  PostModel({
    required this.image,
    required this.username,
    required this.profileAssetPath,
    required this.timestamp,
    this.filterIndex = 0,
  });
}
