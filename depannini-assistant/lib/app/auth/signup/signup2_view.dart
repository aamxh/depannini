import 'package:depannini_assistant/app/auth/signin/signin_view.dart';
import 'package:depannini_assistant/app/auth/signup/email_verification_view.dart';
import 'package:depannini_assistant/app/auth/signup/email_verification_view_model.dart';
import 'package:depannini_assistant/core/constants.dart';
import 'package:email_otp/email_otp.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:depannini_assistant/core/helpers.dart';
import 'package:get/get.dart';

class SignUp2V extends StatelessWidget {

  SignUp2V({super.key});

  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _password1Ctrl = TextEditingController();
  final _password2Ctrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
              SizedBox(height: size.height * 0.15,),
              Text(
                'Complete your profile',
                style: theme.textTheme.headlineMedium,
              ),
              SizedBox(height: size.height * 0.064,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your name',
                    style: theme.textTheme.bodyLarge,
                  ),
                  SizedBox(height: 5,),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Ex: Anes Adjal',
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
                        borderSide: BorderSide(
                          color: MyConstants.primaryC,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    controller: _nameCtrl,
                    cursorColor: MyConstants.primaryC,
                    style: theme.textTheme.bodyLarge,
                    validator: (val) {
                      return val!.isEmpty ? 'Name field cannot be empty!' : null;
                    },
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your email',
                    style: theme.textTheme.bodyLarge,
                  ),
                  SizedBox(height: 5,),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Ex: anesadjal@gmail.com',
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
                        borderSide: BorderSide(
                          color: MyConstants.primaryC,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    controller: _emailCtrl,
                    cursorColor: MyConstants.primaryC,
                    style: theme.textTheme.bodyLarge,
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      return EmailValidator.validate(val!) ? null :
                          'Invalid email!';
                    },
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your password',
                    style: theme.textTheme.bodyLarge,
                  ),
                  SizedBox(height: 5,),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Ex: gaA25^@',
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
                        borderSide: BorderSide(
                          color: MyConstants.primaryC,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    controller: _password1Ctrl,
                    cursorColor: MyConstants.primaryC,
                    style: theme.textTheme.bodyLarge,
                    obscureText: true,
                    validator: (val) {
                      return MyHelpers.validatePassword(val!);
                    },
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Confirm you password',
                    style: theme.textTheme.bodyLarge,
                  ),
                  SizedBox(height: 5,),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Ex: gaA25^@',
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
                        borderSide: BorderSide(
                          color: MyConstants.primaryC,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    controller: _password2Ctrl,
                    cursorColor: MyConstants.primaryC,
                    style: theme.textTheme.bodyLarge,
                    obscureText: true,
                    validator: (val) => MyHelpers.validatePassword(val!),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.04,),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (_password1Ctrl.text != _password2Ctrl.text) {
                      Get.showSnackbar(GetSnackBar(
                        backgroundColor: MyConstants.primaryC,
                        borderRadius: 10,
                        duration: Duration(seconds: 5),
                        messageText: Text(
                          'Error: Passwords are different!',
                          style: theme.textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ));
                    } else {
                      EmailVerificationVM().changeEmail(_emailCtrl.text);
                      Get.dialog(
                        Center(child: CircularProgressIndicator(
                          color: MyConstants.primaryC,
                        ),),
                        barrierDismissible: false,
                      );
                      EmailOTP.config(
                        appName: 'Depannini',
                        otpLength: 5,
                        otpType: OTPType.numeric,
                        expiry: 180000,
                        emailTheme: EmailTheme.v4,
                      );
                      final res = await EmailOTP.sendOTP(email: _emailCtrl.text);
                      Get.back();
                      if (res) {
                        Get.to(() => EmailVerificationV());
                      } else {
                        Get.showSnackbar(GetSnackBar(
                          messageText: Text(
                            'Unable to send a verification email!',
                            style: theme.textTheme.titleSmall!.copyWith(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          duration: Duration(seconds: 5),
                          backgroundColor: MyConstants.primaryC,
                          borderRadius: 10,
                        ));
                      }
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  fixedSize: Size(size.width * 0.5, size.height * 0.064),
                ),
                child: Text(
                  'Sign-up',
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: theme.textTheme.bodyLarge,
                  children: [
                    TextSpan(
                      text: 'Login',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: MyConstants.primaryC,
                      ),
                      recognizer: TapGestureRecognizer()..onTap =
                          () => Get.to(() => SignInV()),
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
                  backgroundColor: theme.scaffoldBackgroundColor,
                  foregroundColor: theme.colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  elevation: 0,
                  side: BorderSide(
                    color: theme.colorScheme.secondary,
                    width: 2,
                  ),
                ),
                child: Text(
                      'Sign-in with Email',
                      style: theme.textTheme.titleSmall,
                    ),
              ),
              SizedBox(height: size.height * 0.15,),
            ],
          ),
        ),
      ),
    );
  }

}