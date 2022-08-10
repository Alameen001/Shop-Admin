import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';

class ProductAddController extends GetxController {
  File? imagefile1;
  // File? imagefile2;
  // File? imagefile3;
  XFile? xFile1;
  XFile? xFile2;
  XFile? xFile3;
  List categoryNames = [];
  String categoryName = 'color';
  String validateText = '';

  getCategories() async {
    final document =
        await FirebaseFirestore.instance.collection("Category").get();

    categoryNames = document.docs
        .map(
          (e) => e.get('name'),
        )
        .toList();

    update();
  }

  selectedCategory(String text) {
    var index = text.split(" ").last.toString();
    categoryName = categoryNames[int.parse(index)];
    print(categoryName);
    update();
  }

// =====================================================================
// This method is used to image pick from gallery and store firebase.

  Future pickImage() async {
    final ImagePicker _picker = ImagePicker();

    xFile1 = await _picker.pickImage(source: ImageSource.gallery);

    if (xFile1 == null) {
      return;
    }
    File file = File(xFile1!.path);

    imagefile1 = file;
    update();
  }

// //
}
