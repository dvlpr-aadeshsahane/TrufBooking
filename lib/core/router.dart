import 'package:go_router/go_router.dart';
import 'package:turfbooking/features/AddTurf/pages/AddTurf_screen.dart';
import 'package:turfbooking/features/Home/pages/Home_screen.dart';
import 'package:turfbooking/features/SplashScreen/pages/SplashScreen_screen.dart';

enum Routes { splashScreen, homeScreen, addTurfScreen }

GoRouter goRouter = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      name: Routes.splashScreen.name,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: "/Home",
      name: Routes.homeScreen.name,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: "/addTurfScreen",
      name: Routes.addTurfScreen.name,
      builder: (context, state) => AddTurfScreen(),
    ),
  ],
);
