import 'package:flutter/material.dart';
import 'package:ism_mart/utils/constants.dart';

class ProductQuantityCounter extends StatelessWidget {
  const ProductQuantityCounter(
      {Key? key,
      this.onDecrementPress,
      this.onIncrementPress,
      this.textEditingController, this.bgColor, this.textColor})
      : super(key: key);

  final VoidCallback? onDecrementPress;
  final VoidCallback? onIncrementPress;
  final TextEditingController? textEditingController;
  final Color? bgColor, textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor??kPrimaryColor,
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
            icon:  Icon(Icons.remove, color: textColor??kWhiteColor,),
          ),
          AppConstant.spaceWidget(width: 4),
          SizedBox(
            width: 30,
            height: 40,
            child: TextField(
              controller: textEditingController,
              enabled: false,
              style: bodyText1.copyWith(color: textColor??kWhiteColor, fontSize: 16),
              textAlignVertical: TextAlignVertical.center,
              decoration:  InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 12),
                  border: InputBorder.none,
                  hintText: '1',
                  hintStyle: bodyText1.copyWith(color: textColor??kWhiteColor, fontSize: 16)),
              textAlign: TextAlign.center,

              keyboardType: TextInputType.number,
            ),
          ),
          AppConstant.spaceWidget(width: 4),
          IconButton(
            iconSize: 18,
            alignment: Alignment.topCenter,
            onPressed: onIncrementPress,
            icon:  Icon(Icons.add,color: textColor??kWhiteColor),
          ),
        ],
      ),
    );
  }
}
