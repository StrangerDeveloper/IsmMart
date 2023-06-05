import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage(
      {Key? key, required this.imageUrl, this.width, this.height, this.fit})
      : super(key: key);
  final String? imageUrl;
  final double? width, height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imageUrl ?? AppConstant.defaultImgUrl,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(
              strokeWidth: 0.5,
            )),
        errorWidget: (context, url, error) {
          print("CustomNetworkImage: $error");
          return Image.network(AppConstant.defaultImgUrl);
        }

        //const Icon(Icons.error, color: kRedColor,),
        );
  }
}
