import 'package:flutter/material.dart';

class RequestDetailsV extends StatelessWidget {

  const RequestDetailsV({super.key});

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

          ],
        ),
      ),
    );
  }

}