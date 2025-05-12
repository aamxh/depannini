import 'package:depannini_assistant/app/assistance/set_location_view.dart';
import 'package:depannini_assistant/app/assistance/set_location_view_model.dart';
import 'package:depannini_assistant/app/main/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                    'This will enable us to find the nearest assistants for you.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                SizedBox(height: size.height * 0.06,),
                ElevatedButton(
                  onPressed: () {
                    Get.put(SetLocationVM());
                    Get.to(() => SetLocationV());
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
                SizedBox(height: size.height * 0.02,),
                TextButton(
                  onPressed: () {
                    Get.off(() => WelcomeV());
                  },
                  child: Text(
                    'Skip for now',
                    style: theme.textTheme.titleSmall,
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