




import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Posterontroller extends GetxController {
  File? posterImage;
  File? posterImage1;
  XFile? xfile;
  XFile? xFile1;
  String editCategoryName = '';


  Future pickImage() async {
    final ImagePicker _picker = ImagePicker();

    xfile = await _picker.pickImage(source: ImageSource.gallery);

    if (xfile == null) {
      return;
    }

    posterImage = File(xfile!.path);

    update();
  }

  Future pickImage1() async {
    final ImagePicker _picker = ImagePicker();

    xFile1 = await _picker.pickImage(source: ImageSource.gallery);

    if (xFile1 == null) {
      return;
    }

    posterImage1 = File(xFile1!.path);
    update();
  }

  addNul() {
    posterImage = null;
    update();
  }

  addNul1() {
    posterImage1 = null;
    update();
  }

  editedCategoryName(String name) {
    editCategoryName = name;
    update();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // categoryImage!.delete();
    posterImage1!.delete();
  }
}
