abstract class NewPostEvent {}

class PickImagesEvent extends NewPostEvent {}

class SelectImageEvent extends NewPostEvent {
  final int index;
  SelectImageEvent(this.index);
}
