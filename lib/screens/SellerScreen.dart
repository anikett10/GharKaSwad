import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../models/food.dart'; // Assuming you have a Food model

class SellerScreen extends StatefulWidget {
  const SellerScreen({Key? key}) : super(key: key);

  @override
  _SellerScreenState createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  final _formKey = GlobalKey<FormState>();

  String _foodName = '';
  File? _image;
  double _calories = 0;
  double _cookingTime = 0;
  double _rating = 0;
  Future<void> _saveForm() async {
    if (_formKey.currentState!.validate()) {
      // Upload image to Firebase Storage
      final String imageFileName = '${DateTime.now()}.png'; // Generate a unique filename
      final firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('food_images')
          .child(imageFileName);

      await ref.putFile(_image!);

      // Get download URL of the uploaded image
      final String imageUrl = await ref.getDownloadURL();

      // Add food item to Firestore database
      await FirebaseFirestore.instance.collection('foods').add({
        'name': _foodName,
        'image': imageUrl,
        'calories': _calories,
        'cookingTime': _cookingTime,
        'rating': _rating,
        'reviews': 0,
        'isLiked': false,
      });

      // Clear form fields
      _formKey.currentState!.reset();
    }
  }

  Future<void> _selectImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seller Screen'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Food Items',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Food Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter food name';
                  }
                  return null;
                },
                onChanged: (value) {
                  _foodName = value;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _selectImage,
                child: Text('Select Image'),
              ),
              if (_image != null) ...[
                const SizedBox(height: 10),
                Image.file(_image!),
              ],
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Calories'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return 'Please enter valid calories';
                  }
                  return null;
                },
                onChanged: (value) {
                  _calories = double.parse(value);
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Cooking Time (min)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return 'Please enter valid cooking time';
                  }
                  return null;
                },
                onChanged: (value) {
                  _cookingTime = double.parse(value);
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Rating (In Rupees)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return 'Please enter valid rating';
                  }
                  return null;
                },
                onChanged: (value) {
                  _rating = double.parse(value);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text('Add Food Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
