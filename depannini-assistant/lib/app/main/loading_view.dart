import 'package:depannini_assistant/core/constants.dart';
import 'package:flutter/material.dart';

class LoadingV extends StatelessWidget {

  const LoadingV({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: MyConstants.primaryC,
                ),
                SizedBox(height: size.height * 0.02,),
                Text(
                  title,
                  style: theme.textTheme.titleLarge!.copyWith(
                    color: MyConstants.mediumGrey,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: size.height * 0.75,
            left: size.width * 0.25,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(size.width * 0.5, size.height * 0.064),
                  elevation: 0,
                ),
                child: Text(
                  'Cancel',
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }

}