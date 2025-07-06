import 'package:depannini_assistant/app/assistance/common/assistance_api.dart';
import 'package:depannini_assistant/app/assistance/view_models/assistance_view_model.dart';
import 'package:depannini_assistant/app/common/view_models/assistant_view_model.dart';
import 'package:depannini_assistant/app/main/view_models/assistant_ws_view_model.dart';
import 'package:depannini_assistant/app/main/view_models/set_location_view_model.dart';
import 'package:depannini_assistant/app/main/views/set_location_view.dart';
import 'package:depannini_assistant/app/settings/views/settings_view.dart';
import 'package:depannini_assistant/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../core/theme_controller.dart';

class HomeV extends StatelessWidget {

  HomeV({super.key});

  final _assistantWSVM = Get.find<AssistantWSVM>();
  final _assistantVM = Get.find<AssistantVM>();
  final _ctrl = Get.find<ThemeCtrl>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: EdgeInsets.only(top: 5, left: 10),
          child: GestureDetector(
            onTap: () => _ctrl.switchTheme(),
            child: Icon(
              _ctrl.isDark ? Icons.nightlight_round : Icons.sunny,
              size: 35,
            ),
          ),
        ),
        title: Container(
          padding: EdgeInsets.only(top: 10),
          child: Image.asset(
            'assets/images/logo.png',
            width: size.width * 0.4,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          Container(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () => Get.to(() => SettingsV()),
              child: Icon(Icons.account_circle_rounded, size: 40,),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: size.height * 0.05),
          Text(
            'Hello ${_assistantVM.name},',
            style: theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: size.height * 0.01,),
          Obx(() =>
            Text(
              _assistantWSVM.channel != null ?
              'switching to inactive mode will make you unavailable for requests from clients.' :
              'you can switch to active mode to receive requests from clients.',
              style: theme.textTheme.titleSmall!.copyWith(
                color: MyConstants.mediumGrey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: size.height * 0.05,),
          Center(
            child: ToggleSwitch(
              totalSwitches: 2,
              labels: ['Inactive', "Active"],
              initialLabelIndex: 0,
              inactiveBgColor: theme.scaffoldBackgroundColor,
              activeBgColor: [MyConstants.primaryC],
              activeFgColor: Colors.white,
              inactiveFgColor: theme.colorScheme.secondary,
              minHeight: size.height * 0.07,
              minWidth: size.width * 0.3,
              borderColor: [MyConstants.mediumGrey!],
              borderWidth: 1,
              fontSize: 22,
              cornerRadius: 20,
              onToggle: (idx) async {
                if (idx == 1) {
                  final res = await AssistanceAPI.changeAssistantState(true);
                  _assistantWSVM.channel = await AssistanceAPI.connectToAssistantWS(_assistantWSVM.id);
                  if (_assistantWSVM.channel != null && res) {
                    Get.put(AssistanceVM());
                    _assistantWSVM.startListening();
                  }
                } else {
                  await AssistanceAPI.changeAssistantState(false);
                  await AssistanceAPI.closeWSConnection(_assistantWSVM.channel);
                }
              },
            ),
          ),
          SizedBox(height: size.height * 0.02,),
          Text(
            _assistantVM.address,
            style: theme.textTheme.bodyLarge,
          ),
          SizedBox(height: size.height * 0.02,),
          ElevatedButton(
            onPressed: () {
              Get.put(SetLocationVM());
              Get.to(() => SetLocationV());
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              fixedSize: Size(size.width * 0.4, size.height * 0.064),
            ),
            child: Text(
              'Update Location',
              style: theme.textTheme.titleSmall!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

}