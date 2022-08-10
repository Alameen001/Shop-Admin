
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

class BuildProductViews extends StatelessWidget {
  const BuildProductViews({
    Key? key,
    required this.orders,
    required this.index,
  }) : super(key: key);

  final int index;
  final List orders;

  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<OrderController>();

    // final map = orders[index];

    // final date = DateTime.fromMillisecondsSinceEpoch(map['createdDate']);

    // final formatedDate = DateFormat('MMM dd, hh:mm a').format(date);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "ladfjk",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  "ldfj",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            buildProductDetails(),
            SizedBox(
              height: 15,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            buildOrderStatusAndButton()
          ],
        ),
      ),
    );
  }

// =========================================================================================================
// This method is calling to show the status of order and show the update button.

  Row buildOrderStatusAndButton() {
    // List statusDetails = checkingOrderStatus(map);

    return Row(
      children: [
        Icon(
          Icons.circle,
          color: Colors.yellow,
          size: 17,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          "Ordered",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        Builder(builder: (context) {
          return OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            onPressed: () {},
            // onPressed: (controller.selectedIndex == 3 ||
            //         statusDetails[2] == 'Order completed')
            //     ? null
            //     : () {
            //         if (statusDetails[0] != 'Delivered') {
            //           OrderManage().updateOrder(
            //             docId: controller.orderId[index],
            //             fieldName: statusDetails[2],
            //             updateDateField: statusDetails[3],
            //             userToken: userToken,
            //             titleText: 'Order Updation !!',
            //             bodyText: statusDetails[5],
            //           );

            //           controller.removeOrderFromList(index);
            //         }
            //       },
            child: Text(
              "Shipped",
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          );
        })
      ],
    );
  }

// ========================================================
// This method is used to show the all product Details

  Row buildProductDetails() {
    // List checkingPaymentMethod = checkingOrderStatusPaymentMethod(map);

    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black12),
            image: DecorationImage(
              image: NetworkImage(
                "https://m.media-amazon.com/images/I/71DBklVte9L._UX569_.jpg",
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'productName',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              'TotalPrice : 12021',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue.shade500,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Qty : quantity',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            child: Text(
              "Paid",
              style: TextStyle(
                color: Colors.green,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }

  // Checking the appbar bottom changing then this function will call.
  // ===========================================================================

  Color changeColor(int index) {
    print(index);
    if (index == 0) {
      return Colors.red;
    } else if (index == 1) {
      return Colors.yellow;
    } else if (index == 2) {
      return Colors.green;
    }

    return Colors.white;
  }

// // ====================================================================
// // Checking the prdouct update text the the function will return a String value.

//   String changeText(int index) {
//     if (index == 0) {
//       return 'checking';
//     } else if (index == 1) {
//       return 'Shipped';
//     } else if (index == 2) {
//       return 'Delivered';
//     }

//     return 'Order completed';
//   }

// ========================================================================================
// This method checking the order status and return the status Value;

  List checkingOrderStatus(Map map) {
    final shipped = map['shipped'];
    final ordered = map['ordered'];
    final delivered = map['delivered'];

    if (ordered == true && shipped == false && delivered == false) {
      return [
        'Ordered',
        Colors.blue.shade500,
        'shipped',
        'shippedDate',
        Colors.yellowAccent,
        'Your product has been shipped'
      ];
    } else if (ordered == true && shipped == true && delivered == false) {
      return [
        'Shipped',
        Colors.yellow.shade500,
        'delivered',
        'deliveredDate',
        Colors.greenAccent,
        'Your product has been delivered'
      ];
    }

    return [
      'Delivered',
      Colors.green.shade500,
      'Order completed',
      'Order completed',
      Colors.white,
      'Your product has been completed'
    ];
  }

// ========================================================================================
// This method checking the order status payment method and return the status Value;

  List checkingOrderStatusPaymentMethod(Map map) {
    // final shipped = map['shipped'];
    // final ordered = map['ordered'];
    final delivered = map['delivered'];
    final paymentMethod = map['paymentMethod'];

    if (paymentMethod == 'Online Payment') {
      return ['PAID', Colors.green, Colors.green.shade100];
    } else if (delivered == true && paymentMethod == 'Cash On Delivery') {
      return ['PAID', Colors.green, Colors.green.shade100];
    }

    return ['UN PAID', Colors.red, Colors.red.shade100];
  }
}
