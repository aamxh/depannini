import 'package:depannini_user/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:depannini_user/app/assistance/repair/repair_view.dart';
import 'package:depannini_user/app/assistance/towing/towing_view.dart';

class CardW extends StatelessWidget {

  const CardW({super.key, required this.isTowing});

  final bool isTowing;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        if (isTowing) {
          Get.to(() => TowingV());
        }
        else {
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