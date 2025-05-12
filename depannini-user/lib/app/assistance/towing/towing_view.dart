import 'package:depannini_user/app/assistance/confirm_request_view.dart';
import 'package:depannini_user/app/assistance/set_location_view.dart';
import 'package:depannini_user/app/assistance/set_location_view_model.dart';
import 'package:depannini_user/app/assistance/towing/towing_view_model.dart';
import 'package:depannini_user/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class TowingV extends StatelessWidget {

  TowingV({super.key});

  final _vm = Get.find<TowingVM>();

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
                onToggle: (idx) {
                  _vm.changeIsHeavy(idx == 0 ? false : true);
                },
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'From',
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: size.height * 0.01,),
                ElevatedButton(
                  onPressed: () {
                    Get.find<SetLocationVM>().changeId(1);
                    Get.to(() => SetLocationV());
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(size.width * 0.8, size.height * 0.064),
                    elevation: 0,
                    side: BorderSide(
                      color: theme.colorScheme.secondary,
                      width: 2,
                    ),
                    backgroundColor: theme.scaffoldBackgroundColor,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        theme.scaffoldBackgroundColor == Colors.white ?
                        'assets/icons/from_light.png' :
                        'assets/icons/from_dark.png',
                        width: 30,
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Obx(() => _vm.addressFrom.isEmpty ?
                          Text(
                            'Set location',
                            style: theme.textTheme.bodyLarge!.copyWith(
                              color: MyConstants.mediumGrey,
                            ),
                          ) :
                          Text(
                            _vm.addressFrom,
                            style: theme.textTheme.bodySmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.04,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'To',
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: size.height * 0.01,),
                ElevatedButton(
                  onPressed: () {
                    Get.find<SetLocationVM>().changeId(2);
                    Get.to(() => SetLocationV());
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(size.width * 0.8, size.height * 0.064),
                    elevation: 0,
                    side: BorderSide(
                      color: theme.colorScheme.secondary,
                      width: 2,
                    ),
                    backgroundColor: theme.scaffoldBackgroundColor,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        theme.scaffoldBackgroundColor == Colors.white ?
                        'assets/icons/to_light.png' :
                        'assets/icons/to_dark.png',
                        width: 30,
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Obx(() => _vm.addressTo.isEmpty ?
                          Text(
                            'Set location',
                            style: theme.textTheme.bodyLarge!.copyWith(
                              color: MyConstants.mediumGrey,
                            ),
                          ) :
                          Text(
                            _vm.addressTo,
                            style: theme.textTheme.bodySmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.1),
            Center(
              child: Obx(() => ElevatedButton(
                  onPressed: () {
                    if (_vm.isReady()) {
                      Get.to(() => ConfirmRequestV());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    fixedSize: Size(size.width * 0.6, size.height * 0.064),
                    backgroundColor: _vm.isReady() ? MyConstants.primaryC :
                        theme.scaffoldBackgroundColor == Colors.white ?
                            MyConstants.lightGrey :
                            MyConstants.darkGrey,
                    side: BorderSide(
                      color: _vm.isReady() ? MyConstants.primaryC :
                          theme.scaffoldBackgroundColor == Colors.white ?
                              MyConstants.mediumGrey! :
                              MyConstants.lightGrey!,
                    ),
                  ),
                  child: Text(
                    'Request assistant',
                    style: theme.textTheme.titleSmall!.copyWith(
                      color: _vm.isReady() ? Colors.white : theme.colorScheme.secondary,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}