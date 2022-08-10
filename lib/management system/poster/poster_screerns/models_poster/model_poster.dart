import 'package:admin_app/controllers/poster_controller.dart';
import 'package:admin_app/management%20system/poster/poster_screerns/models_poster/widgets/add_poster.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ModelsPosterManagement extends StatelessWidget {
  const ModelsPosterManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Posterontroller(), permanent: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Model Poster Management"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                Addposterscreen(name: 'poster',),
                transition: Transition.upToDown,
              );
            },
            icon: const Icon(
              CupertinoIcons.add_circled_solid,
            ),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('poster').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.separated(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data!.docs[index];
                  return Column(
                    children: [
                      Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(data['image']))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      IconButton(
                          onPressed: () {
                            Get.defaultDialog(
                              title: 'Delete',
                              textConfirm: "confirm",
                              textCancel: "cancel",
                              onConfirm: () {
                                FirebaseFirestore.instance
                                    .collection('poster')
                                    .doc(data.id)
                                    .delete();
                                     Get.back();
                              },
                              onCancel: () {
                                Get.back();
                              },

                            );
                          },
                          icon: Icon(Icons.delete,color: Colors.red,))
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemCount: snapshot.data!.docs.length);
          }),
    );
  }
}
