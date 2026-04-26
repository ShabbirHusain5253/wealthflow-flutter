import 'package:flutter/material.dart';
import 'package:wealthflow/core/utils/responsive.dart';
import 'package:wealthflow/config/theme/textstyles/text_style_util.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Responsive.w(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms & Conditions',
              style: TextStyleUtil.h2(),
            ),
            SizedBox(height: Responsive.h(24)),
            Text(
              'By accessing the app WealthFlow, you are agreeing to be bound by these terms of service, all applicable laws and regulations, and agree that you are responsible for compliance with any applicable local laws.',
              style: TextStyleUtil.bodyLarge(),
            ),
            SizedBox(height: Responsive.h(16)),
            Text(
              '1. Use License',
              style: TextStyleUtil.h4(),
            ),
            SizedBox(height: Responsive.h(8)),
            Text(
              'Permission is granted to temporarily download one copy of the materials (information or software) on WealthFlow\'s app for personal, non-commercial transitory viewing only.',
              style: TextStyleUtil.bodyMedium(),
            ),
          ],
        ),
      ),
    );
  }
}
