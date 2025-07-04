import 'package:depannini_assistant/app/assistance/common/assistance_api.dart';
import 'package:depannini_assistant/app/assistance/view_models/assistance_view_model.dart';
import 'package:depannini_assistant/app/assistance/views/location_view.dart';
import 'package:depannini_assistant/app/assistance/view_models/location_view_model.dart';
import 'package:depannini_assistant/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TowingRequestDetailsV extends StatelessWidget {

  TowingRequestDetailsV({super.key});

  final _assistanceVM = Get.find<AssistanceVM>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.15,),
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
                  _assistanceVM.assistance.client.name,
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
              _assistanceVM.assistance.client.address,
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
              _assistanceVM.assistance.toAddress,
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
              _assistanceVM.assistance.vehicleType,
              style: theme.textTheme.bodyLarge,
            ),
            SizedBox(height: size.height * 0.06,),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final res = await AssistanceAPI.acceptAssistance(_assistanceVM.assistance.id.toString());
                  if (res) {
                    Get.put(LocationVM());
                    Get.to(() => LocationV());
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(size.width * 0.5, size.height * 0.064),
                  elevation: 0,
                ),
                child: Text(
                  'Accept',
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.01,),
            Center(
              child: TextButton(
                onPressed: () async {
                  await AssistanceAPI.closeWSConnection(Get.find<AssistanceVM>().channel);
                  Get.delete<AssistanceVM>();
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