import 'package:depannini_assistant/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TowingRequestDetailsV extends StatelessWidget {

  const TowingRequestDetailsV({super.key});

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
            SizedBox(height: size.height * 0.02,),
            Center(
              child: Text(
                'Towing request',
                style: theme.textTheme.headlineMedium,
              ),
            ),
            SizedBox(height: size.height * 0.06,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.account_circle_rounded,
                  size: 80,
                ),
                Text(
                  'Mohammed',
                  style: theme.textTheme.titleSmall,
                ),
              ],
            ),
            SizedBox(height: size.height * 0.04,),
            Text(
              'From: ',
              style: theme.textTheme.titleSmall,
            ),
            SizedBox(height: size.height * 0.01,),
            Text(
              '12 Rue Didouche Mourad, Alger Centre, Algiers, Algeria',
              style: theme.textTheme.bodyLarge,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: size.height * 0.04,),
            Text(
              'To: ',
              style: theme.textTheme.titleSmall,
            ),
            SizedBox(height: size.height * 0.01,),
            Text(
              '8 Rue Didouche Mourad, Alger Centre, Algiers, Algeria',
              style: theme.textTheme.bodyLarge,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: size.height * 0.04,),
            Text(
              'Vehicle type: ',
              style: theme.textTheme.titleSmall,
            ),
            SizedBox(height: size.height * 0.01,),
            Text(
              'Heavy',
              style: theme.textTheme.bodyLarge,
            ),
            SizedBox(height: size.height * 0.06,),
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
          ],
        ),
      ),
    );
  }

}