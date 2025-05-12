import 'package:depannini_user/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../auth/signin/signin_view.dart';
import '../auth/signup/phone_number_view.dart';

class WelcomeV extends StatelessWidget {

  const WelcomeV({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.1,),
            Image.asset('assets/images/logo.png'),
            Text(
              'Welcome',
              style: theme.textTheme.headlineMedium,
            ),
            SizedBox(height: size.height * 0.03,),
            Text(
              'We can provide the roadside assistance you need',
              style: theme.textTheme.bodyLarge!.copyWith(
                color: MyConstants.mediumGrey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.15,),
            ElevatedButton(
              onPressed: () {
                Get.to(() => PhoneNumberV());
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                fixedSize: Size(size.width * 0.6, size.height * 0.064),
              ),
              child: Text(
                'Create an account',
                style: theme.textTheme.titleSmall!.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03,),
            ElevatedButton(
              onPressed: () {
                Get.to(SignInV());
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: theme.scaffoldBackgroundColor,
                foregroundColor: theme.colorScheme.secondary,
                fixedSize: Size(size.width * 0.6, size.height * 0.064),
                side: BorderSide(color: MyConstants.primaryC, width: 2),
              ),
              child: Text(
                'Log-in',
                style: theme.textTheme.titleSmall!.copyWith(
                  color: MyConstants.primaryC,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}