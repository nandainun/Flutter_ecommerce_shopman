import 'package:shopman/consts/consts.dart';
import 'package:shopman/consts/list.dart';
import 'package:shopman/widgets_common/our_button2.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  const ItemDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
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
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          imgFc5,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ),

                    10.heightBox,

                    // title and details section
                    title!.text
                        .size(16)
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),

                    10.heightBox,

                    // Rating section
                    VxRating(
                      onRatingUpdate: (value) {},
                      normalColor: darkFontGrey,
                      selectionColor: golden,
                      count: 5,
                      size: 25,
                      stepInt: true,
                    ),

                    10.heightBox,

                    "\$300"
                        .text
                        .color(redColor)
                        .fontFamily(bold)
                        .size(18)
                        .make(),

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
                              "In House Brands"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make()
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
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: "Color: ".text.color(textfieldGrey).make(),
                            ),
                            Row(
                              children: List.generate(
                                3,
                                (index) => VxBox()
                                    .size(40, 40)
                                    .roundedFull
                                    .color(Vx.randomPrimaryColor)
                                    .margin(
                                      const EdgeInsets.symmetric(horizontal: 4),
                                    )
                                    .make(),
                              ),
                            )
                          ],
                        ).box.padding(const EdgeInsets.all(8)).make(),

                        // quantity row
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child:
                                  "Quantity: ".text.color(textfieldGrey).make(),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.remove),
                                ),
                                "0"
                                    .text
                                    .color(darkFontGrey)
                                    .fontFamily(bold)
                                    .make(),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add),
                                ),
                                10.widthBox,
                                "(0 available)".text.color(textfieldGrey).make()
                              ],
                            )
                          ],
                        ).box.padding(const EdgeInsets.all(8)).make(),

                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: "Total: ".text.color(textfieldGrey).make(),
                            ),
                            "\$0.00"
                                .text
                                .color(redColor)
                                .size(16)
                                .fontFamily(bold)
                                .make()
                          ],
                        ).box.padding(const EdgeInsets.all(8)).make(),
                      ],
                    ).box.white.shadowSm.make(),

                    10.heightBox,

                    // Description section
                    "Description"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    "This is dummy item & dummy description..."
                        .text
                        .color(darkFontGrey)
                        .make(),

                    10.heightBox,

                    // Button section
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                        itemDetailButtonList.length,
                        (index) => ListTile(
                          title: itemDetailButtonList[index]
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          trailing: const Icon(Icons.arrow_forward),
                        ),
                      ),
                    ),

                    20.heightBox,

                    // Product may like section
                    productsyoumaylike.text
                        .fontFamily(bold)
                        .size(16)
                        .color(darkFontGrey)
                        .make(),

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
                              "Laptop 4GB"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              10.heightBox,
                              "\$500"
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
