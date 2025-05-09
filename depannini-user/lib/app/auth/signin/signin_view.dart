import 'package:depannini_user/app/auth/signin/reset_password_view.dart';
import 'package:depannini_user/app/auth/signup/phone_number_view.dart';
import 'package:depannini_user/app/main/home_view.dart';
import 'package:depannini_user/core/constants.dart';
import 'package:depannini_user/core/helpers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInV extends StatefulWidget {

  const SignInV({super.key});

  @override
  State<StatefulWidget> createState() => _SignInVS();

}

class _SignInVS extends State<SignInV> {

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
              SizedBox(height: size.height * 0.2),
              Text(
                'Login to your account',
                style: theme.textTheme.headlineMedium,
              ),
              SizedBox(height: size.height * 0.1),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _focusNode.hasFocus ?
                    MyConstants.primaryC :
                    theme.colorScheme.secondary,
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
                          hintText: "Your phone number..",
                          hintStyle: theme.textTheme.bodyLarge!.copyWith(
                            color: MyConstants.mediumGrey,
                          ),
                          border: InputBorder.none,
                        ),
                        //style: ,
                        controller: _phoneNumCtrl,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              TextFormField(
                obscureText: true,
                //cursorColor: MyConstants.primaryC,
                style: theme.textTheme.bodyLarge,
                controller: _passwordCtrl,
                validator: (val) => MyHelpers.validatePassword(val!),
                decoration: InputDecoration(
                  hintText: 'Your password..',
                  hintStyle: theme.textTheme.bodyLarge!.copyWith(
                    color: MyConstants.mediumGrey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Get.offAll(() => HomeV());
                  }
                },
                style: ElevatedButton.styleFrom(
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
                onPressed: () {},
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      theme.scaffoldBackgroundColor == Colors.white ?
                          'assets/icons/google_light.png' :
                          'assets/icons/google_dark.png',
                      width: 25,
                    ),
                    Text(
                      'Sign-in with Google',
                      style: theme.textTheme.titleSmall!.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}