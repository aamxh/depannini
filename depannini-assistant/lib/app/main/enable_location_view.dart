import 'package:depannini_assistant/app/assistance/location_api.dart';
import 'package:depannini_assistant/app/main/assistant_view_model.dart';
import 'package:depannini_assistant/app/main/welcome_view.dart';
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
              children: [
                SizedBox(height: size.height * 0.06,),
                Image.asset('assets/images/location.png', width: size.width * 0.4,),
                SizedBox(height: size.height * 0.02,),
                Text(
                  "Enable location setting",
                  style: theme.textTheme.titleLarge,
                ),
                SizedBox(height: size.height * 0.02,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: Text(
                    'This will enable us to find the nearest assistants for you.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium!.copyWith(color: MyConstants.darkGrey),
                  ),
                ),
                SizedBox(height: size.height * 0.04,),
                ElevatedButton(
                  onPressed: () async {
                    Get.dialog(
                      Center(child: CircularProgressIndicator(
                        color: MyConstants.primaryC,
                      ),),
                      barrierDismissible: false,
                    );
                    final res = await LocationApi.getCurrentLocation();
                    Get.back;
                    if (res == null) return;
                    Get.put(AssistantVM());
                    Get.find<AssistantVM>().location =
                    (LatLng(res.latitude!, res.longitude!));
                    Get.off(() => WelcomeV());
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(size.width * 0.7, size.height * 0.064),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Use my location',
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02,),
                TextButton(
                  onPressed: () {
                    Get.put(AssistantVM());
                    Get.off(() => WelcomeV());
                  },
                  child: Text(
                    'Skip for now',
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: MyConstants.mediumGrey,
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