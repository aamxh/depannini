import 'package:flutter/material.dart';
import 'package:depannini_user/core/constants.dart';
import 'package:get/get.dart';

class AcceptedRequestV extends StatelessWidget {

  const AcceptedRequestV({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/map.png',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.06,
            maxChildSize: 0.7,
            builder: (context, ctrl) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                color: theme.scaffoldBackgroundColor,
              ),
              child: SingleChildScrollView(
                controller: ctrl,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: Column(
                  children: [
                    SizedBox(height: 15,),
                    Container(
                      width: size.width * 0.3,
                      height: 3,
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor == Colors.white ?
                        MyConstants.darkGrey : MyConstants.lightGrey,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Text(
                      'We\'ve found you an assistant',
                      style: theme.textTheme.titleMedium,
                    ),
                    SizedBox(height: size.height * 0.025),
                    Container(
                      color: theme.scaffoldBackgroundColor == Colors.white ?
                      MyConstants.darkGrey : MyConstants.lightGrey,
                      width: size.width,
                      height: 1,
                    ),
                    SizedBox(height: size.height * 0.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.account_circle_rounded,
                              size: 70,
                            ),
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Anes Adjal',
                                  style: theme.textTheme.bodyLarge,
                                ),
                                Text(
                                  '800 m away',
                                  style: theme.textTheme.bodyMedium,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star_rate,
                                      color: MyConstants.primaryC,
                                    ),
                                    SizedBox(width: 5,),
                                    Text(
                                      '4.5/5',
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Image.asset(
                          theme.scaffoldBackgroundColor == Colors.white ?
                          'assets/icons/towing_light.png' :
                          'assets/icons/towing_dark.png',
                          width: 50,
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01,),
                    Container(
                      color: theme.scaffoldBackgroundColor == Colors.white ?
                      MyConstants.darkGrey : MyConstants.lightGrey,
                      width: size.width,
                      height: 1,
                    ),
                    SizedBox(height: size.height * 0.1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {

                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(size.width * 0.3, size.height * 0.064),
                            elevation: 0,
                          ),
                          child: Text(
                            'Confirm',
                            style: theme.textTheme.titleSmall!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(size.width * 0.3, size.height * 0.064),
                            backgroundColor:
                            theme.scaffoldBackgroundColor == Colors.white ?
                            MyConstants.lightGrey : MyConstants.mediumGrey,
                            side: BorderSide(
                              color: theme.scaffoldBackgroundColor == Colors.white ?
                                  MyConstants.darkGrey! : MyConstants.lightGrey!,
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Cancel',
                            style: theme.textTheme.titleSmall!.copyWith(
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}