import 'package:depannini_assistant/app/auth/common/auth_api.dart';
import 'package:depannini_assistant/app/auth/common/enable_location_view.dart';
import 'package:depannini_assistant/app/common/profile_api.dart';
import 'package:depannini_assistant/app/common/view_models/assistant_view_model.dart';
import 'package:depannini_assistant/app/main/views/home_view.dart';
import 'package:depannini_assistant/app/assistance/view_models/assistance_view_model.dart';
import 'package:depannini_assistant/app/main/view_models/assistant_ws_view_model.dart';
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
        if (tokenIsValid) {
          Get.put(AssistanceVM());
          Get.put(AssistantWSVM());
          Get.put(AssistantVM());
          _initializeProfile();
          return HomeV();
        }
        return EnableLocationV();
      },
    );
  }

  Future<void> _initializeProfile() async {
    final assistantVM = Get.find<AssistantVM>();
    final token = await AuthApi.getAccessToken();
    if (token == null) return;
    final profile = await ProfileAPI.getProfile(token);
    if (profile == null) return;
    assistantVM.name = profile.name;
    assistantVM.email = profile.name;
    assistantVM.phoneNumber = profile.phoneNumber;
    assistantVM.currentLat = profile.currentLat;
    assistantVM.currentLng = profile.currentLng;
    assistantVM.serviceType = profile.serviceType;
    assistantVM.vehicleType = profile.vehicleType;
  }

}