import 'package:get/get.dart';
import 'package:shopman/consts/consts.dart';
import 'package:shopman/consts/list.dart';
import 'package:shopman/controllers/auth_controller.dart';
import 'package:shopman/view/auth_screen/signup_screen.dart';
import 'package:shopman/view/home_screen/home.dart';
import 'package:shopman/widgets_common/bg_widget.dart';
import 'package:shopman/widgets_common/applogo_widget.dart';
import 'package:shopman/widgets_common/custom_textfield.dart';
import 'package:shopman/widgets_common/our_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
            40.heightBox,
            Column(
              children: [
                customTextField(
                    hint: emailHint,
                    title: email,
                    controller: controller.emailController,
                    isPass: false),
                customTextField(
                    hint: passwordHint,
                    title: password,
                    controller: controller.passwordController,
                    isPass: true),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () async {
                          await controller
                              .loginMethod(context: context)
                              .then((value) {
                            if (value != null) {
                              VxToast.show(context, msg: loggedIn);
                              Get.offAll(() => const Home());
                            }
                          });
                        },
                        child: forgetPass.text.make())),
                5.heightBox,
                // Login Button
                ourButton(
                    color: redColor,
                    title: login,
                    textColor: whiteColor,
                    onPress: () {
                      Get.to(() => const Home());
                    }).box.width(context.screenWidth - 50).make(),
                10.heightBox,
                createNewAccount.text.color(fontGrey).make(),
                5.heightBox,
                // Sign Up Button
                ourButton(
                    color: lightGolden,
                    title: signup,
                    textColor: redColor,
                    onPress: () {
                      Get.to(() => const SignUpScreen());
                    }).box.width(context.screenWidth - 50).make(),
                10.heightBox,
                loginWith.text.color(fontGrey).make(),
                5.heightBox,
                // Social Media Logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      3,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: lightGrey,
                              radius: 25,
                              child: Image.asset(
                                socialIconLogo[index],
                                width: 30,
                              ),
                            ),
                          )),
                ),
              ],
            )
                .box
                .white
                .rounded
                .padding(const EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .shadowSm
                .make(),
          ],
        ),
      ),
    ));
  }
}
