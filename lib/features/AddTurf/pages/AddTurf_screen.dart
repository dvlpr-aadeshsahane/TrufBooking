import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turfbooking/features/AddTurf/bloc/AddTurf_bloc.dart';

class AddTurfScreen extends StatelessWidget {
  AddTurfScreen({super.key});

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final descriptionController = TextEditingController();
  final sportsController = TextEditingController();
  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddTurfBloc>();

    return Scaffold(
      appBar: AppBar(title: Text("Add Turf")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image Picker
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
                            child: Icon(Icons.upload_file, size: 50),
                          ),
                        );
                },
              ),
              SizedBox(height: 20),

              // Form fields
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Turf Name"),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: "Phone"),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
              ),
              TextField(
                controller: sportsController,
                decoration: InputDecoration(labelText: "Sports Type"),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: "Price"),
              ),

              SizedBox(height: 20),

              // Submit Button
              BlocConsumer<AddTurfBloc, AddTurfState>(
                listener: (context, state) {
                  if (state is TurfSubmitSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Turf Added Successfully")),
                    );
                    Navigator.pop(context);
                  } else if (state is TurfSubmitErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error: ${state.error}")),
                    );
                  }
                },
                builder: (context, state) {
                  return FilledButton(
                    onPressed: () {
                      final currentState = bloc.state;
                      if (currentState is PickImageSuccessState) {
                        bloc.add(
                          SubmitTurfEvent(
                            turfName: nameController.text,
                            phone: phoneController.text,
                            description: descriptionController.text,
                            sports: sportsController.text,
                            price: priceController.text,
                            imageUrl: currentState.imagePath,
                          ),
                        );
                      }
                    },
                    child: state is TurfSubmittingState
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text("Submit"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
