import 'package:flutter/material.dart';
import 'package:turfbooking/core/const/colorpallate.dart';
import 'package:turfbooking/core/router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.green,
        child: Icon(Icons.add),
        onPressed: () {
          goRouter.pushNamed(Routes.addTurfScreen.name);
        },
      ),
      appBar: AppBar(
        title: Text("Admin Panel"),
        backgroundColor: AppColors.green,
      ),
      body: Center(
        child: Text(
          'Add Turf By Admin',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
