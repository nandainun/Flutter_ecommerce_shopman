import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shopman/models/category_model.dart';

class ProductController extends GetxController {
  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var subcat = [];
  var totalPrice = 0.obs;

  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s = decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  // change color
  changeColorIndex(index) {
    colorIndex.value = index;
  }

  // increase and decrease quantity
  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  // calculate total price
  calculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }
}
