import 'package:depannini_user/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RepairAssistantV extends StatelessWidget {

  const RepairAssistantV({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.15,),
            Text(
              'Available repair assistant',
              style: theme.textTheme.headlineSmall,
            ),
            SizedBox(height: size.height * 0.15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.account_circle_rounded,
                      size: 80,
                    ),
                    SizedBox(width: 10,),
                    Column(
                      children: [
                        Text(
                          'Anes Adjal',
                          style: theme.textTheme.titleSmall,
                        ),
                        SizedBox(height: 5,),
                        Text(
                          '1.2 km away',
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
                Image.asset(
                  theme.scaffoldBackgroundColor == Colors.white ?
                  'assets/icons/repair_light.png' :
                  'assets/icons/repair_dark.png',
                  width: 40,
                ),
              ],
            ),
            SizedBox(height: size.height * 0.15,),
            Center(
              child: ElevatedButton(
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(size.width * 0.5, size.height * 0.064),
                  elevation: 0,
                ),
                child: Text(
                  'Accept',
                  style: theme.textTheme.titleSmall,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.01,),
            Center(
              child: TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Refuse',
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: theme.scaffoldBackgroundColor == Colors.white ?
                    MyConstants.darkGrey : MyConstants.lightGrey,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02,),
            SizedBox(height: size.height * 0.02,),
          ],
        ),
      ),
    );
  }

}