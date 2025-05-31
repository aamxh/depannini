import 'package:depannini_assistant/app/auth/auth_api.dart';
import 'package:depannini_assistant/app/main/enable_location_view.dart';
import 'package:depannini_assistant/app/main/home_view.dart';
import 'package:depannini_assistant/core/constants.dart';
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
        return tokenIsValid ? HomeV() : EnableLocationV();
      },
    );
  }

}