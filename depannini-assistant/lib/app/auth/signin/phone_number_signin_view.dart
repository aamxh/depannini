import 'package:depannini_assistant/app/auth/common/auth_api.dart';
import 'package:depannini_assistant/app/auth/signin/email_sign_in_view.dart';
import 'package:depannini_assistant/app/auth/signin/reset_password_view.dart';
import 'package:depannini_assistant/app/auth/signup/views/phone_number_view.dart';
import 'package:depannini_assistant/app/common/view_models/assistant_view_model.dart';
import 'package:depannini_assistant/app/main/views/home_view.dart';
import 'package:depannini_assistant/app/assistance/view_models/assistance_view_model.dart';
import 'package:depannini_assistant/core/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneNumberSignInV extends StatefulWidget {

  const PhoneNumberSignInV({super.key});

  @override
  State<StatefulWidget> createState() => _SignInVS();

}

class _SignInVS extends State<PhoneNumberSignInV> {

  final _phoneNumCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: size.height * 0.15),
              Text(
                'Login to your account',
                style: theme.textTheme.headlineMedium,
              ),
              SizedBox(height: size.height * 0.1),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your phone number',
                    style: theme.textTheme.bodyLarge,
                  ),
                  SizedBox(height: 5,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _focusNode.hasFocus ?
                        MyConstants.primaryC :
                        theme.colorScheme.secondary,
                        width: 2,
                      ),
                    ),
                    height: size.height * 0.068,
                    child: Row(
                      children: [
                        SizedBox(width: size.width * 0.04),
                        Text(
                          '+213',
                          style: theme.textTheme.titleSmall,
                        ),
                        SizedBox(width: size.width * 0.03),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            width: 2,
                            decoration: BoxDecoration(
                              color: MyConstants.mediumGrey,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            validator: (val) {
                              if (val == null || val.length != 9 || !val.isNum) {
                                return "Invalid phone number format!";
                              }
                              return null;
                            },
                            focusNode: _focusNode,
                            style: theme.textTheme.headlineSmall!.copyWith(
                              color: MyConstants.primaryC,
                              letterSpacing: 5,
                            ),
                            buildCounter: (context, {
                              required currentLength,
                              required isFocused,
                              required maxLength,
                            }) => null,
                            textAlign: TextAlign.center,
                            maxLength: 10,
                            decoration: InputDecoration(
                              hintText: "Ex: 557038640",
                              hintStyle: theme.textTheme.bodyLarge!.copyWith(
                                color: MyConstants.mediumGrey,
                              ),
                              border: InputBorder.none,
                            ),
                            controller: _phoneNumCtrl,
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your password',
                    style: theme.textTheme.bodyLarge,
                  ),
                  SizedBox(height: 5,),
                  TextFormField(
                    obscureText: true,
                    //cursorColor: MyConstants.primaryC,
                    style: theme.textTheme.bodyLarge,
                    controller: _passwordCtrl,
                    //validator: (val) => MyHelpers.validatePassword(val!),
                    validator: (val) => null,
                    decoration: InputDecoration(
                      hintText: 'Ex: at^#w3sD',
                      hintStyle: theme.textTheme.bodyLarge!.copyWith(
                        color: MyConstants.mediumGrey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: theme.colorScheme.secondary,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: MyConstants.primaryC,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.01),
              GestureDetector(
                onTap: () => Get.to(() => ResetPasswordV()),
                child: Text(
                  'Forgot password?',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.primaryColor,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: size.height * 0.08),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Get.dialog(
                      Center(child: CircularProgressIndicator(
                        color: MyConstants.primaryC,
                      ),),
                      barrierDismissible: false,
                    );
                    final res = await AuthApi.signInUserWithPhoneNum(
                        "+213${_phoneNumCtrl.text}",
                        _passwordCtrl.text,
                    );
                    Get.back();
                    if (res) {
                      Get.delete<AssistantVM>();
                      Get.put(AssistanceVM());
                      Get.offAll(() => HomeV());
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  fixedSize: Size(size.width * 0.5, size.height * 0.064),
                ),
                child: Text(
                  'Sign-in',
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              RichText(
                text: TextSpan(
                  text: 'Do not have an account? ',
                  style: theme.textTheme.bodyLarge,
                  children: [
                    TextSpan(
                      text: 'Create one',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: MyConstants.primaryC,
                      ),
                      recognizer: TapGestureRecognizer()..onTap =
                          () => Get.offAll(() => PhoneNumberV()),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03,),
              Text(
                'Or',
                style: theme.textTheme.titleSmall,
              ),
              SizedBox(height: size.height * 0.03,),
              ElevatedButton(
                onPressed: () => Get.to(() => EmailSignInV()),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(size.width * 0.64, size.height * 0.064),
                  foregroundColor: theme.colorScheme.secondary,
                  backgroundColor: theme.scaffoldBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  elevation: 0,
                  side: BorderSide(color: theme.colorScheme.secondary, width: 2),
                ),
                child: Text(
                      'Sign-in with Email',
                      style: theme.textTheme.titleSmall!.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}