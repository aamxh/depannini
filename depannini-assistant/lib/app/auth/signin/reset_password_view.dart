import 'package:depannini_assistant/core/constants.dart';
import 'package:flutter/material.dart';

class ResetPasswordV extends StatelessWidget {

  const ResetPasswordV({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.1),
            Text(
              'Resetting password',
              style: theme.textTheme.headlineMedium,
            ),
            SizedBox(height: size.height * 0.05),
            Text(
              'A link was sent to your email address to reset the password for your account.',
              style: theme.textTheme.bodyLarge!.copyWith(
                color: MyConstants.mediumGrey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

}