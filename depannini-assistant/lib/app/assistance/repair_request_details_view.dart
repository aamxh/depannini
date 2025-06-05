import 'package:depannini_assistant/app/assistance/assistance_api.dart';
import 'package:depannini_assistant/app/assistance/assistance_view_model.dart';
import 'package:depannini_assistant/app/assistance/location_view.dart';
import 'package:depannini_assistant/app/assistance/location_view_model.dart';
import 'package:depannini_assistant/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RepairRequestDetailsV extends StatelessWidget {

  RepairRequestDetailsV({super.key});

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
                'Repair request',
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
              'Client\'s location: ',
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
              'Description: ',
              style: theme.textTheme.titleSmall,
            ),
            SizedBox(height: size.height * 0.01,),
            Text(
              _assistanceVM.assistance.description,
              style: theme.textTheme.bodyLarge,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: size.height * 0.06,),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final res = await AssistanceAPI.acceptAssistance(_assistanceVM.assistance.id.toString());
                  if (res) {
                    Get.put(LocationVM());
                    await Future.delayed(Duration(milliseconds: 100));
                    Get.to(() => LocationV());
                  }
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