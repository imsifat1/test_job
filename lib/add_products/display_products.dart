import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as fb_storage;
import 'package:get/get.dart';
import 'package:test_job/home_screen.dart';
import 'package:test_job/product_details/product_details_page.dart';

StreamBuilder<QuerySnapshot<Object?>> DisplayProducts(Size size) {
  return StreamBuilder<QuerySnapshot>(
      stream: Products,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else {
          QuerySnapshot<Object?> data = snapshot.requireData;
          return Container(
            height: size.height,
            width: size.width,
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: data.size,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => ProductDetailsPage(
                          productName: name.toString(),
                          imageName: imageName.toString(),
                          desc: description.toString(),
                          productPrice: price,
                          beforeDiscount: beforeDiscount,
                        ));
                    name = data.docs[index]["name"];
                    imageName = data.docs[index]["image"];
                    price = data.docs[index]["price"];
                    description = data.docs[index]["desc"];
                    productSize = data.docs[index]['productSize'];
                    productColor = data.docs[index]['color'];
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: FutureBuilder(
                              future: storage
                                  .downloadUrl(data.docs[index]["image"]),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    snapshot.hasData) {
                                  return Center(
                                    child: Image.network(
                                      snapshot.data!.toString(),
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        return loadingProgress == null
                                            ? child
                                            : Center(
                                                child:
                                                    CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ));
                                        // : LinearProgressIndicator();
                                      },
                                    ),
                                  );
                                }
                                if (snapshot.connectionState ==
                                        ConnectionState.waiting ||
                                    !snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  );
                                }
                                return Container();
                              }),
                        ),
                        Text(
                          data.docs[index]["name"],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Price: " + data.docs[index]["price"].toString(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      });
}
