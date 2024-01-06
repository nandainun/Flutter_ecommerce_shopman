import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopman/consts/consts.dart';
import 'package:shopman/controllers/product_controller.dart';
import 'package:shopman/services/firestore_services.dart';
import 'package:shopman/view/category_screen/item_details.dart';
import 'package:shopman/widgets_common/bg_widget.dart';
import 'package:shopman/widgets_common/loading_indicator.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: title!.text.fontFamily(bold).white.make(),
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getProducts(title),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "No products found!".text.color(darkFontGrey).make(),
              );
            } else {
              var data = snapshot.data!.docs;

              return Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          controller.subcat.length,
                          (index) => "${controller.subcat[index]}"
                              .text
                              .size(14)
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .makeCentered()
                              .box
                              .white
                              .rounded
                              .size(150, 50)
                              .margin(
                                const EdgeInsets.symmetric(horizontal: 4),
                              )
                              .make(),
                        ),
                      ),
                    ),

                    20.heightBox,

                    // Items container
                    Expanded(
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisExtent: 250, crossAxisSpacing: 8, mainAxisSpacing: 8),
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                data[index]['p_imgs'][0],
                                height: 160,
                                width: 200,
                                fit: BoxFit.fill,
                              ),
                              10.heightBox,
                              "${data[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                              10.heightBox,
                              "\$ ${data[index]['p_price'].toString().numCurrency}"
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .size(16)
                                  .make()
                            ],
                          )
                              .box
                              .white
                              .roundedSM
                              .outerShadowSm
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .padding(const EdgeInsets.all(12))
                              .make()
                              .onTap(
                            () {
                              Get.to(
                                () => ItemDetails(title: "${data[index]['p_name']}", data: data[index]),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
