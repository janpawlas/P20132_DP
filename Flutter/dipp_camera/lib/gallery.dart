import 'package:flutter/material.dart';
import 'main.dart' as globals;

class MyGalleryPage extends StatelessWidget{
  const MyGalleryPage({Key? key}) : super(key: key);
  final String title = "Gallery";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: GridView.count(  //implemmentace galerie
          crossAxisCount: 3,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          children: globals.capturedImages
            .map((image) => Image.file(image, fit: BoxFit.cover)) //namapování dat na políčka GridView
        .toList(),
        )
    );
  }
}
