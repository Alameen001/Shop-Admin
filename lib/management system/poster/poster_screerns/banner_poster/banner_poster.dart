import 'package:admin_app/controllers/poster_controller.dart';
import 'package:admin_app/management%20system/poster/poster_screerns/banner_poster/widgets/banner_addposter.dart';
import 'package:admin_app/management%20system/poster/poster_screerns/models_poster/widgets/add_poster.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class BannerPoster extends StatelessWidget {
  const BannerPoster({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Posterontroller(), permanent: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Banner Poster"),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
               Addposterscreen(name: "Bannerposter"),
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
          stream:
              FirebaseFirestore.instance.collection('Bannerposter').snapshots(),
          builder: (context, snapshot) {
            DocumentSnapshot data = snapshot.data!.docs[0];
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                Container(
                  height: 500,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image:
                          DecorationImage(image: NetworkImage(data['image']))),
                )
              ],
            );
          }),
    );
  }
}
