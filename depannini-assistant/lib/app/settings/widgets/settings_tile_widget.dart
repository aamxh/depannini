import 'package:flutter/material.dart';

class SettingsTileW extends StatelessWidget {

  const SettingsTileW({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 35,
              ),
              SizedBox(width: 10,),
              Text(
                title,
                style: theme.textTheme.titleSmall,
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward,
            size: 25,
          ),
        ],
      ),
    );
  }

}