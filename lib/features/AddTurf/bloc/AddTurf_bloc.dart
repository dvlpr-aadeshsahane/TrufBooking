import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'AddTurf_event.dart';
part 'AddTurf_state.dart';

class AddTurfBloc extends Bloc<AddTurfEvent, AddTurfState> {
  final ImagePicker _picker = ImagePicker();
  AddTurfBloc() : super(AddTurfInitial()) {
    on<PickImageEvent>(_pickImage);
    on<RemoveImageEvent>(_removeImage);
  }
  _pickImage(PickImageEvent event, Emitter emit) async {
    emit(PickImageLoadingState());
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        emit(PickImageSuccessState(imagePath: image.path));
      } else {
        emit(PickImageErrorState(error: "No image selected"));
      }
    } catch (e) {
      emit(PickImageErrorState(error: e.toString()));
    }
  }

  _removeImage(RemoveImageEvent event, Emitter emit) {
    emit(AddTurfInitial());
  }
}
