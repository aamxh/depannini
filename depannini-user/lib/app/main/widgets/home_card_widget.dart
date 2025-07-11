import 'package:depannini_user/app/assistance/view_models/repair_view_model.dart';
import 'package:depannini_user/app/assistance/view_models/set_location_view_model.dart';
import 'package:depannini_user/app/assistance/view_models/towing_view_model.dart';
import 'package:depannini_user/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:depannini_user/app/assistance/views/repair_view.dart';
import 'package:depannini_user/app/assistance/views/towing_view.dart';

class CardW extends StatelessWidget {

  const CardW({super.key, required this.isTowing});

  final bool isTowing;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Get.put(SetLocationVM());
        Get.put(TowingVM());
        Get.put(RepairVM());
        if (isTowing) {
          Get.put(TowingVM());
          Get.to(() => TowingV());
        }
        else {
          Get.put(RepairVM());
          Get.to(() => RepairV());
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor == Colors.white ?
          MyConstants.lightGrey :
          MyConstants.darkGrey,
          borderRadius: BorderRadius.circular(20),
        ),
        width: size.width * 0.3,
        height: size.width * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              isTowing ? theme.scaffoldBackgroundColor == Colors.white ?
              'assets/icons/towing_light.png' :
              'assets/icons/towing_dark.png' :
              theme.scaffoldBackgroundColor == Colors.white ?
              'assets/icons/repair_light.png' :
              'assets/icons/repair_dark.png',
              width: 50,
            ),
            Text(
              isTowing ? 'Towing' : 'Repair',
              style: theme.textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

}