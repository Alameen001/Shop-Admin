import 'package:admin_app/management%20system/category/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';

class ShowCategory extends StatelessWidget {
  const ShowCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("show Category"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                CategoryManagement(),
                transition: Transition.upToDown,
              );
            },
            icon: const Icon(
              CupertinoIcons.add_circled_solid,
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Category').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text('Add categories'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final data = snapshot.data!.docs[index];

                return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      foregroundImage: NetworkImage(
                        snapshot.data!.docs[index]['image'],
                      ),
                    ),
                    title: Text(snapshot.data!.docs[index]['name']),
                    trailing: Wrap(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.defaultDialog(
                              title: "Delete",
                              textConfirm: "Conform",
                              textCancel: "Cancel",
                              onConfirm: () {
                                FirebaseFirestore.instance
                                    .collection('Category')
                                    .doc(data.id)
                                    .delete();
                                Get.back();
                              },
                              onCancel: () {
                                Get.back();
                              },
                            );
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ));
              },
              separatorBuilder: (context, index) => Divider(),
            ),
          );
        },
      ),
    );
  }
}
