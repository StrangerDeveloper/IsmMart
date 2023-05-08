import 'package:flutter/material.dart';
import 'package:ism_mart/utils/constants.dart';

class ProductQuantityCounter extends StatelessWidget {
  ProductQuantityCounter(
      {Key? key,
      this.onDecrementPress,
      this.onIncrementPress,
      this.textEditingController,
      this.bgColor,
      this.textColor,
      this.w = 30.0,
      this.h = 40.0,
      this.horiz = 10.0,
      this.verti = 5.0,
      this.margin = 8.0,
      this.spaceW = 4.0,
      this.bottomP = 12.0})
      : super(key: key);

  final VoidCallback? onDecrementPress;
  final VoidCallback? onIncrementPress;
  final TextEditingController? textEditingController;
  final Color? bgColor, textColor;
  var w;
  var h;
  final horiz;
  final verti;
  final margin;
  final spaceW;
  final bottomP;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: margin),
      padding: EdgeInsets.symmetric(horizontal: horiz, vertical: verti),
      decoration: BoxDecoration(
        color: bgColor ?? kPrimaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      height: 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          AppConstant.spaceWidget(width: spaceW),
          SizedBox(
            width: w,
            height: h,
            child: TextField(
              controller: textEditingController,
              enabled: false,
              style: bodyText1.copyWith(
                  color: textColor ?? kWhiteColor, fontSize: 16),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: bottomP),
                  border: InputBorder.none,
                  hintText: '1',
                  hintStyle: bodyText1.copyWith(
                      color: textColor ?? kWhiteColor, fontSize: 16)),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
          ),
          AppConstant.spaceWidget(width: spaceW),
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
