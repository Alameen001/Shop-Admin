import 'package:admin_app/controllers/poster_controller.dart';
import 'package:admin_app/management%20system/poster/poster1.dart';
import 'package:admin_app/management%20system/poster/poster_screerns/models_poster/model_poster.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class Addposterscreen extends StatelessWidget {
  Addposterscreen({Key?  key, required this.name }) : super(key: key);

  String name;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Posterontroller posterontroller = Get.put(Posterontroller());
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Poster"),
        centerTitle: true,
      ),
      body: GetBuilder<Posterontroller>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: isLoading ? null : () => controller.pickImage(),
                child: controller.posterImage == null
                    ? const Center(
                        child: CircleAvatar(
                          radius: 200,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                            'https://cdn.pixabay.com/photo/2016/01/03/00/43/upload-1118929_1280.png',
                          ),
                        ),
                      )
                    : Center(
                        child: CircleAvatar(
                          radius: 200,
                          backgroundColor: Colors.white,
                          backgroundImage: FileImage(controller.posterImage!),
                        ),
                      ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Center(
                child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
              onPressed: () async {
                if (posterontroller.posterImage == " ") {
                  Get.snackbar("Add Poster Image", "");
                } else {
                  FirebaseStorage storage = FirebaseStorage.instance;

                  TaskSnapshot taskSnapshot = await storage
                      .ref("image")
                      .child(posterontroller.posterImage!.path)
                      .putFile(posterontroller.posterImage!);

                  String posterImagurl =
                      await taskSnapshot.ref.getDownloadURL();

                  await FirebaseFirestore.instance.collection(name).add({
                    "image": posterImagurl,
                  });
                  Get.to(PosterManagement1());
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 40,
                ),
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Add Poster',
                      ),
              ),
            )),
          ],
        );
      }),
    );
  }

  // ElevatedButton buildButton(
  //   BuildContext context,
  //   Posterontroller posterontroller,
  // ) {
  //

  //   return
  // }
}
