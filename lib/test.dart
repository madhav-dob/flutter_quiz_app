import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image at Bottom Right',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ImageAtBottomRight(),
    );
  }
}

class ImageAtBottomRight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image at Bottom Right'),
      ),
      body: Stack(
        children: [
          // Your main content goes here
          Center(
            child: Text(
              'Your Main Content',
              style: TextStyle(fontSize: 24),
            ),
          ),
          // Image at bottom right
          Positioned(
            bottom: 20, // Adjust this value to position the image vertically
            right: 20, // Adjust this value to position the image horizontally
            child: Container(
              width: 100,
              height: 50,
              child: Image.asset(
                  "assets/logo.png"), // Replace with your image asset
            ),
          ),
        ],
      ),
    );
  }
}
