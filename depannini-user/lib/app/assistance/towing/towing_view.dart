import 'package:depannini_user/app/assistance/assistance_api.dart';
import 'package:depannini_user/app/assistance/assistance_view_model.dart';
import 'package:depannini_user/app/assistance/models/assistance_request.dart';
import 'package:depannini_user/app/assistance/towing/towing_assistant_view.dart';
import 'package:depannini_user/app/assistance/location_view.dart';
import 'package:depannini_user/app/assistance/location_field_widget.dart';
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
                onToggle: (idx) => _vm.isHeavy = idx == 0 ? false : true,
              ),
            ),
            SizedBox(height: size.height * 0.04),
            LocationFieldW(id: 0),
            SizedBox(height: size.height * 0.04,),
            LocationFieldW(id: 1),
            SizedBox(height: size.height * 0.1),
            Center(
              child: Obx(() =>
                ElevatedButton(
                  onPressed: () async {
                    if (_vm.isReady) {
                      Get.dialog(
                        Center(child: CircularProgressIndicator(
                          color: MyConstants.primaryC,
                        ),),
                        barrierDismissible: false,
                      );
                      final res = await AssistanceAPI.requestAssistance(AssistanceRequest(
                        assistanceType: 'towing',
                        vehicleType: _vm.isHeavy ? 'heavy' : 'light',
                        pickup: {
                          "lat": _vm.fromLocation.latitude,
                          "lng": _vm.fromLocation.longitude
                        },
                        dropoff: {
                          "lat": _vm.toLocation.latitude,
                          "lng": _vm.toLocation.longitude
                        },
                        description: '',
                      ));
                      Get.back();
                      await Future.delayed(Duration(milliseconds: 100));
                      if (res != null) {
                        final vm = Get.find<AssistanceVM>();
                        vm.state = 'requested';
                        vm.channel = res;
                        Get.offAll(() => TowingAssistantV());
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(size.width * 0.6, size.height * 0.064),
                    elevation: 0,
                    backgroundColor: _vm.isReady ? MyConstants.primaryC :
                        theme.scaffoldBackgroundColor == Colors.white ?
                            MyConstants.lightGrey :
                            MyConstants.darkGrey,
                    side: BorderSide(
                      color: _vm.isReady ? MyConstants.primaryC :
                          theme.scaffoldBackgroundColor == Colors.white ?
                              MyConstants.darkGrey! :
                              MyConstants.lightGrey!,
                    ),
                  ),
                  child: Text(
                    'Request assistant',
                    style: theme.textTheme.titleSmall!.copyWith(
                      color: _vm.isReady ? Colors.white :
                          theme.scaffoldBackgroundColor == Colors.white ?
                              MyConstants.darkGrey :
                              MyConstants.lightGrey,
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