import 'package:brac_arna/app/routes/app_pages.dart';
import 'package:brac_arna/common/ui.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../styles/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_formfield.dart';
import '../widgets/custom_header.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    final startAddressController = TextEditingController();
    final destinationAddressController = TextEditingController();

    final startAddressFocusNode = FocusNode();
    final desrinationAddressFocusNode = FocusNode();
    var width = MediaQuery.of(context).size.width;



    return Scaffold(
        backgroundColor: Color(0xff1A62AE),
        body: SingleChildScrollView(
          reverse: true,
          child: Container(
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    Container(
                        height: 410,


                        // decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //     image: AssetImage(
                        //     'assets/images/background1.png',
                        //
                        //   ),
                        //   fit: BoxFit.fill,
                        // )
                        //
                        // ),

                        child: Image(
                          image: AssetImage(
                            'assets/images/background1.png',
                          ),
                          fit: BoxFit.fill,
                          //color: Color(0xffec008c),
                          color: Colors.white,

                        )

                    ),
                    Positioned(
                      bottom: 100,
                      left: 0,
                      right: 0,
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 0,
                              ),
                              Center(
                                child: Text(
                                  'Pharmacy Management System',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 180,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 130,
                        width: 130,
                        margin: EdgeInsets.only(top: 10),
                        child: Center(
                          child: Image(
                            image: AssetImage(
                              'assets/images/logo.png',
                              //'assets/images/logounhcr.png',
                            ),
                            fit: BoxFit.fill,
                            // color: Color(0xffec008c),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),

                  ],
                ),
                Form(
                  key: controller.loginFormKey,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          // decoration: BoxDecoration(
                          //     color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Color.fromRGBO(143, 148, 251, .2), blurRadius: 20.0, offset: Offset(0, 10))]),
                          //
                          decoration: Ui.getBoxDecoration(color: Colors.white, radius: 10),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5.0),
                                margin: EdgeInsets.all(5.0),
                                // decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
                                child: TextFormField(
                                  // controller: controller.userNameController.value,
                                  initialValue: "gkf1dept1@unhcr.org",
                                  onChanged: (input) {
                                    controller.userData.value.userName = input;
                                  },
                                  validator: (input) {
                                    return input!.isEmpty ? 'Please provide your username.' : null;
                                  },
                                  style: TextStyle(fontSize: 15),
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff1A62AE), width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff1A62AE), width: 1.0),
                                    ),

                                    hintText: "User Name",
                                    hintStyle: TextStyle(color: Colors.grey[500]),
                                  ),
                                ),
                              ),

                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: TextFormField(
                                  // controller: controller.passwordController.value,
                                  initialValue: "Pms@1234",
                                  onChanged: (input) {
                                    controller.userData.value.password = input;
                                  },
                                  validator: (input) {
                                    return input!.isEmpty ? 'Please provide your password.' : null;
                                  },
                                  style: TextStyle(fontSize: 15),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff1A62AE), width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff1A62AE), width: 1.0),
                                    ),
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey[500]),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Get.offAllNamed(Routes.INFORMATION_FORM);
                                  //Get.offAllNamed(Routes.PROVIDED_DATA_LIST);

                                  // Get.offAllNamed(Routes.AFTER_LOGIN);

                                  if (controller.loginFormKey.currentState!.validate()) {
                                    controller.login();
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(colors: [
                                        //Color(0xffec008c),
                                        Color(0xff1A62AE),
                                        //Colors.pinkAccent.shade100
                                        Color(0xff1A62AE)
                                        // Color.fromRGBO(143, 148, 251, 1),
                                        // Color.fromRGBO(143, 148, 251, .6),
                                      ])),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }


  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();
  //
  // String get email => _emailController.text.trim();
  // String get password => _passwordController.text.trim();
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SafeArea(
  //         child: Stack(
  //           children: [
  //             Container(
  //               height: MediaQuery.of(context).size.height,
  //               width: MediaQuery.of(context).size.width,
  //               color: AppColors.blue,
  //             ),
  //             CustomHeader(
  //               text: 'Log In.',
  //               onTap: () {
  //                 // Navigator.pushReplacement(context,
  //                 //     MaterialPageRoute(builder: (context) => const SignUp()));
  //               },
  //             ),
  //             Positioned(
  //               top: MediaQuery.of(context).size.height * 0.08,
  //               child: Container(
  //                 height: MediaQuery.of(context).size.height * 0.9,
  //                 width: MediaQuery.of(context).size.width,
  //                 decoration: const BoxDecoration(
  //                     color: AppColors.whiteshade,
  //                     borderRadius: BorderRadius.only(
  //                         topLeft: Radius.circular(40),
  //                         topRight: Radius.circular(40))),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Container(
  //                       height: 200,
  //                       width: MediaQuery.of(context).size.width * 0.8,
  //                       margin: EdgeInsets.only(
  //                           left: MediaQuery.of(context).size.width * 0.09),
  //                       child: Image.asset("assets/images/logo.png"),
  //                     ),
  //                     const SizedBox(
  //                       height: 24,
  //                     ),
  //                     CustomFormField(
  //                       headingText: "Email",
  //                       hintText: "Email",
  //                       obsecureText: false,
  //                       suffixIcon: const SizedBox(),
  //                       controller: _emailController,
  //                       maxLines: 1,
  //                       textInputAction: TextInputAction.done,
  //                       textInputType: TextInputType.emailAddress,
  //                     ),
  //                     const SizedBox(
  //                       height: 16,
  //                     ),
  //                     CustomFormField(
  //                       headingText: "Password",
  //                       maxLines: 1,
  //                       textInputAction: TextInputAction.done,
  //                       textInputType: TextInputType.text,
  //                       hintText: "At least 8 Character",
  //                       obsecureText: true,
  //                       suffixIcon: IconButton(
  //                           icon: const Icon(Icons.visibility), onPressed: () {}),
  //                       controller: _passwordController,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.end,
  //                       children: [
  //                         Container(
  //                           margin: const EdgeInsets.symmetric(
  //                               vertical: 16, horizontal: 24),
  //                           child: InkWell(
  //                             onTap: () {},
  //                             child: Text(
  //                               "Forgot Password?",
  //                               style: TextStyle(
  //                                   color: AppColors.blue.withOpacity(0.7),
  //                                   fontWeight: FontWeight.w500),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     AuthButton(
  //                       onTap: () {},
  //                       text: 'Sign In',
  //                     ),
  //                     // CustomRichText(
  //                     //   discription: "Don't already Have an account? ",
  //                     //   text: "Sign Up",
  //                     //   onTap: () {
  //                     //     Navigator.pushReplacement(
  //                     //         context,
  //                     //         MaterialPageRoute(
  //                     //             builder: (context) => const SignUp()));
  //                     //   },
  //                     // ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         )),
  //   );
  // }

  Widget _textField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    required double width,
    Widget? prefixIcon,
    Widget? suffixIcon,
    required Function(String) locationCallback,
  }) {
    return Container(
      width: width * 0.8,
      child: TextField(
        onChanged: (value) {
          locationCallback(value);
        },
        controller: controller,
        focusNode: focusNode,
        decoration: new InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.blue.shade300,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(15),
          hintText: hint,
        ),
      ),
    );
  }

}
