import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatefulWidget {
  final List<File> images;

  ImageViewer({required this.images});

  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40), // AppBarの高さを設定
        child: AppBar(
          title: Text('ページ： ${currentIndex + 1} / ${widget.images.length}',
              style: TextStyle(fontSize: 14)),
          centerTitle: true,
        ),
      ),
      body: PageView.builder(
        itemCount: widget.images.length,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return PhotoView(
            imageProvider: FileImage(widget.images[index]),
          );
        },
      ),
    );
  }
}
