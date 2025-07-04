import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class EndAssistanceV extends StatefulWidget {

  const EndAssistanceV({super.key});

  @override
  State<EndAssistanceV> createState() => _EndAssistanceVState();
}

class _EndAssistanceVState extends State<EndAssistanceV> {

  double _rating = 0;

  void _handleEnd() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Assistance ended. Thank you!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assistant Info'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.1,
          vertical: size.height * 0.1,
        ),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.account_circle_rounded, size: 100,),
              SizedBox(height: size.height * 0.02),
              Text(
                'Abdelkader R.',
                style: theme.textTheme.titleLarge,
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                'Assistance Type: Towing',
                style: theme.textTheme.bodyMedium,
              ),
              SizedBox(height: size.height * 0.05),
              Text(
                'Price: 1200 D.A.',
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: size.height * 0.05),
              Text(
                'Rate your experience: ',
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: size.height * 0.01),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                glow: false,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              SizedBox(height: size.height * 0.1),
              ElevatedButton(
                  onPressed: _handleEnd,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    fixedSize: Size(size.width * 0.5, size.height * 0.064),
                  ),
                child: Text(
                  'End',
                  style: theme.textTheme.titleSmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}