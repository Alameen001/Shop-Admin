import 'package:admin_app/Login/login_screen.dart';
import 'package:admin_app/Services/Auth_services.dart';
import 'package:admin_app/management%20system/category/category.dart';
import 'package:admin_app/management%20system/category/widgets/show_category.dart';

import 'package:admin_app/management%20system/order/order.dart';
import 'package:admin_app/management%20system/poster/poster_screerns/models_poster/model_poster.dart';
import 'package:admin_app/management%20system/poster/poster1.dart';
import 'package:admin_app/management%20system/product/product.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List textsIconsColorsFunctions = [
      {
        'text': 'Product Management',
        'icon': Icons.widgets_rounded,
        'function': () {
          Get.back();
          Get.to(
            ProductManagement(),
            transition: Transition.rightToLeft,
          );
        }
      },
      {
        'text': 'Category Management',
        'icon': Icons.category,
        'function': () {
          Get.back();
          Get.to(
            // CategoryManagement(),
            ShowCategory(),
            transition: Transition.rightToLeft,
          );
        }
      },
      {
        'text': 'Order Management',
        'icon': CupertinoIcons.cube_box_fill,
        'function': () {
          Get.back();
          Get.to(
            OrderManagement(),
            transition: Transition.rightToLeft,
          );
        }
      },
      {
        'text': 'Poster Management',
        'icon': Icons.photo,
        'function': () {
          Get.back();

          Get.to(
            PosterManagement1(),
            transition: Transition.rightToLeft,
          );
        }
      },
      {
        'text': 'Logout',
        'icon': Icons.logout_sharp,
        'function': () async {
          await AuthService().SignOut();
          Get.offUntil(
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
              (route) => false);
        }
      },
    ];

    return SafeArea(
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Management System',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ...List.generate(
              textsIconsColorsFunctions.length,
              (index) => ListTile(
                onTap: textsIconsColorsFunctions[index]['function'],
                leading: Icon(
                  textsIconsColorsFunctions[index]['icon'],
                  color: Colors.black,
                ),
                title: Text(
                  textsIconsColorsFunctions[index]['text'],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
