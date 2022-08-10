// import 'package:admin_app/controllers/poster_controller.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';

// class BannerPosterAdd extends StatelessWidget {
//   BannerPosterAdd({Key? key}) : super(key: key);

//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Banner Add Poster"),
//         centerTitle: true,
//       ),
//       body: GetBuilder<Posterontroller>(builder: (controller) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(
//               height: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: GestureDetector(
//                 onTap: isLoading ? null : () => controller.pickImage(),
//                 child: controller.posterImage == null
//                     ? const Center(
//                         child: CircleAvatar(
//                           radius: 200,
//                           backgroundColor: Colors.white,
//                           backgroundImage: NetworkImage(
//                             'https://cdn.pixabay.com/photo/2016/01/03/00/43/upload-1118929_1280.png',
//                           ),
//                         ),
//                       )
//                     : Center(
//                         child: CircleAvatar(
//                           radius: 200,
//                           backgroundColor: Colors.white,
//                           backgroundImage: FileImage(controller.posterImage!),
//                         ),
//                       ),
//               ),
//             ),
//             const SizedBox(
//               height: 25,
//             ),
//             Center(
//               child: buildButton(context, controller),
//             ),
//           ],
//         );
//       }),
//     );
//   }

//   ElevatedButton buildButton(
//     BuildContext context,
//     Posterontroller posterontroller,
//   ) {
//     final mediaQuery = MediaQuery.of(context).size;

//     return ElevatedButton(
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all(Colors.black),
//       ),
//       onPressed: () async {
//         if (posterontroller.posterImage == " ") {
//           Get.snackbar("Add Poster Image", "");
//         } else {
//           FirebaseStorage storage = FirebaseStorage.instance;

//           TaskSnapshot taskSnapshot = await storage
//               .ref("image")
//               .child(posterontroller.posterImage!.path)
//               .putFile(posterontroller.posterImage!);

//           String BannerImagurl = await taskSnapshot.ref.getDownloadURL();

//           await FirebaseFirestore.instance.collection('Bannerposter').add({
//             "image": BannerImagurl,
//           });
//           // Get.to(PosterManagement1());
//           Get.back();
//         }
//       },
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//           vertical: mediaQuery.height * 0.017,
//           horizontal: mediaQuery.width * 0.25,
//         ),
//         child: isLoading
//             ? const CircularProgressIndicator()
//             : const Text(
//                 'Add Banner Poster',
//               ),
//       ),
//     );
//   }
// }
