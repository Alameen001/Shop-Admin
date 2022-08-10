import 'package:admin_app/management%20system/product/widgets/build_text.dart';
import 'package:admin_app/management%20system/product/widgets/edit_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';

class ProductManagement extends StatelessWidget {
  const ProductManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Product Management'),
          backgroundColor: Colors.black,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('products').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final data = snapshot.data!.docs[index];

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.network(
                            // "https://contents.mediadecathlon.com/p1484240/ab565f3675dbdd7e3c486175e2c16583/p1484240.jpg",
                            snapshot.data!.docs[index]['image'],
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 40,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                BuildText(
                                  text: snapshot.data!.docs[index]['name'],
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                BuildText(
                                  text: snapshot.data!.docs[index]['category'],
                                  fontSize: 16,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                BuildText(
                                  text:
                                      "₹ ${snapshot.data!.docs[index]['price']}",
                                  fontSize: 16,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                BuildText(
                                  text:
                                      " Stock :${snapshot.data!.docs[index]['count']}",
                                  fontSize: 16,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              Get.bottomSheet(Container(
                                color: Colors.white,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: const Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                      ),
                                      title: const Text('Edit'),
                                      onTap: () {
                                        Get.back();
                                        // Get.to(
                                        //   EditProductScreen(
                                        //     productNameText: data['productName'],
                                        //     priceText: data['price'],
                                        //     sizeText: data['sizeOrVarient'],
                                        //     counText: data['count'],
                                        //     descriptionText: data['description'],
                                        //     doc: data.id,
                                        //     imageUrls: data['imageUrls'],
                                        //   ),
                                        //   transition: Transition.downToUp,
                                        // );
                                        Get.to(
                                          EditProductScreen(
                                              productNameText: data['name'],
                                              priceText:
                                                  data['price'].toString(),
                                              descriptionText:
                                                  data['description'],
                                              sizeText: data['size'],
                                              counText: data['count'],
                                              doc: data.id,
                                              imageUrls: [data['image']]),
                                        );
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        Icons.delete,
                                        color: Colors.black,
                                      ),
                                      title: Text('Delete'),
                                      onTap: () {
                                        Get.back();
                                        showAnimatedDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (BuildContext context) {
                                            return ClassicGeneralDialogWidget(
                                              titleText: 'Delete',
                                              contentText: 'Are you sure?',
                                              positiveText: 'YES',
                                              negativeText: 'NO',
                                              positiveTextStyle:
                                                  const TextStyle(
                                                color: Colors.green,
                                              ),
                                              negativeTextStyle:
                                                  const TextStyle(
                                                color: Colors.red,
                                              ),
                                              onPositiveClick: () {
                                                Navigator.of(context).pop();
                                                // Products.deleteProduct(data.id);
                                                FirebaseFirestore.instance
                                                    .collection('products')
                                                    .doc(data.id)
                                                    .delete();
                                              },
                                              onNegativeClick: () {
                                                Navigator.of(context).pop();
                                              },
                                            );
                                          },
                                          animationType:
                                              DialogTransitionType.slideFromTop,
                                          curve: Curves.fastOutSlowIn,
                                          duration: const Duration(seconds: 1),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ));
                            },
                            icon: Icon(Icons.more_vert),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 3,
                    ),
                    itemCount: snapshot.data!.docs.length,
                  ));
            })); //   );
    // }
    //   ),
    // );
  }
}
