import 'package:flutter/material.dart';
import 'custom_network_image.dart';

class SingleImageView extends StatelessWidget {
  const SingleImageView({Key? key, this.imageUrlOrPath}) : super(key: key);
  
  final String? imageUrlOrPath;
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
        child: CustomNetworkImage(imageUrl: imageUrlOrPath,
          fit: BoxFit.contain,),
      ),
    ),
    ),
    );
  }
}
