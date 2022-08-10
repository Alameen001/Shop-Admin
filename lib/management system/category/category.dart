import 'package:admin_app/controllers/category_controller.dart';
import 'package:admin_app/management%20system/category/widgets/build_textfield.dart';
import 'package:admin_app/management%20system/category/widgets/show_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';

class CategoryManagement extends StatefulWidget {
  const CategoryManagement({Key? key}) : super(key: key);

  @override
  State<CategoryManagement> createState() => _CategoryManagementState();
}

class _CategoryManagementState extends State<CategoryManagement> {
  final TextEditingController categoryNamecontroller = TextEditingController();

  final TextEditingController editingController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  final formkey1 = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController(), permanent: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Category Management'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          buildAddCategory(context),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
        ],
      ),
    );
  }

// =========================================================================


//  displayCategories(CategoryController categoryController, db) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance.collection('Categories').snapshots(),
//       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(
//               backgroundColor: Colors.black,
//             ),
//           );
//         }

//     if (snapshot.data!.docs.isEmpty) {
//       return Center(
//         child: Text('Add categories'),
//       );
//     }

//     return ListView.separated(
//       physics: NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemBuilder: (context, index) {
//         // final data = snapshot.data!.docs[index];

//         return ListTile(
//           leading: CircleAvatar(
//             radius: 30,
//             backgroundColor: Colors.white,
//             foregroundImage: NetworkImage(
//               "https://m.media-amazon.com/images/I/71DBklVte9L._UX569_.jpg",
//             ),
//             child: const CircularProgressIndicator(
//               strokeWidth: 2,
//               backgroundColor: Colors.black,
//             ),
//           ),
//           title: Text("Category $index"),
//           trailing: IconButton(
//             onPressed: () {
//               Get.bottomSheet(Container(
//                 color: Colors.white,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     ListTile(
//                       leading: const Icon(
//                         Icons.edit,
//                         color: Colors.black,
//                       ),
//                       title: Text('Edit'),
//                       onTap: () {
//                         Get.back();
//                         Get.bottomSheet(Container(
//                           color: Colors.white,
//                           child: SingleChildScrollView(
//                             child: Container(
//                               // child: buildEditCategory(
//                               //   context,
//                               //   categoryController,
//                               // ),
//                             ),
//                           ),
//                         ));
//                       },
//                     ),
//                     ListTile(
//                       leading: const Icon(
//                         Icons.delete,
//                         color: Colors.black,
//                       ),
//                       title: Text('Delete'),
//                       onTap: () {
//                         Get.back();
//                         showAnimatedDialog(
//                           context: context,
//                           barrierDismissible: true,
//                           builder: (BuildContext context) {
//                             return ClassicGeneralDialogWidget(
//                               titleText: 'Delete',
//                               contentText: 'Are you sure?',
//                               positiveText: 'YES',
//                               negativeText: 'NO',
//                               positiveTextStyle: const TextStyle(
//                                 color: Colors.green,
//                               ),
//                               negativeTextStyle: const TextStyle(
//                                 color: Colors.red,
//                               ),
//                               onPositiveClick: () {
//                                 // Categories.deleteCategory(
//                                 //   data.id,
//                                 //   context,
//                                 //   data['categoryName'],
//                                 //   data['imageUrl'],
//                                 // );
//                                 Get.back();
//                               },
//                               onNegativeClick: () {
//                                 Navigator.of(context).pop();
//                               },
//                             );
//                           },
//                           animationType: DialogTransitionType.slideFromTop,
//                           curve: Curves.fastOutSlowIn,
//                           duration: const Duration(seconds: 1),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ));
//             },
//             icon: const Icon(
//               Icons.more_vert,
//             ),
//           ),
//         );
//       },
//       separatorBuilder: (context, index) => Divider(),
//       itemCount: 3,
//     );
//       },
//     );
//   }

