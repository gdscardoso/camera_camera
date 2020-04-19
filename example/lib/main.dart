import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:example/image_utils.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File file;
  File fileNew;

  converteToBase64() async {
    try {
      fileNew = await parseImage(file);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Camera Sample")),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera_alt),
          onPressed: () async {
            file = await showDialog(
                context: context,
                builder: (context) => Camera(
                      mode: CameraMode.fullscreen,
                      orientationEnablePhoto: CameraOrientation.all,
                      imageMask: CameraFocus.circle(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ));
            setState(() {});
          }),
      body: Column(
        children: <Widget>[
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.3,
              child: file != null
                  ? Image.file(
                      file,
                      fit: BoxFit.contain,
                    )
                  : Text("Tire a foto"),
            ),
          ),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.3,
              child: fileNew != null
                  ? Image.file(
                      fileNew,
                      fit: BoxFit.contain,
                    )
                  : Text("Tire a foto"),
            ),
          ),
          RaisedButton(
            onPressed: converteToBase64,
            color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "base64",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
