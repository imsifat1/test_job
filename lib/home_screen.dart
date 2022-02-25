import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as fb_storage;
import 'package:test_job/add_products/add_products.dart';
import 'package:test_job/product_details/product_details_page.dart';
import 'package:test_job/storage_service.dart';

import 'add_products/display_products.dart';

Stream<QuerySnapshot> Products =
    FirebaseFirestore.instance.collection("Products").snapshots();
CollectionReference uploadProducts =
    FirebaseFirestore.instance.collection("Products");
String? path;
String? fileName;

///---------Product Info-------------

String? name;
int price = 0;
int beforeDiscount = 0;
String? description;
String? imageName;
late var productSize;
late var productColor;

Storage storage = Storage();

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Job"),
        backgroundColor: color2,
        actions: [
          Tooltip(
            message: "Add Products!",
            child: IconButton(
                onPressed: () {
                  AddProducts(context);
                },
                icon: Icon(Icons.add)),
          )
        ],
      ),
      body: SingleChildScrollView(
        ///-------------------------------DIsplay Products here------------------------------------
        child: DisplayProducts(size),
      ),
    );
  }
}
