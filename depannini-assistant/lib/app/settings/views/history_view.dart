import 'package:depannini_assistant/core/constants.dart';
import 'package:flutter/material.dart';

class HistoryV extends StatelessWidget {

  const HistoryV({super.key});

  final List<Map<String, dynamic>> historyData = const [
    {
      'name': 'Adjal Anes',
      'type': 'Towing',
      'date': '2025-05-25',
      'price': 700,
    },
    {
      'name': 'Hammaidi Abdellatif',
      'type': 'Repair',
      'date': '2025-05-22',
      'price': 4500,
    },
    {
      'name': 'Moussouni Amine',
      'type': 'Repair',
      'date': '2025-05-20',
      'price': 3000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.08, vertical: 20),
        child: historyData.isEmpty ?
        Center(child: Text('Nothing here.', style: theme.textTheme.bodyLarge)) :
        ListView.builder(
          itemCount: historyData.length,
          itemBuilder: (context, index) {
            final item = historyData[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 20),
              elevation: 0,
              color: theme.scaffoldBackgroundColor == Colors.white ?
              MyConstants.lightGrey : MyConstants.darkGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'],
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Image.asset(
                          item['type'] == 'Towing' ?
                          theme.scaffoldBackgroundColor == Colors.white ?
                          'assets/icons/towing_light.png' :
                          'assets/icons/towing_dark.png' :
                          theme.scaffoldBackgroundColor == Colors.white ?
                          'assets/icons/repair_light.png' :
                          'assets/icons/repair_dark.png',
                          width: 30,
                        ),
                        const SizedBox(width: 8),
                        Text(item['type'], style: theme.textTheme.bodyLarge,),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.date_range_rounded,
                          size: 30,
                          color: theme.scaffoldBackgroundColor == Colors.white ?
                          MyConstants.darkGrey :
                          MyConstants.lightGrey,),
                        const SizedBox(width: 8),
                        Text(item['date'], style: theme.textTheme.bodyLarge,),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money,
                          size: 30,
                          color: theme.scaffoldBackgroundColor == Colors.white ?
                          MyConstants.darkGrey :
                          MyConstants.lightGrey,
                        ),
                        const SizedBox(width: 8),
                        Text('${item['price']} DA', style: theme.textTheme.bodyLarge,),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

}