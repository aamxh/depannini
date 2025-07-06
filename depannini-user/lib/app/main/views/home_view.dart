import 'package:depannini_user/app/common/view_models/client_view_model.dart';
import 'package:depannini_user/app/main/widgets/home_card_widget.dart';
import 'package:depannini_user/app/settings/views/settings_view.dart';
import 'package:depannini_user/core/constants.dart';
import 'package:depannini_user/core/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeV extends StatelessWidget {

  HomeV({super.key});

  final _ctrl = Get.find<ThemeCtrl>();
  final _vm = Get.find<ClientVM>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: EdgeInsets.only(left: 10, top: 5,),
          child: Obx(() => GestureDetector(
              onTap: () => _ctrl.switchTheme(),
              child: Icon(
                _ctrl.isDark ? Icons.nightlight_round : Icons.sunny,
                size: 35,
              ),
            ),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.only(top: 10),
          child: Image.asset(
            'assets/images/logo.png',
            width: size.width * 0.4,
          ),
        ),
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
            'Hello ${_vm.name}',
            style: theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: size.height * 0.01,),
          Text(
            'choose the type of assistance you need: ',
            style: theme.textTheme.titleSmall!.copyWith(
              color: MyConstants.mediumGrey,
            ),
          ),
          SizedBox(height: size.height * 0.05,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardW(isTowing: true),
              CardW(isTowing: false),
            ],
          ),
          SizedBox(height: size.height * 0.02,),
        ],
      ),
    );
  }

}