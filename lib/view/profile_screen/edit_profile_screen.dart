import 'dart:io';

import 'package:get/get.dart';
import 'package:shopman/consts/consts.dart';
import 'package:shopman/controllers/profile_controller.dart';
import 'package:shopman/widgets_common/bg_widget.dart';
import 'package:shopman/widgets_common/custom_textfield.dart';
import 'package:shopman/widgets_common/our_button.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                    ? Image.asset(
                        imgProfile2,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                        ? Image.network(
                            data['imageUrl'],
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.file(
                            File(controller.profileImgPath.value),
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                ourButton(
                  color: redColor,
                  onPress: () {
                    controller.changeImage(context);
                  },
                  textColor: whiteColor,
                  title: "Change",
                ),
                const Divider(),
                10.heightBox,
                customTextField(
                  controller: controller.nameController,
                  hint: nameHint,
                  title: name,
                  isPass: false,
                ),
                10.heightBox,
                customTextField(
                  controller: controller.oldpassController,
                  hint: passwordHint,
                  title: oldpass,
                  isPass: true,
                ),
                10.heightBox,
                customTextField(
                  controller: controller.newpassController,
                  hint: passwordHint,
                  title: newpass,
                  isPass: true,
                ),
                20.heightBox,
                controller.isLoading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : SizedBox(
                        width: context.screenWidth - 60,
                        child: ourButton(
                          color: redColor,
                          onPress: () async {
                            controller.isLoading(true);

                            // if image not selected
                            if (controller.profileImgPath.value.isEmpty) {
                              await controller.uploadProfileImage();
                            } else {
                              controller.profileImageLink = data['imageUrl'];
                            }

                            // if old password matches database
                            if (data['password'] == controller.oldpassController.text) {
                              await controller.changeAuthPassword(
                                  email: data['email'],
                                  password: controller.oldpassController.text,
                                  newpassword: controller.newpassController.text);
                              await controller.updateProfile(
                                  imgUrl: controller.profileImageLink,
                                  name: controller.nameController.text,
                                  password: controller.newpassController.text);
                              VxToast.show(context, msg: "Updated");
                            } else {
                              VxToast.show(context, msg: "Wrong old password");
                              controller.isLoading(false);
                            }
                          },
                          textColor: whiteColor,
                          title: "Save",
                        ),
                      ),
              ],
            )
                .box
                .white
                .shadowSm
                .rounded
                .padding(const EdgeInsets.all(16))
                .margin(const EdgeInsets.only(top: 50, left: 16, right: 16))
                .make(),
          ),
        ),
      ),
    );
  }
}
