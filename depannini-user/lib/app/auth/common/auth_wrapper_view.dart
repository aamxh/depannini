import 'package:depannini_user/app/auth/common/auth_api.dart';
import 'package:depannini_user/app/main/views/home_view.dart';
import 'package:depannini_user/app/auth/common/welcome_view.dart';
import 'package:depannini_user/core/constants.dart';
import 'package:flutter/material.dart';

class AuthWrapperV extends StatelessWidget {

  const AuthWrapperV({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthApi.isUserAuthenticated(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(body: Center(child: CircularProgressIndicator(
            color: MyConstants.primaryC,
          ),),);
        }
        final tokenIsValid = snapshot.data!;
        return tokenIsValid ? HomeV() : WelcomeV();
      },
    );
  }

}