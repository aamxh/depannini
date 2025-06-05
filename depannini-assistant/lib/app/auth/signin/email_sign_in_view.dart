import 'package:depannini_assistant/app/assistance/assistance_view_model.dart';
import 'package:depannini_assistant/app/auth/auth_api.dart';
import 'package:depannini_assistant/app/auth/signin/phone_number_signin_view.dart';
import 'package:depannini_assistant/app/auth/signin/reset_password_view.dart';
import 'package:depannini_assistant/app/auth/signup/phone_number_view.dart';
import 'package:depannini_assistant/app/main/assistant_view_model.dart';
import 'package:depannini_assistant/app/main/assistant_ws_view_model.dart';
import 'package:depannini_assistant/app/main/home_view.dart';
import 'package:depannini_assistant/core/constants.dart';
import 'package:depannini_assistant/core/helpers.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailSignInV extends StatelessWidget {

  EmailSignInV({super.key});

  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.15),
              Center(
                child: Text(
                  'Login to your account',
                  style: theme.textTheme.headlineMedium,
                ),
              ),
              SizedBox(height: size.height * 0.1),
              Text(
                'Your email',
                style: theme.textTheme.bodyLarge,
              ),
              SizedBox(height: size.height * 0.01),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Ex: h_zohir@gmail.com',
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
              SizedBox(height: size.height * 0.03),
              Text(
                'Your password',
                style: theme.textTheme.bodyLarge,
              ),
              SizedBox(height: size.height * 0.01),
              TextFormField(
                obscureText: true,
                //cursorColor: MyConstants.primaryC,
                style: theme.textTheme.bodyLarge,
                controller: _passwordCtrl,
                // validator: (val) => MyHelpers.validatePassword(val!),
                validator: (val) => null,
                decoration: InputDecoration(
                  hintText: 'Ex: 22GAh^sg@',
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
              Center(
                child: GestureDetector(
                  onTap: () => Get.to(() => ResetPasswordV()),
                  child: Text(
                    'Forgot password?',
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.primaryColor,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.08),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Get.dialog(
                        Center(child: CircularProgressIndicator(
                          color: MyConstants.primaryC,
                        ),),
                        barrierDismissible: false,
                      );
                      final res = await AuthApi.signInUserWithEmail(
                        _emailCtrl.text,
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
                    fixedSize: Size(size.width * 0.5, size.height * 0.064),
                    elevation: 0,
                  ),
                  child: Text(
                    'Sign-in',
                    style: theme.textTheme.titleSmall!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Center(
                child: RichText(
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
              ),
              SizedBox(height: size.height * 0.03,),
              Center(
                child: Text(
                  'Or',
                  style: theme.textTheme.titleSmall,
                ),
              ),
              SizedBox(height: size.height * 0.03,),
              Center(
                child: ElevatedButton(
                  onPressed: () => Get.to(() => PhoneNumberSignInV()),
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
                  child:
                  Text(
                    'Sign-in with Phone',
                    style: theme.textTheme.titleSmall!.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
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