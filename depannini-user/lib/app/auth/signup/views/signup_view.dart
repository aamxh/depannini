import 'package:depannini_user/app/auth/signin/views/phone_number_signin_view.dart';
import 'package:depannini_user/app/common/view_models/client_view_model.dart';
import 'package:depannini_user/app/auth/signup/views/email_verification_view.dart';
import 'package:depannini_user/app/auth/signup/view_models/email_verification_view_model.dart';
import 'package:depannini_user/core/constants.dart';
import 'package:email_otp/email_otp.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:depannini_user/core/helpers.dart';
import 'package:get/get.dart';

class SignUpV extends StatelessWidget {

  SignUpV({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.15,),
              Center(
                child: Text(
                  'Complete your profile',
                  style: theme.textTheme.headlineMedium,
                ),
              ),
              SizedBox(height: size.height * 0.064,),
              Text(
                'Your name',
                style: theme.textTheme.bodyLarge,
              ),
              SizedBox(height: size.height * 0.01,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Ex: Hakmi Zohir',
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
              SizedBox(height: size.height * 0.03,),
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
              SizedBox(height: size.height * 0.03,),
              Text(
                'Your password',
                style: theme.textTheme.bodyLarge,
              ),
              SizedBox(height: size.height * 0.01),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Ex: age#H2352',
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
              SizedBox(height: size.height * 0.03,),
              Text(
                'Confirm your password',
                style: theme.textTheme.bodyLarge,
              ),
              SizedBox(height: size.height * 0.01),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Ex: age#H2352',
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
              SizedBox(height: size.height * 0.04,),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (_password1Ctrl.text != _password2Ctrl.text) {
                        Get.showSnackbar(GetSnackBar(
                          messageText: Text(
                            'Passwords are different!',
                            style: theme.textTheme.titleSmall!.copyWith(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          duration: Duration(seconds: 5),
                          backgroundColor: MyConstants.primaryC,
                          borderRadius: 10,
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
                          final vm = Get.find<ClientVM>();
                          vm.password = (_password1Ctrl.text);
                          vm.name = (_nameCtrl.text);
                          vm.email = (_emailCtrl.text);
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
              ),
              SizedBox(height: size.height * 0.01),
              Center(
                child: RichText(
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
                            () => Get.offAll(() => PhoneNumberSignInV()),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.1,),
            ],
          ),
        ),
      ),
    );
  }

}