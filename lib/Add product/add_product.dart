import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_product_controller.dart';
import 'widgets/image_view.dart';
import 'widgets/text_form_field.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  // GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController productname = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController size = TextEditingController();
  TextEditingController count = TextEditingController();

  bool isLoading = false;

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
    SizedBox sizedBoxHeight = const SizedBox(
      height: 20,
    );

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          BuildTextFormField(
            hintText: 'Product Name',
            controller: productname,
          ),
          sizedBoxHeight,
          BuildTextFormField(
            hintText: 'Price',
            keyboardType: TextInputType.number,
            controller: price,
          ),
          sizedBoxHeight,
          Row(
            children: [
              const Text(
                'Images',
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
          BuildTextFormField(
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
                  hint: const Text('Select option'),
                  items: List.generate(
                    controller.categoryNames.length,
                    (index) => DropdownMenuItem(
                      child: Text(controller.categoryNames[index]),
                      value:  'Category $index'
                          
                    ),
                  ),
                  onChanged: (value) {
                    // print(value);
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
          BuildTextFormField(
            hintText: 'Size or varient',
            keyboardType: TextInputType.name,
            controller: size,
          ),
          sizedBoxHeight,
          BuildTextFormField(
            hintText: 'Stock Count',
            keyboardType: TextInputType.number,
            controller: count,
          ),
          sizedBoxHeight,
          ElevatedButton(
            onPressed: () async {
              if (productname.text == "" ||
                  price.text == "" ||
                  description.text == "" ||
                  size.text == "" ||
                  count.text == "") {
                Get.snackbar("All Feilds Are required", "");
              } else {
                FirebaseStorage storage = FirebaseStorage.instance;

                TaskSnapshot taskSnapshot = await storage
                    .ref("image")
                    .child(controller.imagefile1!.path)
                    .putFile(controller.imagefile1!);

                String Imgurl = await taskSnapshot.ref.getDownloadURL();

                Map<String, dynamic> data = {
                  "name": productname.text,
                  "price": int.parse(price.text),
                  "description": description.text,
                  "category": controller.categoryName,
                  "size": size.text,
                  "count": count.text,
                  "image": Imgurl,
                };
                FirebaseFirestore.instance
                    .collection('products')
                    .doc()
                    .set(data);
                productname.clear();
                price.clear();
                description.clear();
                size.clear();
                count.clear();
              }

              Get.back();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.02,
              ),
              child: isLoading
                  ? Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          CircularProgressIndicator(),
                          Text(
                            'Product Uploading',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const Text('Add product'),
            ),
          ),
          sizedBoxHeight,
        ],
      ),
    );
  }

  // ==================================================================
  buildImageLayout() {
    return GetBuilder<ProductAddController>(builder: (controller) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BuildImageView(
            imageFiles: controller.imagefile1,
            pickImage: controller.pickImage,
          ),
          // BuildImageView(
          //   imageFiles: controller.imagefile2,
          //   pickImage: controller.pickImage1,
          // ),
          // BuildImageView(
          //   imageFiles: controller.imagefile3,
          //   pickImage: controller.pickImage2,
          // )
        ],
      );
    });
  }

// ===================================================================
  AppBar buildAppbar() {
    return AppBar(
      backgroundColor: Colors.black,
    );
  }
}
