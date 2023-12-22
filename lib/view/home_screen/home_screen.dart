import 'package:shopman/consts/consts.dart';
import 'package:shopman/consts/list.dart';
import 'package:shopman/widgets_common/home_buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            // Search Box
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchAnything,
                  hintStyle: TextStyle(color: textfieldGrey),
                ),
              ),
            ),

            15.heightBox,

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Swipers Brands
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      viewportFraction: 0.9,
                      enlargeCenterPage: true,
                      itemCount: sliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          sliderList[index],
                          fit: BoxFit.cover,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      },
                    ),
                    15.heightBox,

                    // Deals buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        2,
                        (index) => homeButtons(
                          height: context.screenHeight * 0.15,
                          width: context.screenWidth / 2.5,
                          icon: index == 0 ? icTodaysDeal : icFlashDeal,
                          title: index == 0 ? todayDeal : flashSale,
                        ),
                      ),
                    ),
                    15.heightBox,

                    // 2nd Swipers Brands
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: false,
                      height: 150,
                      viewportFraction: 0.9,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      itemCount: secondSliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondSliderList[index],
                          fit: BoxFit.cover,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      },
                    ),
                    15.heightBox,

                    // 2nd Best Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        3,
                        (index) => homeButtons(
                          height: context.screenHeight * 0.12,
                          width: context.screenWidth / 3.9,
                          icon: index == 0
                              ? icTopCategories
                              : index == 1
                                  ? icBrands
                                  : icTopSeller,
                          title: index == 0
                              ? topCategories
                              : index == 1
                                  ? brands
                                  : topSellers,
                        ),
                      ),
                    ),
                    10.heightBox,
                    // Featured
                    Align(
                      alignment: Alignment.centerLeft,
                      child: featureCategories.text
                          .color(darkFontGrey)
                          .size(22)
                          .fontFamily(semibold)
                          .make(),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: featureCategories.text
                          .color(darkFontGrey)
                          .size(22)
                          .fontFamily(semibold)
                          .make(),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: featureCategories.text
                          .color(darkFontGrey)
                          .size(22)
                          .fontFamily(semibold)
                          .make(),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: featureCategories.text
                          .color(darkFontGrey)
                          .size(22)
                          .fontFamily(semibold)
                          .make(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
