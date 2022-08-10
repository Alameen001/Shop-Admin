import 'dart:io';

import 'package:admin_app/controllers/add_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildImageView extends StatelessWidget {
  BuildImageView({
    Key? key,
    required this.imageFiles,
    required this.pickImage,
  }) : super(key: key);

  File? imageFiles;
  final pickImage;

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => pickImage(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        height: mediaquery.height * 0.2,
        width: mediaquery.width * 0.275,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(7),
          image: imageFiles == null
              ? DecorationImage(
                  image: NetworkImage(
                    'https://store.magenest.com/wp/wp-content/uploads/2019/08/Magento-2-change-product-image-size-magenest.jpg',
                  ),
                  fit: BoxFit.cover,
                )
              : DecorationImage(
                  image: FileImage(imageFiles!),
                  // fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
