import 'package:admin_app/management%20system/product/widgets/count_textfied.dart';
import 'package:admin_app/management%20system/product/widgets/description_textfield.dart';
import 'package:admin_app/management%20system/product/widgets/price_textfield.dart';
import 'package:admin_app/management%20system/product/widgets/product_textfield.dart';
import 'package:admin_app/management%20system/product/widgets/sizetextfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Add product/widgets/image_view.dart';
import '../../../controllers/add_product_controller.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen({
    Key? key,
    required this.productNameText,
    required this.priceText,
    required this.descriptionText,
    required this.sizeText,
    required this.counText,
    required this.doc,
    required this.imageUrls,
  }) : super(key: key);

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final String productNameText;
  final String priceText;
  final String descriptionText;
  final String sizeText;
  final String counText;
  final String doc;
  final List imageUrls;

  TextEditingController productname = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController size = TextEditingController();
  TextEditingController count = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductAddController());

    return Scaffold(
      appBar: buildAppbar(),
      body: productAdd(context, controller),
    );
  }

  // =================================================================================
  productAdd(BuildContext context, ProductAddController controller) {
    productname.text = productNameText;
    price.text = priceText;
    description.text = descriptionText;
    size.text = sizeText;
    count.text = counText;
    SizedBox sizedBoxHeight = const SizedBox(
      height: 20,
    );

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Form(
        key: formkey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ProductTextfield(
              hintText: 'Product Name',
              controller: productname,
            ),
            sizedBoxHeight,
            PriceTextfield(
              hintText: 'Price',
              keyboardType: TextInputType.number,
              controller: price,
            ),
            sizedBoxHeight,
            Text(
              'Already added images',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                buildalreadyaddedImages(imageUrls[0], context),
              ],
            ),
            sizedBoxHeight,
            Row(
              children: [
                const Text(
                  'Add images',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                GetBuilder<ProductAddController>(builder: (controller) {
                  return Text(
                    controller.validateText,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.red),
                  );
                }),
              ],
            ),
            sizedBoxHeight,
            buildImageLayout(),
            sizedBoxHeight,
            DescriptionTextfield(
              hintText: 'Description',
              maxLines: 8,
              controller: description,
              keyboardType: TextInputType.multiline,
            ),
            sizedBoxHeight,
            GetBuilder<ProductAddController>(
              builder: (controller) {
                controller.getCategories();

                try {
                  return DropdownButtonFormField<String>(
                    validator: (value) {
                      if (value == null) {
                        return '*required';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                    hint: Text('Select option'),
                    items: List.generate(
                      controller.categoryNames.length,
                      (index) => DropdownMenuItem(
                        child: Text(
                          controller.categoryNames[index],
                        ),
                        value: 'Category $index'
                      ),
                    ),
                    onChanged: (value) {
                      controller.selectedCategory(value!);
                    },
                  );
                } on RangeError catch (e) {
                  return Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text('0 categories'),
                    ),
                  );
                }
              },
            ),
            sizedBoxHeight,
            SizeTextfield(
              hintText: 'Size or varient',
              keyboardType: TextInputType.name,
              controller: size,
              doc: doc,
            ),
            sizedBoxHeight,
            CountTextfield(
              hintText: 'Stock Count',
              keyboardType: TextInputType.number,
              controller: count,
              doc: doc,
            ),
            sizedBoxHeight,
            ElevatedButton(
              onPressed: () async {
                FirebaseStorage storage = FirebaseStorage.instance;
                String? imgurl;
                print(controller.imagefile1?.path);
                if (controller.imagefile1?.path != null) {
                  TaskSnapshot taskSnapshot = await storage
                      .ref("image")
                      .child(controller.imagefile1!.path)
                      .putFile(controller.imagefile1!);

                  imgurl = await taskSnapshot.ref.getDownloadURL();
                } else {
                  imgurl = imageUrls[0];
                }
                Map<String, dynamic> data = {
                  "name": productname.text,
                  "price": int.parse(price.text),
                  "description": description.text,
                  "category": controller.categoryName,
                  "size": size.text,
                  "count": count.text,
                  "image": imgurl,
                };
                FirebaseFirestore.instance
                    .collection('products')
                    .doc(doc)
                    .update(data);
                // Get.back();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.02,
                ),
                child: const Text('Add product'),
              ),
            ),
            sizedBoxHeight,
          ],
        ),
      ),
    );
  }

  Container buildalreadyaddedImages(String url, BuildContext context) {
    final mediaquery = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: mediaquery.height * 0.2,
      width: mediaquery.width * 0.275,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(7),
          image: DecorationImage(
            image: NetworkImage(
              url,
            ),
            // fit: BoxFit.cover,
          )),
    );
  }

  // ==================================================================
  // This method is used to show the layout of the images..

  buildImageLayout() {
    return GetBuilder<ProductAddController>(builder: (controller) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BuildImageView(
            imageFiles: controller.imagefile1,
            pickImage: controller.pickImage,
          ),
        ],
      );
    });
  }

// ===================================================================
  AppBar buildAppbar() {
    return AppBar(
      backgroundColor: Colors.black,
      title: Text('Product editing screen'),
    );
  }

//

}
