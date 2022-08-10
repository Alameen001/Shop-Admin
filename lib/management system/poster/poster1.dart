import 'package:admin_app/management%20system/poster/poster_screerns/banner_poster/banner_poster.dart';
import 'package:admin_app/management%20system/poster/poster_screerns/models_poster/model_poster.dart';
import 'package:admin_app/management%20system/poster/poster_screerns/trailing_poster/trailingposter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class PosterManagement1 extends StatelessWidget {
  const PosterManagement1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("poster"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.lightBlue,
              ),
              child: ListTile(
                onTap: () {
                  Get.to(BannerPoster());
                },
                title: Center(child: Text("Baner Poster")),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.lightBlue,
              ),
              child: ListTile(
                onTap: () {
                  Get.to(ModelsPosterManagement());
                },
                title: Center(child: Text("Model Poster")),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.lightBlue,
              ),
              child: ListTile(
                title: Center(child: Text("Brand Poster")),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.lightBlue,
              ),
              child: ListTile(
                onTap: () {
                  Get.to(Trailingposter());
                },
                title: Center(child: Text("Trailing Poster")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
