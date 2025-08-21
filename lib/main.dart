import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turfbooking/core/router.dart';
import 'package:turfbooking/features/auth/bloc/auth_bloc.dart';
import 'package:turfbooking/features/auth/repository/auth_repository.dart';
import 'package:turfbooking/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const TurfBooking());
}

class TurfBooking extends StatelessWidget {
  const TurfBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 814),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(AuthRepository())),
        ],
        child: MaterialApp.router(
          routerConfig: goRouter,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
