import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_job/home_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as fb_storage;

RxList<Map<String, dynamic>> addProductSize = RxList();

String sizeItem = "";
int sizeItemPrice = 0;

RxList<Map<String, dynamic>> addProductColor = RxList();
String colorItem = "";
int colorItemPrice = 0;

Future<dynamic> AddProducts(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  return showDialog(
      context: context,
      builder: (context) {
        Size size = MediaQuery.of(context).size;
        return AlertDialog(
          title: Text("Add Products!"),
          content: Container(
              child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    onChanged: (value) {
                      name = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Something";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_rounded),
                        hintText: "Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      price = int.parse(value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Something";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_rounded),
                        hintText: "Price",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      beforeDiscount = int.parse(value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Something";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_rounded),
                        hintText: "Without Discount Price",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      description = value;
                    },
                    // textAlign: TextAlign.justify,
                    textAlignVertical: TextAlignVertical.center,

                    minLines: 3,
                    maxLines: 20,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Something";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.message),
                        hintText: "Description...",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  ///------------------------------------------------------------------
                  ///                             Add Size and color
                  ///------------------------------------------------------------------
                  colorSizeMethod(size),

                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        FilePickerResult? results = await FilePicker.platform
                            .pickFiles(
                                allowMultiple: false,
                                type: FileType.custom,
                                allowedExtensions: ["png", "jpg"]);
                        if (results == null) {
                          Get.snackbar("Warning", "No File Selected");
                        }
                        path = results?.files.single.path;
                        fileName = results?.files.single.name;
                        imageName = fileName;
                        print(path);
                        print(fileName);
                      },
                      child: Text("Select Photo")),
                  SizedBox(
                    height: 5,
                  ),
                  fileName == null
                      ? Text("No Photo Select Yet!")
                      : Text(fileName.toString()),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                      color: Colors.orange,
                      child: Text("Upload"),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Get.snackbar(
                              "Messege!", "Sending data to firestore.");
                          storage
                              .uploadFile(path.toString(), fileName.toString())
                              .then((value) => Get.snackbar("Congrats!",
                                  "Your $fileName has been uploaded."));
                          uploadProducts
                              .add({
                                "name": name,
                                "price": price,
                                "desc": description,
                                "image": imageName,
                                "productSize": addProductSize,
                                "color": addProductColor
                              })
                              .then((value) => Get.snackbar("Congrats",
                                  "Your $name Product has been uploaded"))
                              .catchError((error) =>
                                  print("Failed to add product due to $error"));
                          Navigator.pop(context);
                        }
                      })
                ],
              ),
            ),
          )),
        );
      });
}

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
                height: size.height / 10,
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
                height: size.height / 10,
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

///------------------------------------------------------------------
///                             Add Size Method
///------------------------------------------------------------------

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
            hintText: "Size. Ex: S ,M,L",
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
          addProductSize.add({"size": sizeItem, "price": sizeItemPrice});
          // print(addSizeItem);
          print(addProductSize);
        },
        child: Text("Add"),
      )
    ],
  );
}

///------------------------------------------------------------------
///                             Add Color method
///------------------------------------------------------------------

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
            hintText: "Add Price for this color.",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
      MaterialButton(
        color: Colors.amber,
        onPressed: () {
          // addProductColor.value = addColorItem.
          addProductColor.add({"color": colorItem, "price": colorItemPrice});
          // print(addColorItem);
          print(addProductColor);
        },
        child: Text("Add"),
      )
    ],
  );
}
