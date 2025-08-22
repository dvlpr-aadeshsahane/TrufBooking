import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turfbooking/features/AddTurf/pages/AddTurf_screen.dart';
import 'package:turfbooking/features/AddTurf/repository/AddTurf_repository.dart';

import '../../../core/const/globalObj.dart';

part 'AddTurf_event.dart';
part 'AddTurf_state.dart';

class AddTurfBloc extends Bloc<AddTurfEvent, AddTurfState> {
  TurfRepository repository;
  final ImagePicker _picker = ImagePicker();
  AddTurfBloc(this.repository) : super(AddTurfInitial()) {
    on<PickImageEvent>(_pickImage);
    on<RemoveImageEvent>(_removeImage);
  }
  _pickImage(PickImageEvent event, Emitter emit) async {
    emit(PickImageLoadingState());
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        // ✅ call repository upload function with single image
        final urls = await repository.uploadCompressedImages([image.path]);

        // Since it's a single image, we can take the first URL
        final uploadedUrl = urls.first;

        emit(PickImageSuccessState(imagePath: uploadedUrl));
      } else {
        emit(PickImageErrorState(error: "No image selected"));
      }
    } catch (e, s) {
      logger.e("PICK IMAGE + UPLOAD", error: e, stackTrace: s);
      emit(PickImageErrorState(error: e.toString()));
    }
  }

  _removeImage(RemoveImageEvent event, Emitter emit) {
    emit(AddTurfInitial());
  }

  Future<void> _submitTurf(SubmitTurfEvent event, Emitter emit) async {
    emit(TurfSubmittingState());
    try {
      repository.saveTurf(
        name: event.turfName,
        phone: event.phone,
        description: event.description,
        price: event.price,
        imageUrl: event.imageUrl,
        sports: event.sports,
      );
      emit(TurfSubmitSuccessState());
    } catch (e) {
      emit(TurfSubmitErrorState(error: e.toString()));
    }
  }
}
