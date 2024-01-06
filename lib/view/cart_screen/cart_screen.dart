import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopman/consts/consts.dart';
import 'package:shopman/controllers/cart_controller.dart';
import 'package:shopman/services/firestore_services.dart';
import 'package:shopman/widgets_common/loading_indicator.dart';
import 'package:shopman/widgets_common/our_button2.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping Cart".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "Cart is empty!".text.color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calculate(data);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image.network('${data[index]['img']}'),
                          title: "${data[index]['title']} (x${data[index]['qty']})"
                              .text
                              .fontFamily(semibold)
                              .size(16)
                              .make(),
                          subtitle:
                              "${data[index]['tprice']}".numCurrency.text.color(redColor).fontFamily(semibold).make(),
                          trailing: const Icon(
                            Icons.delete,
                            color: redColor,
                          ).onTap(() {
                            FirestoreServices.deleteDocument(data[index].id);
                          }),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total price".text.fontFamily(semibold).size(20).color(darkFontGrey).make(),
                      Obx(
                        () => "${controller.totalP.value}"
                            .numCurrency
                            .text
                            .fontFamily(semibold)
                            .size(20)
                            .color(redColor)
                            .make(),
                      ),
                    ],
                  )
                      .box
                      .padding(const EdgeInsets.all(12))
                      .width(context.screenWidth - 60)
                      .color(lightGolden)
                      .roundedSM
                      .make(),
                  10.heightBox,
                  SizedBox(
                    width: context.screenWidth - 60,
                    child:
                        ourButton2(color: redColor, onPress: () {}, textColor: whiteColor, title: "Proceed to payment"),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
