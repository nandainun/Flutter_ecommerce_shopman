import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopman/consts/consts.dart';
import 'package:shopman/consts/list.dart';
import 'package:shopman/controllers/auth_controller.dart';
import 'package:shopman/controllers/profile_controller.dart';
import 'package:shopman/services/firestore_services.dart';
import 'package:shopman/view/auth_screen/login_screen.dart';
import 'package:shopman/view/profile_screen/components/details_card.dart';
import 'package:shopman/view/profile_screen/edit_profile_screen.dart';
import 'package:shopman/widgets_common/bg_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];

              return SafeArea(
                child: Column(
                  children: [
                    // Edit profile button
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: const Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.edit,
                          color: whiteColor,
                        ),
                      ).onTap(
                        () {
                          controller.nameController.text = data['name'];
                          controller.oldpassController.text = data['password'];
                          Get.to(
                            () => EditProfileScreen(data: data),
                          );
                        },
                      ),
                    ),

                    // Users detail section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          data['imageUrl'] == ''
                              ? Image.asset(
                                  imgProfile2,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make()
                              : Image.network(
                                  data['imageUrl'],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make(),
                          10.widthBox,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data['name']}".text.fontFamily(semibold).white.make(),
                                "${data['email']}".text.fontFamily(semibold).white.make()
                              ],
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: whiteColor),
                            ),
                            onPressed: () async {
                              await Get.put(AuthController()).signOutMethod(context);
                              Get.offAll(() => const LoginScreen());
                            },
                            child: logout.text.fontFamily(semibold).white.make(),
                          ),
                        ],
                      ),
                    ),

                    20.heightBox,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        detailsCard(count: data['cart_count'], title: "in your cart", width: context.screenWidth / 3.4),
                        detailsCard(
                            count: data['wishlist_count'], title: "in your cart", width: context.screenWidth / 3.4),
                        detailsCard(
                            count: data['order_count'], title: "in your cart", width: context.screenWidth / 3.4),
                      ],
                    ),

                    10.heightBox,

                    // Button section
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image.asset(
                            profileButtonIcon[index],
                            width: 22,
                          ),
                          title: profileButtonList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: lightGrey,
                        );
                      },
                      itemCount: profileButtonList.length,
                    )
                        .box
                        .white
                        .rounded
                        .shadowSm
                        .margin(
                          const EdgeInsets.all(12),
                        )
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .make()
                        .box
                        .color(redColor)
                        .make()
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
