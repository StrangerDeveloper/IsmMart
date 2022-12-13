import 'package:flutter/material.dart';
import 'package:ism_mart/utils/constants.dart';

class ProductQuantityCounter extends StatelessWidget {
  const ProductQuantityCounter(
      {Key? key,
      this.onDecrementPress,
      this.onIncrementPress,
      this.textEditingController})
      : super(key: key);

  final VoidCallback? onDecrementPress;
  final VoidCallback? onIncrementPress;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: kPrimaryColor,
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
            icon: const Icon(Icons.remove, color: kWhiteColor,),
          ),
          AppConstant.spaceWidget(width: 4),
          SizedBox(
            width: 30,
            height: 40,
            child: TextField(
              controller: textEditingController,
              enabled: false,
              style: bodyText1.copyWith(color: kWhiteColor, fontSize: 16),
              textAlignVertical: TextAlignVertical.center,
              decoration:  InputDecoration(

                  contentPadding: EdgeInsets.only(bottom: 12),
                  border: InputBorder.none,
                  //fillColor: kWhiteColor,
                  //labelStyle: bodyText1.copyWith(color: kWhiteColor),
                  //filled: true,
                  hintText: '1',
                  hintStyle: bodyText1.copyWith(color: kWhiteColor, fontSize: 16)),
              textAlign: TextAlign.center,

              keyboardType: TextInputType.number,
            ),
          ),
          AppConstant.spaceWidget(width: 4),
          IconButton(
            iconSize: 18,
            alignment: Alignment.topCenter,
            onPressed: onIncrementPress,
            icon: const Icon(Icons.add,color: kWhiteColor),
          ),
        ],
      ),
    );
  }
}
