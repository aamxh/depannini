import 'package:depannini_user/app/main/welcome_view.dart';
import 'package:depannini_user/app/settings/edit_profile_view.dart';
import 'package:depannini_user/app/settings/settings_tile_widget.dart';
import 'package:depannini_user/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsV extends StatelessWidget {

  const SettingsV({super.key});

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
            SizedBox(height: size.height * 0.1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.account_circle_rounded,
                  size: 100,
                ),
                SizedBox(width: size.width * 0.05,),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Mohammed',
                        style: theme.textTheme.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5,),
                      Text(
                        'a.a.mxhamed@gmail.com222222222',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5,),
                      TextButton(
                        onPressed: () {
                          Get.to(() => EditProfileV());
                        },
                        child: Text(
                          'Edit Profile',
                          style: theme.textTheme.titleSmall!.copyWith(
                            color: MyConstants.primaryC,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.1,),
            Column(
              children: [
                SizedBox(height: size.height * 0.03,),
                SettingsTileW(
                  title: 'Privacy policy',
                  icon: Icons.my_library_books,
                ),
                SizedBox(height: size.height * 0.03,),
                SettingsTileW(
                  title: 'Rate us',
                  icon: Icons.star,
                ),
                SizedBox(height: size.height * 0.03,),
                SettingsTileW(
                  title: 'Github repository',
                  icon: Icons.code,
                ),
              ],
            ),
            SizedBox(height: size.height * 0.1,),
            TextButton(
              onPressed: () {
                Get.offAll(() => WelcomeV());
              },
              child: Text(
                'Log out',
                style: theme.textTheme.titleLarge!.copyWith(
                  color: MyConstants.primaryC,
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text(
              'Version 0.0.0',
              style: theme.textTheme.bodyMedium!.copyWith(
                color: MyConstants.mediumGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }

}