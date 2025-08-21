import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'SplashScreen_event.dart';
part 'SplashScreen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(SplashScreenInitial()) {
    on<SplashScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}