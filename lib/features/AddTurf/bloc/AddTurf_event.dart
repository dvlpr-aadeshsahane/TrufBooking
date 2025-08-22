part of 'AddTurf_bloc.dart';

sealed class AddTurfEvent extends Equatable {
  const AddTurfEvent();

  @override
  List<Object> get props => [];
}

class PickImageEvent extends AddTurfEvent {}

class RemoveImageEvent extends AddTurfEvent {}

class SubmitTurfEvent extends AddTurfEvent {
  final String turfName;
  final String phone;
  final String description;
  final sports;
  final String price;
  final String imageUrl;

  SubmitTurfEvent({
    required this.turfName,
    required this.phone,
    required this.description,
    required this.sports,
    required this.price,
    required this.imageUrl,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
    turfName,
    phone,
    description,
    sports,
    price,
    imageUrl,
  ];
}
