import 'package:get/get.dart';
import 'package:shopman/consts/consts.dart';
import 'package:shopman/consts/list.dart';
import 'package:shopman/controllers/product_controller.dart';
import 'package:shopman/view/category_screen/category_details.dart';
import 'package:shopman/widgets_common/bg_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: categories.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              mainAxisExtent: 200,
            ),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(
                    categoryImage[index],
                    height: 120,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  10.heightBox,
                  categoryList[index].text.color(darkFontGrey).align(TextAlign.center).make()
                ],
              ).box.white.rounded.clip(Clip.antiAlias).outerShadowSm.make().onTap(
                () {
                  controller.getSubCategories(categoryList[index]);
                  Get.to(() => CategoryDetails(title: categoryList[index]));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
