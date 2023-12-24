import 'package:shopman/consts/consts.dart';

Widget ourButton2({onPress, color, textColor, String? title}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.all(12),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Setel sudut kotak di sini
      ),
    ),
    onPressed: onPress,
    child: title!.text.color(textColor).fontFamily(bold).make(),
  );
}
