import 'package:flutter/material.dart';

class SettingTermConditionPage extends StatefulWidget {
  const SettingTermConditionPage({super.key});

  @override
  State<SettingTermConditionPage> createState() =>
      _SettingTermConditionPageState();
}

class _SettingTermConditionPageState extends State<SettingTermConditionPage> {
  var terms =
      """ The legal agreement between Sipmaa and its users regarding the use of their platform in Sipmaa terms and conditions. 

User obligations and responsibilities: The terms outline the user's obligations when using the platform, including adherence to legal requirements, the accuracy of information provided, and appropriate behaviour.

Account creation and usage: section describes how to set up an account, what qualifications are necessary, and what obligations the user has to protect the privacy of their account information.

Intellectual property rights: Sipmaa terms address the ownership of content shared on the platform, including copyrights, trademarks, and licences.

Privacy and data protection: This section details how Sipmaa collects, uses, stores, and protects user data. It may include information about cookies, tracking technologies, and the choices users have regarding their privacy settings.

Prohibited actions include: Sipmaa terms typically outline activities that are not allowed on the platform, such as spamming, impersonation, and violations of intellectual property rights.

Resolution and termination of disputes: This section may include information about resolving disputes, limitations of liability, and the circumstances under which Sipmaa can terminate or suspend a user's account.

To access the specific terms of service for a related platform to Sipmaa, I recommend visiting the official website of that platform and locating the "Terms of Service," "Terms and Conditions," or a similar link usually found in the footer section of their webpages. By reviewing the terms directly from the official source, you can obtain the most accurate and up-to-date information regarding their specific terms of service.
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Terms & Condition'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Text(terms),
          ],
        ),
      )),
    );
  }
}
