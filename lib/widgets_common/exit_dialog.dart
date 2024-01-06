import 'package:flutter/services.dart';
import 'package:shopman/consts/consts.dart';
import 'package:shopman/widgets_common/our_button.dart';

Widget exitDialog(context) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Are you sure want to exit?".text.size(16).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
                color: redColor,
                onPress: () {
                  SystemNavigator.pop();
                },
                textColor: whiteColor,
                title: "Yes"),
            ourButton(
                color: whiteColor,
                onPress: () {
                  Navigator.pop(context);
                },
                textColor: redColor,
                title: "No"),
          ],
        )
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}
