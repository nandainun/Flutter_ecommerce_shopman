import 'package:get/get.dart';
import 'package:shopman/consts/consts.dart';
import 'package:shopman/consts/list.dart';
import 'package:shopman/controllers/product_controller.dart';
import 'package:shopman/widgets_common/our_button2.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              color: darkFontGrey,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_outline,
              color: darkFontGrey,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Swiper section
                    VxSwiper.builder(
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      height: 350,
                      itemCount: data['p_imgs'].length,
                      viewportFraction: 1.0,
                      itemBuilder: (context, index) {
                        return Image.network(
                          data['p_imgs'][index],
                          width: double.infinity,
                          fit: BoxFit.fill,
                        );
                      },
                    ),

                    10.heightBox,

                    // title and details section
                    title!.text.size(16).color(darkFontGrey).fontFamily(semibold).make(),

                    10.heightBox,

                    // Rating section
                    VxRating(
                      isSelectable: false,
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: darkFontGrey,
                      selectionColor: golden,
                      count: 5,
                      maxRating: 5,
                      stepInt: true,
                    ),

                    10.heightBox,

                    "${data['p_price']}".toString().numCurrency.text.color(redColor).fontFamily(bold).size(18).make(),

                    10.heightBox,

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Seller".text.white.fontFamily(semibold).make(),
                              5.heightBox,
                              "${data['p_seller']}".text.fontFamily(semibold).color(darkFontGrey).make()
                            ],
                          ),
                        ),
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.message_rounded,
                            color: darkFontGrey,
                          ),
                        )
                      ],
                    )
                        .box
                        .height(65)
                        .color(textfieldGrey)
                        .padding(
                          const EdgeInsets.symmetric(horizontal: 16),
                        )
                        .make(),

                    20.heightBox,

                    // Color section
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Color: ".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children: List.generate(
                                  data['p_colors'].length,
                                  (index) => Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      VxBox()
                                          .size(40, 40)
                                          .roundedFull
                                          .color(Color(data['p_colors'][index]).withOpacity(1.0))
                                          .margin(
                                            const EdgeInsets.symmetric(horizontal: 4),
                                          )
                                          .make()
                                          .onTap(
                                        () {
                                          controller.changeColorIndex(index);
                                        },
                                      ),
                                      Visibility(
                                        visible: index == controller.colorIndex.value,
                                        child: Icon(
                                          Icons.done,
                                          color: Color(data['p_colors'][index]).computeLuminance() > 0.5
                                              ? Colors
                                                  .black // Jika warna latar belakang terang, gunakan warna ikon hitam
                                              : Colors
                                                  .white, // Jika warna latar belakang gelap, gunakan warna ikon putih
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),

                          // quantity row
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Quantity: ".text.color(textfieldGrey).make(),
                              ),
                              Obx(
                                () => Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        controller.decreaseQuantity();
                                        controller.calculateTotalPrice(data['p_price']);
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),
                                    controller.quantity.value.text.color(darkFontGrey).fontFamily(bold).make(),
                                    IconButton(
                                      onPressed: () {
                                        controller.increaseQuantity(data['p_quantity']);
                                        controller.calculateTotalPrice(data['p_price']);
                                      },
                                      icon: const Icon(Icons.add),
                                    ),
                                    10.widthBox,
                                    "(${data['p_quantity']})".text.color(textfieldGrey).make()
                                  ],
                                ),
                              )
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),

                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Total: ".text.color(textfieldGrey).make(),
                              ),
                              "${controller.totalPrice.value}"
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .size(16)
                                  .fontFamily(bold)
                                  .make()
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                        ],
                      ).box.white.shadowSm.make(),
                    ),

                    10.heightBox,

                    // Description section
                    "Description".text.color(darkFontGrey).fontFamily(semibold).make(),
                    10.heightBox,
                    "${data['p_desc']}".text.color(darkFontGrey).make(),

                    10.heightBox,

                    // Button section
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                        itemDetailButtonList.length,
                        (index) => ListTile(
                          title: itemDetailButtonList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                          trailing: const Icon(Icons.arrow_forward),
                        ),
                      ),
                    ),

                    20.heightBox,

                    // Product may like section
                    productsyoumaylike.text.fontFamily(bold).size(16).color(darkFontGrey).make(),

                    10.heightBox,

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          6,
                          (index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                imgP1,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                              10.heightBox,
                              "Laptop 4GB".text.fontFamily(semibold).color(darkFontGrey).make(),
                              10.heightBox,
                              "\$500".text.color(redColor).fontFamily(bold).size(16).make()
                            ],
                          )
                              .box
                              .white
                              .roundedSM
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .padding(const EdgeInsets.all(8))
                              .make(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ourButton2(
              color: redColor,
              onPress: () {},
              textColor: whiteColor,
              title: "Add to cart",
            ),
          )
        ],
      ),
    );
  }
}
