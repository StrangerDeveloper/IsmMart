import 'package:flutter/material.dart';
import 'custom_network_image.dart';
import 'dart:io';

class SingleImageView extends StatelessWidget {
  const SingleImageView({Key? key, this.imageUrlOrPath, this.url = true}) : super(key: key);
  final String? imageUrlOrPath;
  final bool url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
    child: Container(
    width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: InteractiveViewer(
        minScale: 0.1,
        maxScale: 2.0,
        child: url ? CustomNetworkImage(imageUrl: imageUrlOrPath,
          fit: BoxFit.contain,) : Image.file(
          File(imageUrlOrPath.toString())
        ),
      ),
    ),
    ),
    );
  }
}
