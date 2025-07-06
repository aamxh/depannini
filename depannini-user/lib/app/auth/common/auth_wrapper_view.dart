import 'package:depannini_user/app/auth/common/auth_api.dart';
import 'package:depannini_user/app/common/profile_api.dart';
import 'package:depannini_user/app/common/view_models/client_view_model.dart';
import 'package:depannini_user/app/main/views/home_view.dart';
import 'package:depannini_user/app/auth/common/welcome_view.dart';
import 'package:depannini_user/core/constants.dart';
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
        if (tokenIsValid) {
          Get.put(ClientVM());
          _initializeProfile();
          return HomeV();
        }
        return WelcomeV();
      },
    );
  }

  Future<void> _initializeProfile() async {
    final client = Get.find<ClientVM>();
    final token = await AuthApi.getAccessToken();
    if (token == null) return;
    final profile = await ProfileAPI.getProfile(token);
    if (profile == null) return;
    client.name = profile.name;
    client.email = profile.name;
    client.num = profile.phoneNum;
    client.currentLat = profile.currentLat;
    client.currentLng = profile.currentLng;
  }

}