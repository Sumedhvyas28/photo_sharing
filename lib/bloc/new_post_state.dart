import 'package:image_picker/image_picker.dart';

abstract class NewPostState {}

class NewPostInitial extends NewPostState {}

class NewPostImagesSelected extends NewPostState {
  final List<XFile> images;
  final int selectedIndex;

  NewPostImagesSelected(this.images, this.selectedIndex);
}
