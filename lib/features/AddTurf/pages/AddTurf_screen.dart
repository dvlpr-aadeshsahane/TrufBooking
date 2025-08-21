import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turfbooking/features/AddTurf/bloc/AddTurf_bloc.dart';

class AddTurfScreen extends StatefulWidget {
  const AddTurfScreen({super.key});

  @override
  State<AddTurfScreen> createState() => _AddTurfScreenState();
}

class _AddTurfScreenState extends State<AddTurfScreen> {
  late final AddTurfBloc bloc;
  final TextEditingController turfNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final List<String> sports = ["Cricket", "Football", "Badminton", "Hockey"];

  List<String> selectedSports = [];
  @override
  void initState() {
    super.initState();
    bloc = context.read<AddTurfBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Turf"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<AddTurfBloc, AddTurfState>(
              builder: (context, state) {
                if (state is PickImageLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                return state is PickImageSuccessState
                    ? Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 150,
                            width: double.infinity,

                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(File(state.imagePath)),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(width: 2),
                            ),
                          ),
                          Positioned(
                            right: -10,
                            top: -15,
                            child: IconButton.filled(
                              onPressed: () {
                                bloc.add(RemoveImageEvent());
                              },
                              icon: Icon(Icons.close),
                            ),
                          ),
                        ],
                      )
                    : GestureDetector(
                        onTap: () {
                          context.read<AddTurfBloc>().add(PickImageEvent());
                        },
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(width: 2),
                          ),
                          child: Icon(Icons.upload_file),
                        ),
                      );
              },
            ),
            const SizedBox(height: 16),

            // Turf Name
            TextField(
              controller: turfNameController,
              decoration: const InputDecoration(
                labelText: "Turf Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Phone Number
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Description
            TextField(
              controller: descController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Sports Type
            const Text(
              "Select Sports Type:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Column(
              children: sports.map((sport) {
                return CheckboxListTile(
                  title: Text(sport),
                  value: selectedSports.contains(sport),
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        selectedSports.add(sport);
                      } else {
                        selectedSports.remove(sport);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Price Field
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Price (per hour)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  debugPrint("Turf Name: ${turfNameController.text}");
                  debugPrint("Phone: ${phoneController.text}");
                  debugPrint("Description: ${descController.text}");
                  debugPrint("Sports: $selectedSports");
                  debugPrint("Price: ${priceController.text}");
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
