import 'package:flutter/material.dart';
import 'package:wealthflow/core/utils/responsive.dart';
import 'package:wealthflow/config/theme/textstyles/text_style_util.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Responsive.w(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyleUtil.h2(),
            ),
            SizedBox(height: Responsive.h(24)),
            Text(
              'Your privacy is important to us. It is WealthFlow\'s policy to respect your privacy regarding any information we may collect from you across our website and app.',
              style: TextStyleUtil.bodyLarge(),
            ),
            SizedBox(height: Responsive.h(16)),
            Text(
              '1. Information we collect',
              style: TextStyleUtil.h4(),
            ),
            SizedBox(height: Responsive.h(8)),
            Text(
              'We only ask for personal information when we truly need it to provide a service to you. We collect it by fair and lawful means, with your knowledge and consent.',
              style: TextStyleUtil.bodyMedium(),
            ),
            // ... more dummy content
          ],
        ),
      ),
    );
  }
}
