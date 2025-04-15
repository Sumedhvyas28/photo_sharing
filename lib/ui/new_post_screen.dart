import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_sharing_app/bloc/new_post_bloc.dart';
import 'package:photo_sharing_app/bloc/new_post_event.dart';
import 'package:photo_sharing_app/bloc/new_post_state.dart';
import '../widgets/filter_bar.dart';
import 'package:photo_sharing_app/ui/post_edit_screen.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewPostBloc(),
      child: const _NewPostView(),
    );
  }
}

class _NewPostView extends StatelessWidget {
  const _NewPostView({super.key});

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'New Post',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          BlocBuilder<NewPostBloc, NewPostState>(
            builder: (context, state) {
              return TextButton(
                onPressed: () {
                  if (state is NewPostImagesSelected &&
                      state.images.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostEditScreen(
                          imageFile: File(state.images[0].path),
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  'Next',
                  style: TextStyle(
                      color: Colors.deepPurple, fontWeight: FontWeight.w600),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<NewPostBloc, NewPostState>(
            builder: (context, state) {
              print('image');
              final preview =
                  (state is NewPostImagesSelected && state.images.isNotEmpty)
                      ? Image.file(
                          File(state.images[0].path),
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: Colors.grey[300],
                          child: Center(
                            child: Icon(Icons.image, size: 60),
                          ),
                        );
              return AspectRatio(aspectRatio: 1, child: preview);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<NewPostBloc>().add(PickImagesEvent());
                  },
                  child: Row(
                    children: [
                      Icon(Icons.photo_library,
                          size: 20, color: Colors.deepPurple),
                      SizedBox(width: 6),
                      Text(
                        "Open Gallery",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<NewPostBloc, NewPostState>(
              builder: (context, state) {
                if (state is NewPostImagesSelected) {
                  return GridView.builder(
                    padding: EdgeInsets.all(4),
                    itemCount: state.images.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemBuilder: (context, index) {
                      final imageFile = File(state.images[index].path);
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<NewPostBloc>()
                              .add(SelectImageEvent(index));
                        },
                        child: Image.file(imageFile, fit: BoxFit.cover),
                      );
                    },
                  );
                } else {
                  return Center(child: Text("No images selected."));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
