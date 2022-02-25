import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    home: home(),
  ));
}

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return colorSizeMethod(size);
  }
}

RxList<Map<String, dynamic>> addProductSize = RxList();
Map<String, dynamic> addSizeItem = Map();

String sizeItem = "";
int sizeItemPrice = 0;

Map<String, dynamic> addColorItem = Map();
RxList<Map<String, dynamic>> addProductColor = RxList();
String colorItem = "";
int colorItemPrice = 0;

Widget colorSizeMethod(Size size) {
  return Column(
    children: [
      ///------------------------------------------------------------------
      ///                             Add Size
      ///------------------------------------------------------------------

      productSizeMethod(),

      addProductSize == null
          ? Text("No Size available")
          : Obx(
              () => Container(
                height: size.height / 5,
                width: size.width,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: addProductSize.length,
                    itemBuilder: (context, index) {
                      var data = addProductSize[index];
                      return Text(
                        "size: " +
                            data["size"].toString() +
                            " price: " +
                            data["price"].toString(),
                      );
                    }),
              ),
            ),

      const SizedBox(
        height: 10,
      ),

      ///------------------------------------------------------------------
      ///                             Add Color
      ///------------------------------------------------------------------

      addColorMethod(),

      addProductColor == null
          ? Text("No Size available")
          : Obx(
              () => Container(
                height: size.height / 5,
                width: size.width,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: addProductColor.length,
                    itemBuilder: (context, index) {
                      var data = addProductColor[index];
                      return Text("color: " +
                          data["color"].toString() +
                          " price: " +
                          data["price"].toString());
                    }),
              ),
            ),
    ],
  );
}

Column productSizeMethod() {
  return Column(
    children: [
      TextFormField(
        onChanged: (value) {
          sizeItem = value;
        },
        // textAlign: TextAlign.justify,
        textAlignVertical: TextAlignVertical.center,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please Enter Something";
          }
          return null;
        },
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.message),
            hintText: "Product Color. Ex: Red ,black",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
      SizedBox(
        height: 10,
      ),
      TextFormField(
        onChanged: (value) {
          sizeItemPrice = int.parse(value);
        },
        // textAlign: TextAlign.justify,
        textAlignVertical: TextAlignVertical.center,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please Enter Something";
          }
          return null;
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.price_change),
            hintText: "Add Price for this size.",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
      MaterialButton(
        color: Colors.amber,
        onPressed: () {
          addSizeItem.addAll({"size": sizeItem, "price": sizeItemPrice});
          addProductSize.add(addSizeItem);
          // print(addSizeItem);
          print(addProductSize);
        },
        child: Text("Add"),
      )
    ],
  );
}

Column addColorMethod() {
  return Column(
    children: [
      TextFormField(
        onChanged: (value) {
          colorItem = value;
        },
        // textAlign: TextAlign.justify,
        textAlignVertical: TextAlignVertical.center,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please Enter Something";
          }
          return null;
        },
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.colorize),
            hintText: "Product Color. Ex: Red ,black",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
      SizedBox(
        height: 10,
      ),
      TextFormField(
        onChanged: (value) {
          colorItemPrice = int.parse(value);
        },
        // textAlign: TextAlign.justify,
        textAlignVertical: TextAlignVertical.center,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please Enter Something";
          }
          return null;
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.price_change),
            hintText: "Add Price for this size.",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
      MaterialButton(
        color: Colors.amber,
        onPressed: () {
          addColorItem.addAll({"color": colorItem, "price": colorItemPrice});
          // addProductColor.value = addColorItem.
          addProductColor.add(addColorItem);
          print(addColorItem);
          print(addProductColor);
        },
        child: Text("Add"),
      )
    ],
  );
}
