import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wealthflow/config/router/app_routes.dart';
import 'package:wealthflow/core/utils/responsive.dart';
import 'package:wealthflow/config/theme/textstyles/text_style_util.dart';
import 'package:wealthflow/core/widgets/common_button.dart';
import 'package:wealthflow/core/utils/common_assets_viewer.dart';
import 'package:wealthflow/features/auth/presentation/widgets/password_validator_widget.dart';
import 'package:wealthflow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wealthflow/features/auth/presentation/bloc/auth_event.dart';
import 'package:wealthflow/features/auth/presentation/bloc/auth_state.dart';
import 'package:go_router/go_router.dart';

class PasswordInputPage extends StatefulWidget {
  final String email;

  const PasswordInputPage({super.key, required this.email});

  @override
  State<PasswordInputPage> createState() => _PasswordInputPageState();
}

class _PasswordInputPageState extends State<PasswordInputPage> {
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    final currentPassword = context.read<AuthBloc>().state.password;
    _passwordController = TextEditingController(text: currentPassword);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AuthStatus.error && state.errorMessage != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage!)));

          if (state.errorMessage!.contains('already registered')) {
            context.read<AuthBloc>().add(const ResetAuthRequested());
            context.go(AppRoutes.registerEmail);
          }
        } else if (state.status == AuthStatus.authenticated) {
          context.go(AppRoutes.dashboard);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F7F7),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.w(24)),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Responsive.h(40)),
                            Text(
                              'Set Password',
                              style: TextStyleUtil.sentientStyle(
                                fontSize: Responsive.sp(32),
                                fontWeight: FontWeight.normal,
                                color: const Color(0xFF1D2939),
                              ),
                            ),
                            SizedBox(height: Responsive.h(12)),
                            Text(
                              'Create a strong password to secure your account.',
                              style: TextStyleUtil.bodyLarge(
                                color: const Color(0xFF667085),
                              ),
                            ),
                            SizedBox(height: Responsive.h(32)),
                            Text(
                              'Password',
                              style: TextStyleUtil.bodyMedium(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF344054),
                              ),
                            ),
                            SizedBox(height: Responsive.h(8)),
                            SizedBox(
                              height: Responsive.h(40),
                              child: TextField(
                                controller: _passwordController,
                                obscureText: !state.isPasswordVisible,
                                onChanged: (value) => context
                                    .read<AuthBloc>()
                                    .add(PasswordChanged(value)),
                                style: TextStyleUtil.bodyMedium(),
                                decoration: InputDecoration(
                                  hintText: 'Enter your password',
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: Responsive.w(12),
                                    vertical: 0,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      state.isPasswordVisible
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: const Color(0xFF667085),
                                      size: Responsive.w(20),
                                    ),
                                    onPressed: () => context
                                        .read<AuthBloc>()
                                        .add(const TogglePasswordVisibility()),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Color(0xFFD0D5DD)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Color(0xFFD0D5DD)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: Responsive.h(24)),
                            PasswordValidatorWidget(
                                password: _passwordController.text),
                            SizedBox(height: Responsive.h(24)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonAssetsViewer(
                                  svgPath: 'assets/svgs/alert.svg',
                                  width: Responsive.w(32),
                                  height: Responsive.w(32),
                                ),
                                SizedBox(width: Responsive.w(12)),
                                Expanded(
                                  child: Text(
                                    'We use bank-grade encryption and multi-layer protection to keep your financial data safe from day one.',
                                    style: TextStyleUtil.bodySmall(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Responsive.h(16)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: Responsive.h(24), top: Responsive.h(12)),
                      child: Column(
                        children: [
                          CommonButton(
                            text: 'Set Password',
                            height: Responsive.h(44),
                            isLoading: state.status == AuthStatus.loading,
                            onPressed: state.isPasswordValid
                                ? () {
                                    context.read<AuthBloc>().add(
                                        PasswordSubmitted(
                                            state.email, state.password));
                                    context
                                        .read<AuthBloc>()
                                        .add(RegisterRequested());
                                  }
                                : null,
                          ),
                          SizedBox(height: Responsive.h(16)),
                          TextButton(
                            onPressed: () {
                              context
                                  .read<AuthBloc>()
                                  .add(const MockAuthRequested());
                            },
                            child: Text(
                              'Skip Sign Up (Mock Dashboard)',
                              style: TextStyleUtil.bodyMedium(
                                color: const Color(0xFF083332),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
