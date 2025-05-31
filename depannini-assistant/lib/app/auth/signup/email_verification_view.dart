import 'package:depannini_assistant/app/auth/auth_api.dart';
import 'package:depannini_assistant/app/auth/signup/email_verification_view_model.dart';
import 'package:depannini_assistant/app/main/assistant_view_model.dart';
import 'package:depannini_assistant/app/main/models/assistant.dart';
import 'package:depannini_assistant/core/constants.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../main/home_view.dart';

class EmailVerificationV extends StatelessWidget {

  EmailVerificationV({super.key});

  final _vm = EmailVerificationVM();

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
            SizedBox(height: size.height * 0.1,),
            Text(
              'Email Address Verification',
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.05,),
            Text(
              'Check your emails for the code we sent to verify your email address.',
              style: theme.textTheme.bodyLarge!.copyWith(
                color: MyConstants.mediumGrey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.1,),
            Pinput(
              length: 5,
              onChanged: (val) => _vm.changeCode(val),
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
            SizedBox(height: size.height * 0.1,),
            Obx(() => ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(size.width * 0.5, size.height * 0.064),
                backgroundColor: _vm.isValid ?
                MyConstants.primaryC :
                theme.scaffoldBackgroundColor == Colors.white ?
                MyConstants.lightGrey :
                MyConstants.mediumGrey,
                elevation: 0,
                side: BorderSide(
                  color: _vm.isValid ?
                  MyConstants.primaryC :
                  theme.scaffoldBackgroundColor == Colors.white ?
                  MyConstants.mediumGrey! :
                  MyConstants.lightGrey!,
                ),
              ),
              onPressed: () async {
                if (_vm.isValid) {
                  Get.dialog(
                    Center(child: CircularProgressIndicator(
                      color: MyConstants.primaryC,
                    ),),
                    barrierDismissible: false,
                  );
                  final res = EmailOTP.verifyOTP(otp: _vm.code.value);
                  Get.back();
                  if (res) {
                    final vm = Get.find<AssistantVM>();
                    final res = await AuthApi.signUpUser(Assistant(
                      name: vm.name,
                      email: vm.email,
                      password: vm.password,
                      phoneNumber: vm.phoneNumber,
                      currentLat: vm.currentLat,
                      currentLng: vm.currentLng,
                      serviceType: vm.serviceType,
                      vehicleType: vm.vehicleType,
                      drivingLicenseCat: vm.drivingLicenseCat,
                      drivingLicenseNum: vm.drivingLicenseNum,
                      drivingLicenseExpiry: vm.drivingLicenseExpiry,
                      vehicleRegistrationNum: vm.vehicleRegistrationNum,
                    ));
                    if (res) {
                      Get.delete<AssistantVM>();
                      Get.offAll(() => HomeV());
                    }
                  } else {
                    Get.showSnackbar(GetSnackBar(
                      messageText: Text(
                        'Either the code validity has expired or you\'ve '
                            'entered a code that does not match with the one we sent!',
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
              },
              child: Text(
                'Verify',
                style: theme.textTheme.titleSmall!.copyWith(
                  color: _vm.isValid ?
                  Colors.white :
                  theme.colorScheme.secondary,
                ),
              ),
            ),),
          ],
        ),
      ),
    );
  }

}