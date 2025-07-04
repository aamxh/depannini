import 'package:flutter/material.dart';

class PrivacyPolicyV extends StatelessWidget {

  const PrivacyPolicyV({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.08, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.03,),
            Text(
              '''
This Privacy Policy explains how Depannini ("we", "our", or "us") collects, uses, and protects your information when you use our roadside assistance mobile application.

1. Information We Collect

We may collect the following types of information:
- Personal Information: Name, email address, phone number, and vehicle details.
- Location Data: For dispatching roadside assistance to your exact location.
- Usage Information: Details about how you interact with our app.

2. How We Use Your Information

We use your data to:
- Provide towing, repair, and emergency services.
- Improve app performance and features.
- Communicate with you for customer support and service updates.

3. Sharing Your Information

We do not sell your personal data. Your information may be common only with:
- Service providers (e.g., towing companies) to fulfill your request.
- Legal authorities if required by law.

4. Data Security

We implement appropriate measures to protect your data from unauthorized access, use, or disclosure.

5. Your Rights

You may:
- Access, update, or delete your personal data.
- Withdraw consent at any time by contacting us.

6. Third-Party Services

We are not responsible for the practices of third-party services linked within the app.

7. Updates to This Policy

We may update this policy occasionally. Changes will be notified via the app or email.

              ''',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: size.height * 0.06,),
          ],
        ),
      ),
    );
  }

}