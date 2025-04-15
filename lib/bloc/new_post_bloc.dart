import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'new_post_event.dart';
import 'new_post_state.dart';

class NewPostBloc extends Bloc<NewPostEvent, NewPostState> {
  final ImagePicker _picker = ImagePicker();

  NewPostBloc() : super(NewPostInitial()) {
    on<PickImagesEvent>((event, emit) async {
      final images = await _picker.pickMultiImage();
      if (images != null && images.isNotEmpty) {
        emit(NewPostImagesSelected(images, 0));
      }
    });

    on<SelectImageEvent>((event, emit) {
      if (state is NewPostImagesSelected) {
        final current = state as NewPostImagesSelected;
        final newImages = List<XFile>.from(current.images);
        final temp = newImages[0];
        newImages[0] = newImages[event.index];
        newImages[event.index] = temp;
        emit(NewPostImagesSelected(newImages, event.index));
      }
    });
  }
}
