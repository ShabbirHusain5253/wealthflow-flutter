import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wealthflow/core/utils/responsive.dart';
import 'package:wealthflow/config/theme/textstyles/text_style_util.dart';
import 'package:wealthflow/core/widgets/common_button.dart';
import 'package:go_router/go_router.dart';
import 'package:wealthflow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wealthflow/features/auth/presentation/bloc/auth_event.dart';
import 'package:wealthflow/features/auth/presentation/bloc/auth_state.dart';

class EmailInputPage extends StatefulWidget {
  const EmailInputPage({super.key});

  @override
  State<EmailInputPage> createState() => _EmailInputPageState();
}

class _EmailInputPageState extends State<EmailInputPage> {
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    final currentEmail = context.read<AuthBloc>().state.email;
    _emailController = TextEditingController(text: currentEmail);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F7F7),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Responsive.w(24)),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Responsive.h(40)),
                  Text(
                    'Enter Your Email',
                    style: TextStyleUtil.sentientStyle(
                      fontSize: Responsive.sp(32),
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFF1D2939),
                    ),
                  ),
                  SizedBox(height: Responsive.h(12)),
                  Text(
                    'Create a new account or continue where you left off.',
                    style: TextStyleUtil.bodyLarge(
                      color: const Color(0xFF667085),
                    ),
                  ),
                  SizedBox(height: Responsive.h(32)),
                  Text(
                    'Email',
                    style: TextStyleUtil.bodyMedium(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF344054),
                    ),
                  ),
                  SizedBox(height: Responsive.h(8)),
                  SizedBox(
                    height: Responsive.h(40),
                    child: TextField(
                      controller: _emailController,
                      onChanged: (value) =>
                          context.read<AuthBloc>().add(EmailChanged(value)),
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyleUtil.bodyMedium(),
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: Responsive.w(12),
                          vertical: 0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFFD0D5DD)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFFD0D5DD)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.h(24)),
                  RichText(
                    text: TextSpan(
                      style:
                          TextStyleUtil.bodyMedium(color: const Color(0xFF667085)),
                      children: [
                        const TextSpan(
                            text: 'By clicking on continue you agree with our '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: const TextStyle(
                            color: Color(0xFF00BFA5),
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.push('/auth/privacy-policy'),
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: const TextStyle(
                            color: Color(0xFF00BFA5),
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.push('/auth/terms-conditions'),
                        ),
                        const TextSpan(text: '.'),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: Responsive.h(24)),
                    child: CommonButton(
                      text: 'Continue',
                      height: Responsive.h(44),
                      isLoading: state.status == AuthStatus.loading,
                      onPressed: state.isEmailValid
                          ? () {
                              context.read<AuthBloc>().add(EmailSubmitted(state.email));
                              context.push('/auth/register/password', extra: state.email);
                            }
                          : null,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
