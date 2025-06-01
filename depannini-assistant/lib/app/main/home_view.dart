import 'package:depannini_assistant/app/assistance/assistance_api.dart';
import 'package:depannini_assistant/app/assistance/notifications_api.dart';
import 'package:depannini_assistant/app/main/home_view_model.dart';
import 'package:depannini_assistant/app/settings/settings_view.dart';
import 'package:depannini_assistant/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../core/theme_controller.dart';

class HomeV extends StatelessWidget {

  HomeV({super.key});

  final _vm = HomeVM();
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
            'Hello Mohammed,',
            style: theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: size.height * 0.01,),
          Obx(() =>
            Text(
              _vm.isActive.value ?
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
                // if (idx == 1) {
                //   final res =
                //   await NotificationsApi.verifyNotificationsEnabled();
                //   if (res) {
                //     NotificationsApi.sendNotification(
                //       'Incoming assistance request.',
                //       'Click to see more..',
                //     );
                //     _vm.changeActiveState(idx!);
                //   }
                // }
                final res =
                await AssistanceAPI.changeAssistantState(idx == 0 ? false : true);
                if (res) {
                  _vm.changeActiveState(idx!); 
                }
              },
            ),
          ),
          SizedBox(height: size.height * 0.02,),
          SizedBox(height: size.height * 0.02,),
        ],
      ),
    );
  }

}