// =============================================================================================
  Padding buildAddCategory(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GetBuilder<CategoryController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: isLoading ? null : () => controller.pickImage(),
              child: controller.categoryImage == null
                  ? const Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                          'https://cdn.pixabay.com/photo/2016/01/03/00/43/upload-1118929_1280.png',
                        ),
                      ),
                    )
                  : Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: FileImage(controller.categoryImage!),
                      ),
                    ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Enter a new category',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 5,
            ),
            CategoryTextField(
              controller: categoryNamecontroller,
              formKey: formkey,
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: buildButton(context, controller),
            ),
          ],
        );
      }),
    );
  }

  // ================================================================================
  ElevatedButton buildButton(
    BuildContext context,
    CategoryController categoryController,
  ) {
    final mediaQuery = MediaQuery.of(context).size;

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black),
      ),
      onPressed: () async {
        if (categoryNamecontroller.text == "" ||
            categoryController.categoryImage == "") {
          Get.snackbar("All Feilds are required", "");
        } else {
          FirebaseStorage storage = FirebaseStorage.instance;

          TaskSnapshot taskSnapshot = await storage
              .ref("image").child(categoryController.categoryImage!.path)
              .putFile(categoryController.categoryImage!);

          String dwonlodImgurl = await taskSnapshot.ref.getDownloadURL();

          await FirebaseFirestore.instance.collection("Category").add({
            "name": categoryNamecontroller.text,
            "image": dwonlodImgurl,
          });
          categoryNamecontroller.clear();
          Get.to(ShowCategory());
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: mediaQuery.height * 0.017,
          horizontal: mediaQuery.width * 0.25,
        ),
        child: isLoading
            ? const CircularProgressIndicator()
            : const Text(
                'Add a category',
              ),
      ),
    );
  }

  // =============================================================

  // buildEditCategory(
  //   BuildContext context,
  //   CategoryController categoryController,
  // ) {
  //   try {
  //     return Padding(
  //       padding: const EdgeInsets.all(15.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           const SizedBox(
  //             height: 10,
  //           ),
  //           GetBuilder<CategoryController>(builder: (controller) {
  //             return GestureDetector(
  //               onTap: () => categoryController.pickImage1(),
  //               child: controller.categoryImage1 == null
  //                   ? Center(
  //                       child: CircleAvatar(
  //                         radius: 50,
  //                         backgroundColor: Colors.white,
  //                         backgroundImage: NetworkImage(
  //                           "https://m.media-amazon.com/images/I/71DBklVte9L._UX569_.jpg",
  //                         ),
  //                       ),
  //                     )
  //                   : Center(
  //                       child: CircleAvatar(
  //                         radius: 50,
  //                         backgroundColor: Colors.white,
  //                         backgroundImage:
  //                             FileImage(categoryController.categoryImage1!),
  //                       ),
  //                     ),
  //             );
  //           }),
  //           const SizedBox(
  //             height: 10,
  //           ),
  //           const Text(
  //             'Enter a new category',
  //             style: TextStyle(fontSize: 16),
  //           ),
  //           const SizedBox(
  //             height: 5,
  //           ),
  //           Form(
  //             key: formkey1,
  //             child: TextFormField(
  //               initialValue: "Category",
  //               cursorColor: Colors.black,
  //               textAlignVertical: TextAlignVertical.center,
  //               keyboardType: TextInputType.name,
  //               style: TextStyle(
  //                 color: Colors.black,
  //                 fontSize: 17,
  //               ),
  //               onChanged: (text) {
  //                 categoryController.editedCategoryName(text);
  //                 print(text);
  //               },
  //               validator: (value) {
  //                 if (value!.isEmpty) {
  //                   return '*required';
  //                 }
  //                 return null;
  //               },
  //               decoration: InputDecoration(
  //                 hintText: 'eg. phone',

  //                 focusedErrorBorder: OutlineInputBorder(
  //                   borderSide: BorderSide(
  //                     color: Colors.red,
  //                     width: 1.5,
  //                   ),
  //                 ),
  //                 errorBorder: OutlineInputBorder(
  //                   borderSide: BorderSide(
  //                     color: Colors.red,
  //                     width: 1.5,
  //                   ),
  //                 ),

  //                 // hintStyle: TextStyle(color: Colors.black),
  //                 contentPadding: EdgeInsets.all(10),
  //                 // focusColor: Colors.amber,
  //                 enabledBorder: OutlineInputBorder(
  //                   borderSide: BorderSide(
  //                     color: Colors.black45,
  //                     width: 1.5,
  //                   ),
  //                 ),
  //                 focusedBorder: OutlineInputBorder(
  //                   borderSide: BorderSide(
  //                     color: Colors.black45,
  //                     width: 1.5,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           const SizedBox(
  //             height: 15,
  //           ),
  //           Center(
  //             child: buildEditButton(
  //               context,
  //               categoryController,
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   } catch (e) {
  //     print('mmmmm');
  //     print(e.hashCode);
  //   }
  // }

  // //===============================================================================================
  // buildEditButton(
  //   BuildContext context,
  //   CategoryController categoryController,
  // ) {
  //   final mediaQuery = MediaQuery.of(context).size;

  //   return ElevatedButton(
  //     style: ButtonStyle(
  //       backgroundColor: MaterialStateProperty.all(Colors.black),
  //     ),
  //     onPressed: () async {},
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(
  //         vertical: mediaQuery.height * 0.017,
  //         horizontal: mediaQuery.width * 0.25,
  //       ),
  //       child: const Text(
  //         'Edit Category',
  //         style: TextStyle(
  //           color: Colors.white,
  //           fontSize: 16,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
