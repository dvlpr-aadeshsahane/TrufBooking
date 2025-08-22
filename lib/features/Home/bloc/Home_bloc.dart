import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'Home_event.dart';
part 'Home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}