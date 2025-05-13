import 'package:depannini_user/app/assistance/accepted_request_view.dart';
import 'package:depannini_user/app/assistance/location_field_widget.dart';
import 'package:depannini_user/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class TowingV extends StatelessWidget {

  const TowingV({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.05),
            Center(
              child: Text(
                'Towing service',
                style: theme.textTheme.headlineMedium,
              ),
            ),
            SizedBox(height: size.height * 0.1),
            Text(
              'Your vehicle type',
              style: theme.textTheme.titleSmall,
            ),
            SizedBox(height: size.height * 0.01),
            Center(
              child: ToggleSwitch(
                totalSwitches: 2,
                labels: ['Light', "Heavy"],
                initialLabelIndex: 0,
                inactiveBgColor: theme.scaffoldBackgroundColor,
                activeBgColor: [MyConstants.primaryC],
                activeFgColor: Colors.white,
                inactiveFgColor: theme.colorScheme.secondary,
                minHeight: size.height * 0.05,
                minWidth: size.width * 0.25,
                borderColor: [MyConstants.mediumGrey!],
                borderWidth: 1,
                fontSize: 18,
                cornerRadius: 20,
                onToggle: (idx) {},
              ),
            ),
            SizedBox(height: size.height * 0.04),
            LocationFieldW(
              label: 'From',
              icon: theme.scaffoldBackgroundColor == Colors.white ?
              'assets/icons/from_light.png' :
              'assets/icons/from_dark.png',
            ),
            SizedBox(height: size.height * 0.04,),
            LocationFieldW(
              label: 'To',
              icon: theme.scaffoldBackgroundColor == Colors.white ?
              'assets/icons/to_light.png' :
              'assets/icons/to_dark.png',
            ),
            SizedBox(height: size.height * 0.1),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => AcceptedRequestV());
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(size.width * 0.6, size.height * 0.064),
                ),
                child: Text(
                  'Request assistant',
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: Colors.white,
                  ),
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}