import 'package:flutter/material.dart';
import 'package:wealthflow/core/utils/responsive.dart';
import 'package:wealthflow/config/theme/textstyles/text_style_util.dart';

class PasswordRequirementTile extends StatelessWidget {
  final String text;
  final bool isMet;

  const PasswordRequirementTile({
    super.key,
    required this.text,
    required this.isMet,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Responsive.h(4)),
      child: Row(
        children: [
          Container(
            width: Responsive.w(18),
            height: Responsive.w(18),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isMet ? const Color(0xFF43A047) : const Color(0xFFE0E0E0),
                width: 2,
              ),
              color: isMet ? const Color(0xFF43A047) : Colors.transparent,
            ),
            child: isMet
                ? Icon(
                    Icons.check,
                    size: Responsive.w(12),
                    color: Colors.white,
                  )
                : null,
          ),
          SizedBox(width: Responsive.w(12)),
          Expanded(
            child: Text(
              text,
              style: TextStyleUtil.bodyMedium(
                color: isMet ? const Color(0xFF43A047) : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PasswordValidatorWidget extends StatelessWidget {
  final String password;

  const PasswordValidatorWidget({super.key, required this.password});

  bool get hasMinLength => password.length >= 8 && password.length <= 16;
  bool get hasNumber => password.contains(RegExp(r'[0-9]'));
  bool get hasSpecialChar => password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
  bool get hasUppercase => password.contains(RegExp(r'[A-Z]'));
  bool get hasLowercase => password.contains(RegExp(r'[a-z]'));

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password Requirements:',
          style: TextStyleUtil.bodyLarge(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        SizedBox(height: Responsive.h(12)),
        PasswordRequirementTile(
          text: '8-16 characters only',
          isMet: hasMinLength,
        ),
        PasswordRequirementTile(
          text: 'Atleast 1 number',
          isMet: hasNumber,
        ),
        PasswordRequirementTile(
          text: 'Atleast 1 special character like !@#\$',
          isMet: hasSpecialChar,
        ),
        PasswordRequirementTile(
          text: 'Atleast 1 upper case character',
          isMet: hasUppercase,
        ),
        PasswordRequirementTile(
          text: 'Atleast 1 lower case character',
          isMet: hasLowercase,
        ),
      ],
    );
  }
}
