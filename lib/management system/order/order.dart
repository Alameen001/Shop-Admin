

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'widgets/build_products.dart';

class OrderManagement extends StatelessWidget {
  OrderManagement({Key? key}) : super(key: key);

  DateTime today =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  // DateTime oneDay = DateTime.now().subtract(const Duration(days: 1));
  DateTime lastWeek = DateTime.now().subtract(const Duration(days: 7));
  DateTime lastMonth = DateTime.now().subtract(const Duration(days: 30));
  DateTime testDate = DateTime.now().subtract(
    const Duration(days: 15),
  );

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    // final firestore = FirebaseFirestore.instance;

    int selectedIndex = 0;
    // Get.put(OrderController());

    List items = [
      'Accepted',
      'Shipped',
      'Delivered',
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        primary: true,
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text('Orders'),
        bottom: PreferredSize(
          preferredSize: Size(
            double.infinity,
            mediaQuery.height * 0.07,
          ),
          child: buildBottomItems(
            mediaQuery,
            items,
            selectedIndex,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          children: [
            // buildSelectDateRange(context),
            const SizedBox(
              height: 5,
            ),
            Expanded(
                // child: GetBuilder<OrderController>(builder: (orderController) {
                // if (orderController.isLoading) {
                //   return Center(
                //     child: CircularProgressIndicator(),
                //   );
                // }

                // if (orderController.sortedOrders.isEmpty) {
                //   return Center(
                //     child: Text('No Orders'),
                //   );
                // }

                // print(testDate.millisecondsSinceEpoch);
                // print(
                //     'TTTTTTTTTEEEEEEESSSSSSSSSTTTTTDDDDDDDDDAAAAAAAAAAAATTTTTTTTTTEEEEEEEEEEE');

                child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: 1,
              separatorBuilder: (context, index) => const SizedBox(
                height: 15,
              ),
              itemBuilder: (context, index) {
                // if (orderController.selectedValue == 'All') {
                //   orderController.getSortedOrders(
                //     checkingField: checkingOrder(orderController),
                //     date: 0,
                //   );
                // }

                return BuildProductViews(
                  orders: [],
                  index: index,
                );
              },
            )),
            // }))
          ],
        ),
      ),
    );
  }

// // ========================================================================================
// // This method is used to show the selecting date using range.

  
// ================================================================================================
// This method is used to show the appbar bottom property.

  Padding buildBottomItems(
    Size mediaQuery,
    List<dynamic> items,
    int selectedIndex,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: mediaQuery.height * 0.02),
      child: SizedBox(
        width: double.infinity,
        height: mediaQuery.height * 0.048,
        child: Padding(
          padding: EdgeInsets.only(
            left: mediaQuery.width * 0.02,
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(
                horizontal: mediaQuery.width * 0.02,
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: selectedIndex == index ? Colors.white : null,
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      items[index],
                      style: TextStyle(
                        color: selectedIndex == index
                            ? Colors.blue.shade800
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              // }),
            ),
          ),
        ),
      ),
    );
  }
}
  //======================================================================================================================================
  //This method is calling to check the appbar bottom items and return the condition list.
