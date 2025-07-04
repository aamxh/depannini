import 'package:depannini_user/app/assistance/view_models/repair_view_model.dart';
import 'package:depannini_user/app/assistance/views/set_location_view.dart';
import 'package:depannini_user/app/assistance/view_models/set_location_view_model.dart';
import 'package:depannini_user/app/assistance/view_models/towing_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationFieldW extends StatelessWidget {

  const LocationFieldW({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Obx(() =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            id == 0 ? 'From' : id == 1 ? 'To' : 'Your location',
            style: theme.textTheme.titleSmall,
          ),
          SizedBox(height: size.height * 0.01,),
          ElevatedButton(
            onPressed: () {
              Get.put(SetLocationVM());
              Get.find<SetLocationVM>().id = id;
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
                  id == 1 ? theme.scaffoldBackgroundColor == Colors.white ?
                  'assets/icons/to_light.png' :
                  'assets/icons/to_dark.png' :
                  theme.scaffoldBackgroundColor == Colors.white ?
                  'assets/icons/from_light.png' :
                  'assets/icons/from_dark.png',
                  width: 30,
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Text(
                    id == 0 ?
                    Get.find<TowingVM>().fromAddress :
                    id == 1 ?
                    Get.find<TowingVM>().toAddress :
                    Get.find<RepairVM>().address,
                    style: theme.textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
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