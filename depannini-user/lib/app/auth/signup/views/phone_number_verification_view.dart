import "package:depannini_user/app/auth/signup/view_models/phone_number_verification_view_model.dart";
import "package:depannini_user/core/constants.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:pinput/pinput.dart";
import 'package:depannini_user/app/auth/signup/views/signup_view.dart';

class PhoneNumberVerificationV extends StatelessWidget {

  PhoneNumberVerificationV({super.key});

  final _ctrl = TextEditingController();
  final _vm = PhoneNumberVerificationVM();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.1),
            Text(
              'Phone number verification',
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.05,),
            Text(
              'Check your messages for the OTP we sent to verify your phone number.',
              style: theme.textTheme.bodyLarge!.copyWith(
                color: MyConstants.mediumGrey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.1),
            Pinput(
              onChanged: (String val) => _vm.changeCode(val),
              controller: _ctrl,
              length: 5,
              defaultPinTheme: PinTheme(
                textStyle: theme.textTheme.titleLarge,
                width: size.width * 0.15,
                height: size.width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: theme.scaffoldBackgroundColor == Colors.white ?
                  MyConstants.lightGrey :
                  MyConstants.darkGrey,
                ),
              ),
              focusedPinTheme: PinTheme(
                textStyle: theme.textTheme.titleLarge,
                width: size.width * 0.15,
                height: size.width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: theme.scaffoldBackgroundColor == Colors.white ?
                  MyConstants.lightGrey :
                  MyConstants.mediumGrey,
                  border: Border.all(color: theme.colorScheme.secondary),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02,),
            RichText(
              text: TextSpan(
                text: 'Didn\'t receive the code? ',
                style: theme.textTheme.bodyLarge,
                children: [
                  TextSpan(
                    text: 'Resend again.',
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: MyConstants.primaryC,
                    ),
                  ),
                ]
              ),
            ),
            SizedBox(height: size.height * 0.1,),
            Obx(
                () => ElevatedButton(
                onPressed: () async {
                  if (_vm.isValid) {
                    Get.to(() => SignUpV());
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(size.width * 0.5, size.height * 0.064),
                  elevation: 0,
                  backgroundColor: _vm.isValid ?
                  MyConstants.primaryC :
                  theme.scaffoldBackgroundColor == Colors.white ?
                  MyConstants.lightGrey :
                  MyConstants.darkGrey,
                  side: BorderSide(
                    color: _vm.isValid ?
                    MyConstants.primaryC :
                    theme.scaffoldBackgroundColor == Colors.white ?
                    MyConstants.mediumGrey! :
                    MyConstants.lightGrey!,
                  ),
                ),
                child: Text(
                  'Verify',
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: _vm.isValid ?
                    Colors.white :
                    theme.colorScheme.secondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}