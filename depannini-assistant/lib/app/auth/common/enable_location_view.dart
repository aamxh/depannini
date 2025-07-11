import 'package:depannini_assistant/app/common/location_api.dart';
import 'package:depannini_assistant/app/common/view_models/assistant_view_model.dart';
import 'package:depannini_assistant/app/auth/common/welcome_view.dart';
import 'package:depannini_assistant/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EnableLocationV extends StatelessWidget {

  const EnableLocationV({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/map.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Container(
            width: size.width * 0.8,
            height: size.height * 0.6,
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enable location setting",
                  style: theme.textTheme.titleLarge,
                ),
                SizedBox(height: size.height * 0.02,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: Text(
                    'This will enable us to find the nearest assistants for you. It is necessary for registration.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                SizedBox(height: size.height * 0.06,),
                ElevatedButton(
                  onPressed: () async {
                    Get.dialog(
                      Center(child: CircularProgressIndicator(
                        color: MyConstants.primaryC,
                      ),),
                      barrierDismissible: false,
                    );
                    final res = await LocationApi.getCurrentLocation();
                    if (res == null || res.longitude == 0.0 || res.latitude == 0.0) {
                      Get.back;
                      return;
                    }
                    final address = await LocationApi.getLocationDescription(
                        LatLng(res.latitude!, res.longitude!),
                    );
                    Get.back;
                    if (address == null) return;
                    Get.put(AssistantVM(), permanent: true);
                    Get.find<AssistantVM>().currentLat = res.latitude!;
                    Get.find<AssistantVM>().currentLng = res.longitude!;
                    Get.find<AssistantVM>().address = address ?? '';
                    Get.to(() => WelcomeV());
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(size.width * 0.7, size.height * 0.064),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Use my location',
                    style: theme.textTheme.titleSmall!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}