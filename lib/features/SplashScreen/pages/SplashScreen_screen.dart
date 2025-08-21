import 'package:flutter/material.dart';
import 'package:turfbooking/core/router.dart';

changeScreen() {
  Future.delayed(Duration(seconds: 3), () {
    goRouter.goNamed(Routes.homeScreen.name);
  });
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    changeScreen();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.network(
          "https://dcassetcdn.com/design_img/4077360/831606/33601427/qe0xca9zb3kkny24ebb8jepbx5_image.jpg",
        ),
      ),
    );
  }
}
