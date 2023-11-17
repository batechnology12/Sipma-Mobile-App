import 'package:flutter/material.dart';

class SettingprivacyPage extends StatefulWidget {
  const SettingprivacyPage({super.key});

  @override
  State<SettingprivacyPage> createState() => _SettingprivacyPageState();
}

class _SettingprivacyPageState extends State<SettingprivacyPage> {
  var privacy = """Our Privacy Policy has been updated.

Your Privacy Matters:

Sipmaa mission is to connect the world’s professionals to allow them to be more productive and successful. Central to this mission is our commitment to be transparent about the data we collect about you, how it is used and with whom it is shared.

This Privacy Policy applies when you use our Services. We offer our users choices about the data we collect, use and share as described in this Privacy Policy, Cookie Policy, Settings and our Help Center.


Introduction:
We are a social network and online platform for professionals. People use our Services to find and be found for business opportunities, to connect with others and find information. Our Privacy Policy applies to any Member or

Services:
This Privacy Policy, including our Cookie Policy applies to your use of our Services.

This Privacy Policy applies to Sipmaa, Sipmaa -branded apps,Sipmaa Learning and other Sipmaa-related sites, apps, communications and services (“Services”), including off-site Services, such as our ad services and the “Apply with Sipmaa” and “Share with Sipmaa” plugins, but excluding services that state that they are offered under a different privacy policy.
Sipmaa Corporation will be the controller of your personal data provided to, or collected by or for, or processed in connection with, our Services.
As a Visitor or Member of our Services, the collection, use and sharing of your personal data is subject to this Privacy Policy and other documents referenced in this Privacy Policy, as well as updates.
\nInformation We Collect: 
We collect information you provide during registration, such as your name, email address, and professional details. We also collect data generated through your use of our platform, including profile information, connections, messages, and engagement with content.
Use of Information: 
We use the collected information to provide and personalize our services, connect professionals, enable communication, and improve user experience. This includes suggesting relevant content, job opportunities, and connections, as well as enhancing our advertising targeting capabilities.
\nData Sharing: 
We may share your information with trusted third parties, including service providers and partners, to assist us in delivering our services and enhancing your Sipmaa experience. We do not sell your personal information to advertisers or other third parties.
Control over Your Information:
 You have control over the information you provide on Sipmaa. You can manage your profile settings, choose what information to share publicly, and control the visibility of your connections and activities.
Communication: 
We may send you emails, notifications, and other messages related to your account and activity onSipmaa. You can manage your communication preferences and opt-out of certain types of messages.
Data Security: 
We employ industry-standard security measures to protect your information from unauthorized access, disclosure, alteration, and destruction. We continuously monitor and update our systems to ensure the highest level of data protection.
\nData Transfers:
Sipmaa operates globally, and your information may be transferred to and stored on servers located in different countries. We ensure that such transfers comply with applicable data protection laws.
Compliance: 
We comply with applicable privacy laws and regulations, including the European Union's General Data Protection Regulation (GDPR) and the California Consumer Privacy Act (CCPA).
\nUpdates and Contact: 
We may update our Privacy Policy from time to time and will notify you of any significant changes. If you have questions, concerns, or requests regarding your privacy or data, you can contact us through the provided channels.
Sipmaa Privacy Policy aims to provide a general understanding of how we handle your data. For more detailed information, we encourage you to read our complete Privacy Policy available on our website. 
Contact Information:
If you have questions or complaints regarding this Policy, please first contact Sipmaa. You can also reach us by physical mail. If this does not resolve your complaint, Residents in the Designated Countries and other regions may have more options under their laws.
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy'),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
             const SizedBox(
                height: 15,
              ),
              Text(privacy),
            ],
          ),
        ),
      ),
    );
  }
}
