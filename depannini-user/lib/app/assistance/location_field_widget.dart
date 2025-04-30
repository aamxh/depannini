import 'package:depannini_user/app/assistance/set_location_view.dart';
import 'package:depannini_user/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationFieldW extends StatelessWidget {

  const LocationFieldW({super.key, required this.label, required this.icon});

  final String label;
  final String icon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.titleSmall,
        ),
        SizedBox(height: size.height * 0.01,),
        ElevatedButton(
          onPressed: () {
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
                icon,
                width: 30,
              ),
              SizedBox(width: 20,),
              Text(
                'Set location',
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: MyConstants.mediumGrey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}