import 'package:flutter/material.dart';
import 'package:ism_mart/utils/constants.dart';

class ProductQuantityCounter extends StatelessWidget {
  const ProductQuantityCounter(
      {Key? key,
      this.onDecrementPress,
      this.onIncrementPress,
      this.textEditingController,
      this.bgColor,
      this.textColor,
      this.height = 40,
      this.width,
      this.quantity = "1",
      this.margin,
      this.padding})
      : super(key: key);

  final VoidCallback? onDecrementPress;
  final VoidCallback? onIncrementPress;
  final TextEditingController? textEditingController;
  final Color? bgColor, textColor;
  final double? height, width;
  final EdgeInsetsGeometry? margin, padding;
  final String? quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8),
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor ?? kPrimaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      width: width,
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            iconSize: 18,
            alignment: Alignment.topCenter,
            onPressed: onDecrementPress,
            icon: Icon(
              Icons.remove,
              color: textColor ?? kWhiteColor,
            ),
          ),
          AppConstant.spaceWidget(width: 4),
          SizedBox(
            width: 30,
            height: 30,
            child: TextField(
              controller: textEditingController,
              enabled: false,
              style: bodyText1.copyWith(
                  color: textColor ?? kWhiteColor, fontSize: 14),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                  border: InputBorder.none,
                  hintText: "$quantity",
                  hintStyle: bodyText1.copyWith(
                      color: textColor ?? kWhiteColor, fontSize: 16)),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
          ),
          AppConstant.spaceWidget(width: 4),
          IconButton(
            iconSize: 18,
            alignment: Alignment.topCenter,
            onPressed: onIncrementPress,
            icon: Icon(Icons.add, color: textColor ?? kWhiteColor),
          ),
        ],
      ),
    );
  }
}
