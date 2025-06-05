import 'package:depannini_assistant/app/auth/auth_api.dart';
import 'package:depannini_assistant/app/main/enable_location_view.dart';
import 'package:depannini_assistant/app/main/home_view.dart';
import 'package:depannini_assistant/app/assistance/assistance_view_model.dart';
import 'package:depannini_assistant/app/main/assistant_ws_view_model.dart';
import 'package:depannini_assistant/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        // if (tokenIsValid) {
        //   Get.put(AssistanceVM());
        //   Get.put(AssistantWSVM());
        //   return HomeV();
        // }
        return EnableLocationV();
      },
    );
  }

}