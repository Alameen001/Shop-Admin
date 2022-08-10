import 'package:admin_app/Add%20product/add_product.dart';
import 'package:admin_app/controllers/add_product_controller.dart';
import 'package:admin_app/home/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

import 'widgets/dashboard_main_details.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  List<Color> colors = [
    Colors.red.shade900,
    Colors.blue.shade900,
    Colors.cyan.shade900,
  ];

  List<String> texts = [
    'Total Users',
    'Total Sales',
    'Total Orders',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          'Admin',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                AddProductScreen(),
                transition: Transition.upToDown,
              );
            },
            icon: const Icon(
              CupertinoIcons.add_circled_solid,
            ),
          )
        ],
      ),
      drawer: BuildDrawer(),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 200,
              child: DashBoardMainDetails(
                texts: texts,
                colors: colors,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
