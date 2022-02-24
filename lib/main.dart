import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:test_job/storage_service.dart';
import 'package:firebase_storage/firebase_storage.dart' as fb_storage;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const GetMaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? path;
  String? fileName;

  Storage storage = Storage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test")),
      body: Column(children: [
        ElevatedButton(
            onPressed: () async {
              FilePickerResult? results = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  type: FileType.custom,
                  allowedExtensions: ["png", "jpg"]);
              if (results == null) {
                Get.snackbar("Warning", "No File Selected");
              }
              path = results?.files.single.path;
              fileName = results?.files.single.name;
              print(path);
              print(fileName);
            },
            child: Text("Select Photo")),
        ElevatedButton(
            onPressed: () {
              storage.uploadFile(path.toString(), fileName.toString()).then(
                  (value) => Get.snackbar(
                      "Congrats!", "Your $fileName has been uploaded."));
            },
            child: Text("Upload File")),
        FutureBuilder(
            future: storage.downloadUrl("corona.gif"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Container(
                  child: Image.network(snapshot.data!.toString()),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return Container();
            })
      ]),
    );
  }
}
