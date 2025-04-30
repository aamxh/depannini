import 'package:depannini_assistant/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:depannini_assistant/app/auth/signup/phone_number_verification_view.dart';

class PhoneNumberV extends StatefulWidget {

  const PhoneNumberV({super.key});

  @override
  State<StatefulWidget> createState() => PhoneNumberVS();

}

class PhoneNumberVS extends State<PhoneNumberV> {
  
  final _ctrl = TextEditingController();
  final _key = GlobalKey<FormState>();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Form(
          key: _key,
          child: Column(
            children: [
              SizedBox(height: size.height * 0.1),
              Text(
                'Phone number registration',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium,
              ),
              SizedBox(height: size.height * 0.15),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _focusNode.hasFocus ?
                    MyConstants.primaryC :
                    theme.colorScheme.secondary,
                  ),
                ),
                height: size.height * 0.07,
                child: Row(
                  children: [
                    SizedBox(width: size.width * 0.04),
                    Text(
                      '+213',
                      style: theme.textTheme.titleSmall,
                    ),
                    SizedBox(width: size.width * 0.04),
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
                        maxLength: 10,
                        buildCounter: (context, {
                          required currentLength,
                          required isFocused,
                          required maxLength,
                        }) => null,
                        cursorColor: MyConstants.primaryC,
                        style: theme.textTheme.headlineSmall!.copyWith(
                          color: MyConstants.primaryC,
                          letterSpacing: 5,
                        ),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "Your phone number..",
                          hintStyle: theme.textTheme.bodyLarge!.copyWith(
                            color: MyConstants.mediumGrey,
                          ),
                          border: InputBorder.none,
                        ),
                        focusNode: _focusNode,
                        controller: _ctrl,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.15,),
              ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    Get.to(() => PhoneNumberVerificationV());
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(size.width * 0.5, size.height * 0.064),
                ),
                child: Text(
                  'Next',
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                children: [
                  SizedBox(width: size.width * 0.03,),
                  Image.asset(
                    'assets/icons/check.png',
                    width: 30,
                  ),
                  SizedBox(width: size.width * 0.03,),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: "By continuing, you agree to our ",
                        style: theme.textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: 'Terms of service ',
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: MyConstants.primaryC,
                            ),
                          ),
                          TextSpan(
                            text: "and ",
                          ),
                          TextSpan(
                            text: 'Privacy policy.',
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: MyConstants.primaryC,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}