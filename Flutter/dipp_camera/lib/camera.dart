import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'main.dart' as globals;
import 'package:gallery_saver/gallery_saver.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.cameras}) : super(key: key);
  final List<CameraDescription> cameras;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  int selectedCamera = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
      ),
      body: Center(
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_controller!); //zobrazení náhledu kamery
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton( //tlačítko pro pořízení fotografie
        onPressed: () async { //metoda, která slouží pro pořízení a ukládání fotografie
          final stopwatch = Stopwatch()..start();
          await _initializeControllerFuture;
          final image = await _controller!.takePicture();
            globals.capturedImages.add(File(image.path));
            GallerySaver.saveImage(image.path);
          print('executed in ${stopwatch.elapsed}');
        },
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  void initState() {
    initializeCamera(selectedCamera);
    super.initState();
  }
  initializeCamera(int cameraIndex) async { //inicializace kamery, nastavení rozlišení
    _controller = CameraController(
      widget.cameras[cameraIndex],
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller!.initialize();
  }
  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}
