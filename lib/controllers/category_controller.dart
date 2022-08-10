import 'dart:io';

import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';

class CategoryController extends GetxController {
  File? categoryImage;

  XFile? xfile;

  String editCategoryName = '';


  Future pickImage() async {
    final ImagePicker _picker = ImagePicker();

    xfile = await _picker.pickImage(source: ImageSource.gallery);

    if (xfile == null) {
      return;
    }

    categoryImage = File(xfile!.path);

    update();
  }


  addNul() {
    categoryImage = null;
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
    // categoryImage1!.delete();
  }
}
