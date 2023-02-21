import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class ShowPickedImagesList extends StatelessWidget {
  const ShowPickedImagesList({Key? key, this.pickedImagesList})
      : super(key: key);
  final List<File>? pickedImagesList;

  @override
  Widget build(BuildContext context) {
    return _showImages();
  }

  _showImages() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: pickedImagesList!.length,
      itemBuilder: (_, index) {
        File? file = pickedImagesList![index];
        return Container(
          width: 70,
          margin: EdgeInsets.all(5),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.file(file),
              Positioned(
                right: 0,
                child: CustomActionIcon(
                  width: 25,
                  height: 25,
                  onTap: () {
                    pickedImagesList!.removeAt(index);
                    //pickedImagesList!.refresh();
                  },
                  hasShadow: false,
                  icon: Icons.close_rounded,
                  bgColor: kPrimaryColor.withOpacity(0.2),
                  iconColor: kPrimaryColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
