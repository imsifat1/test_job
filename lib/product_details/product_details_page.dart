// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_job/home_screen.dart';
import 'package:test_job/product_details/incrementBtn.dart';
import 'package:test_job/product_details/ratings.dart';
import 'package:test_job/storage_service.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Color color2 = Color(0xFFF56018);
Color color3 = Color(0xFFFD9667);
Color selectedColor = Color(0xFFFFF8EC);

class ProductDetailsPage extends StatelessWidget {
  String productName;
  String imageName;
  String desc;
  int productPrice;
  int beforeDiscount;
  ProductDetailsPage(
      {Key? key,
      required this.productName,
      required this.imageName,
      required this.desc,
      required this.productPrice,
      required this.beforeDiscount})
      : super(key: key);
  Storage storage = Storage();
  RxDouble ratingNumber = 3.0.obs;
  RxInt? _productSizeValue = 1.obs;
  RxInt? _productColorValue = 1.obs;
  RxInt sizePrice = 0.obs;
  RxInt colorPrice = 0.obs;

  RxInt totalPrice = 0.obs;
  RxInt totalDiscountPrice = 0.obs;
  // List<String> productSize = productSize;
  @override
  Widget build(BuildContext context) {
    totalPrice.value = productPrice;
    totalDiscountPrice.value = beforeDiscount;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          productName,
          style: const TextStyle(color: Colors.black),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios_new_rounded, color: color2),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: color2,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart_checkout_rounded,
                  color: Color(0xFFF56018)))
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            child: FutureBuilder(
                future: storage.downloadUrl(imageName),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Column(
                      children: [
                        Container(
                          child: Image.network(
                            snapshot.data!.toString(),
                            loadingBuilder: (context, child, loadingProgress) {
                              return loadingProgress == null
                                  ? child
                                  : Center(
                                      child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
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
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: size.width / 5,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: (() {}),
                                  icon: Icon(
                                    Icons.arrow_circle_left_rounded,
                                    color: color2,
                                  )),
                              Image.network(
                                snapshot.data!.toString(),
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  return loadingProgress == null
                                      ? child
                                      : Center(
                                          child: CircularProgressIndicator(
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
                              Spacer(),
                              IconButton(
                                  onPressed: (() {}),
                                  icon: Icon(
                                    Icons.arrow_circle_right_rounded,
                                    color: color2,
                                  ))
                            ],
                          ),
                        )
                      ],
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  return Container();
                }),
          ),
          const SizedBox(
            height: 10,
          ),

          const SizedBox(
            height: 20,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              productName,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Ratings(ratingNumber),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              desc,
              maxLines: 20,
              textAlign: TextAlign.justify,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              width: size.width * 0.9,
              child: const Divider(
                height: 20,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          ///------------------------------------------------------------------
          ///                             Product Price
          ///------------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Obx(
              () => RichText(
                text: TextSpan(
                    text: "৳" +
                        (totalPrice.value + sizePrice.value + colorPrice.value)
                            .toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    children: const [
                      WidgetSpan(
                          alignment: PlaceholderAlignment.baseline,
                          baseline: TextBaseline.alphabetic,
                          child: SizedBox(width: 10)),
                      TextSpan(
                          text: "৳800",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 15))
                    ]),
              ),
            ),
          ),

          Center(
            child: Container(
              width: size.width * 0.9,
              child: const Divider(
                height: 20,
                color: Colors.black,
              ),
            ),
          ),

          ///------------------------------------------------------------------
          ///                             Product Size
          ///------------------------------------------------------------------
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              "Size",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Container(
            height: size.height / 15,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: productSize.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ChoiceChip(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: color2, width: 0.7)),
                        selectedColor: selectedColor,
                        disabledColor: Color.fromARGB(255, 214, 211, 211),
                        label: Text('${productSize[index]["size"]}'),
                        selected: _productSizeValue?.value == index,
                        onSelected: (bool selected) {
                          _productSizeValue?.value = (selected ? index : null)!;
                          sizePrice.value = productSize[index]["price"] as int;
                          print(totalPrice);
                        },
                      ),
                    ),
                  );
                }),
          ),

          ///------------------------------------------------------------------
          ///                             Product Color
          ///------------------------------------------------------------------
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              "Color",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: size.height / 15,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: productColor.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ChoiceChip(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: color2, width: 0.7)),
                        selectedColor: selectedColor,
                        disabledColor: Color.fromARGB(255, 214, 211, 211),
                        label: Text('${productColor[index]["color"]}'),
                        selected: _productColorValue?.value == index,
                        onSelected: (bool selected) {
                          _productColorValue?.value =
                              (selected ? index : null)!;
                          colorPrice.value =
                              productColor[index]["price"] as int;
                          print(colorPrice);
                        },
                      ),
                    ),
                  );
                }),
          ),

          ///------------------------------------------------------------------
          ///                             Quantity
          ///------------------------------------------------------------------
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              "Quantity",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: stepper(),
          ),
          Center(
            child: Container(
              width: size.width * 0.9,
              child: const Divider(
                height: 20,
                color: Colors.black,
              ),
            ),
          ),

          ///------------------------------------------------------------------
          ///                             Buy now and add to cart btn
          ///------------------------------------------------------------------
          buy_add_to_cart_btn(context, size),

          ListTile(
            leading: Icon(
              Icons.message,
              color: color2,
            ),
            dense: true,
            minLeadingWidth: 0,
            horizontalTitleGap: 0,
            title: Text("Chat Now!"),
          ),
          ListTile(
            leading: Icon(
              Icons.favorite_border,
              color: color2,
            ),
            horizontalTitleGap: 0,
            minVerticalPadding: 0,
            dense: true,
            minLeadingWidth: 0,
            title: Text("Add to Wish List"),
          ),

          Center(
            child: Container(
              width: size.width * 0.9,
              child: const Divider(
                height: 20,
                color: Color.fromARGB(255, 85, 83, 83),
              ),
            ),
          ),

          ///------------------------------------------------------------------
          ///                             Delivery Option
          ///------------------------------------------------------------------

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              "Delivery Option",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.home),
            title: Text(
              "Home Delivery",
              style: TextStyle(color: Colors.grey),
            ),
            subtitle: Text("2 - 4 days", style: TextStyle(color: Colors.grey)),
          ),
          ListTile(
            trailing: Text(
              "৳100",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            title: Text(
              "Inside Dhaka",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ListTile(
            trailing: Text(
              "৳170",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            title: Text(
              "Outside Dhaka",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ListTile(
            leading: Icon(Icons.money),
            title: Text("Cash on Delivery Available"),
            subtitle: Text("Depend on shipping location"),
          ),

          Center(
            child: Container(
              width: size.width * 0.9,
              child: const Divider(
                height: 20,
                color: Color.fromARGB(255, 85, 83, 83),
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              "Product Condition",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.check_circle),
            title: Text(
              "100% new",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              "Return & Warranty",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.check_circle),
            title: Text(
              "100% Authentic",
              style: TextStyle(color: Colors.grey),
            ),
          ),

          Center(
            child: Container(
              width: size.width * 0.9,
              child: const Divider(
                height: 20,
                color: Color.fromARGB(255, 85, 83, 83),
              ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.warning_rounded),
            title: Text(
              "Product return not available",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ListTile(
            leading: Icon(Icons.warning_rounded),
            title: Text(
              "Warranty not available",
              style: TextStyle(color: Colors.grey),
            ),
          ),

          Center(
            child: Container(
              width: size.width * 0.9,
              child: const Divider(
                height: 20,
                color: Color.fromARGB(255, 85, 83, 83),
              ),
            ),
          ),
        ]),
      )),
    );
  }

  Row buy_add_to_cart_btn(BuildContext context, Size size) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: new Container(
            //width: 100.0,
            height: MediaQuery.of(context).size.height / 14,
            width: size.width / 3,
            decoration: new BoxDecoration(
              color: color3,
              border: new Border.all(color: Colors.white, width: 2.0),
              borderRadius: new BorderRadius.circular(
                  MediaQuery.of(context).size.height / 14 / 2),
            ),
            child: const Center(
              child: const Text(
                'Buy Now',
                style: const TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),

        ///------------------------------------------------------------------
        ///                            Add to Cart Button
        ///------------------------------------------------------------------

        GestureDetector(
          onTap: () {},
          child: new Container(
            //width: 100.0,
            height: MediaQuery.of(context).size.height / 14,
            width: size.width / 3,
            decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(color: color2, width: 2.0),
              borderRadius: new BorderRadius.circular(
                  MediaQuery.of(context).size.height / 14 / 2),
            ),
            child: new Center(
              child: new Text(
                'Add to Cart',
                style: new TextStyle(fontSize: 18.0, color: color2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
