import 'package:go_router/go_router.dart';
import 'package:turfbooking/features/SplashScreen/pages/SplashScreen_screen.dart';

enum Routes { splashScreen }

GoRouter goRouter = GoRouter(routes: [
  GoRoute(path: "/",
  name: Routes.splashScreen.name,
  builder: (context, state) => SplashScreen(),
  )
]);
