part of 'AddTurf_bloc.dart';

sealed class AddTurfEvent extends Equatable {
  const AddTurfEvent();

  @override
  List<Object> get props => [];
}

class PickImageEvent extends AddTurfEvent {}

class RemoveImageEvent extends AddTurfEvent {}
