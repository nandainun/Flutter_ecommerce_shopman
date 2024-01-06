import 'package:get/get.dart';
import 'package:shopman/consts/consts.dart';
import 'package:shopman/controllers/home_controller.dart';
import 'package:shopman/view/cart_screen/cart_screen.dart';
import 'package:shopman/view/category_screen/category_screen.dart';
import 'package:shopman/view/home_screen/home_screen.dart';
import 'package:shopman/view/profile_screen/profile_screen.dart';
import 'package:shopman/widgets_common/exit_dialog.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // init home controller
    var controller = Get.put(HomeController());

    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 26,
          ),
          label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 26,
          ),
          label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: account)
    ];

    var navBody = [const HomeScreen(), const CategoryScreen(), const CartScreen(), const ProfileScreen()];

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context)); //Here this temporary, you can change this line
      },
      child: Scaffold(
        body: Column(children: [
          Obx(
            () => Expanded(
              child: navBody.elementAt(controller.currentNavIndex.value),
            ),
          ),
        ]),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            items: navbarItem,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
