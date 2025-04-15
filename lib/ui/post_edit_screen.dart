import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_sharing_app/data/post_data.dart';
import 'package:photo_sharing_app/models/post_model.dart';
import 'package:photo_sharing_app/ui/home_screen.dart';
import '../widgets/filter_bar.dart';

class PostEditScreen extends StatefulWidget {
  final File imageFile;

  const PostEditScreen({super.key, required this.imageFile});

  @override
  State<PostEditScreen> createState() => _PostEditScreenState();
}

class _PostEditScreenState extends State<PostEditScreen> {
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

  final List<String> filters = [
    "Browse",
    "Filter 1",
    "Filter 2",
    "Filter 3",
    "Filter 4",
  ];

  int selectedFilterIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('New Post',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ColorFiltered(
              colorFilter: _getColorFilter(selectedFilterIndex),
              child: Image.file(widget.imageFile, fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 16),
          FilterBar(
            filters: filters,
            selectedIndex: selectedFilterIndex,
            onFilterSelected: (index) {
              setState(() {
                selectedFilterIndex = index;
                //
              });
            },
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  postList.insert(
                    0,
                    PostModel(
                      image: widget.imageFile,
                      username: 'Sumedh Vyas',
                      profileAssetPath: 'assets/images/user.png',
                      timestamp: DateTime.now(),
                      filterIndex: selectedFilterIndex,
                    ),
                  );

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFDA90F9),
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Next",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
