part of 'AddTurf_bloc.dart';

sealed class AddTurfState extends Equatable {
  const AddTurfState();

  @override
  List<Object> get props => [];
}

final class AddTurfInitial extends AddTurfState {}

class PickImageStates extends AddTurfState {}

class PickImageLoadingState extends PickImageStates {}

class PickImageSuccessState extends PickImageStates {
  final String imagePath;

  PickImageSuccessState({required this.imagePath});
  @override
  List<Object> get props => [imagePath];
}

class PickImageErrorState extends PickImageStates {
  final String error;
  final DateTime _dateTime = DateTime.now();
  PickImageErrorState({required this.error});
  @override
  List<Object> get props => [error, _dateTime];
}
