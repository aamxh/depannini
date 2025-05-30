import 'package:depannini_assistant/app/auth/signup/signup2_view.dart';
import 'package:depannini_assistant/app/main/assistant_view_model.dart';
import 'package:depannini_assistant/core/constants.dart';
import 'package:depannini_assistant/core/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SignUp1V extends StatelessWidget {

  SignUp1V({super.key});

  final _formKey = GlobalKey<FormState>();
  final _licenseNumCtrl = TextEditingController();
  final _regNumCtrl = TextEditingController();
  final _licenseDateCtrl = TextEditingController();
  final _vm = Get.find<AssistantVM>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: size.height * 0.09,),
                  Center(
                    child: Text(
                      'Filling legal information',
                      style: theme.textTheme.headlineMedium,
                    ),
                  ),
                  SizedBox(height: size.height * 0.09,),
                  Text(
                    'What kind of assistance do you wish to provide?',
                    style: theme.textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: size.height * 0.02,),
                  Center(
                    child: ToggleSwitch(
                      totalSwitches: 2,
                      labels: ["Towing", "Repair"],
                      initialLabelIndex: 0,
                      inactiveBgColor: theme.scaffoldBackgroundColor,
                      activeBgColor: [MyConstants.primaryC],
                      activeFgColor: Colors.white,
                      inactiveFgColor: theme.colorScheme.secondary,
                      minHeight: size.height * 0.05,
                      minWidth: size.width * 0.25,
                      borderColor: [theme.colorScheme.secondary],
                      borderWidth: 1,
                      dividerColor: MyConstants.mediumGrey!,
                      fontSize: 18,
                      cornerRadius: 20,
                      onToggle: (idx) {
                        _vm.serviceType = idx! == 0 ? 'towing' : 'repair';
                      },
                    ),
                  ),
                  SizedBox(height: size.height * 0.09,),
                  Column(
                    children: [
                      Text(
                        'Your driving license number: ',
                        style: theme.textTheme.bodyLarge,
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 2,
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                          hintText: 'Ex: 262533',
                          hintStyle: theme.textTheme.bodyLarge!.copyWith(
                            color: MyConstants.mediumGrey,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: MyConstants.primaryC,
                              width: 1,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        controller: _licenseNumCtrl,
                        validator: (val) {
                          if (val!.isEmpty) return 'Empty Field!';
                          if (val.length < 5) return 'Invalid license number!';
                          if (!val.isNum) return 'Invalid license number!';
                          return null;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.03,),
                  Column(
                    children: [
                      Text(
                        'Your vehicle reg. number: ',
                        style: theme.textTheme.bodyLarge,
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 1,
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 2,
                              color: MyConstants.primaryC,
                            ),
                          ),
                          hintText: 'Ex: 24251600',
                          hintStyle: theme.textTheme.bodyLarge!.copyWith(
                            color: MyConstants.mediumGrey,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        controller: _regNumCtrl,
                        validator: (val) => MyHelpers.validateRegistrationNumber(val!),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.03,),
                  Column(
                    children: [
                      Text(
                        'License category:',
                        style: theme.textTheme.bodyLarge,
                      ),
                      SizedBox(height: 10,),
                      ToggleSwitch(
                        totalSwitches: 2,
                        labels: ["B", "C"],
                        initialLabelIndex: 0,
                        inactiveBgColor: theme.scaffoldBackgroundColor,
                        activeBgColor: [MyConstants.primaryC],
                        activeFgColor: Colors.white,
                        inactiveFgColor: theme.colorScheme.secondary,
                        minHeight: size.height * 0.05,
                        minWidth: size.width * 0.2,
                        borderColor: [theme.colorScheme.secondary],
                        borderWidth: 1,
                        fontSize: 20,
                        cornerRadius: 20,
                        onToggle: (idx) {
                          _vm.drivingLicenseCat = idx! == 0 ? 'b' : 'c';
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.03,),
                  Column(
                    children: [
                      Text(
                        'Vehicle type: ',
                        style: theme.textTheme.bodyLarge,
                      ),
                      SizedBox(height: 10,),
                      ToggleSwitch(
                        totalSwitches: 3,
                        labels: ['Car', "Van", 'Truck'],
                        initialLabelIndex: 0,
                        inactiveBgColor: theme.scaffoldBackgroundColor,
                        activeBgColor: [MyConstants.primaryC],
                        activeFgColor: Colors.white,
                        inactiveFgColor: theme.colorScheme.secondary,
                        minHeight: size.height * 0.05,
                        minWidth: size.width * 0.2,
                        borderColor: [theme.colorScheme.secondary],
                        borderWidth: 1,
                        dividerColor: MyConstants.mediumGrey!,
                        dividerMargin: 0,
                        fontSize: 18,
                        cornerRadius: 20,
                        onToggle: (idx) {
                          _vm.vehicleType = idx! == 0 ?
                          'car' : idx == 1 ? 'van' : 'truck';
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.15,),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final res = MyHelpers.vehicleTypeMatchesLicenseCategory(_vm);
                    if (res != null) {
                      Get.showSnackbar(GetSnackBar(
                        backgroundColor: MyConstants.primaryC,
                        borderRadius: 10,
                        duration: Duration(seconds: 5),
                        messageText: Text(
                          res,
                          style: theme.textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ));
                    }
                    else {
                      Get.to(() => SignUp2V());
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(size.width * 0.5, size.height * 0.064),
                  elevation: 0,
                ),
                child: Text(
                  'Next',
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: Colors.white,
                  ),
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