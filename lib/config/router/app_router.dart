import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/email_input_page.dart';
import '../../features/auth/presentation/pages/password_input_page.dart';
import '../../features/auth/presentation/pages/privacy_policy_page.dart';
import '../../features/auth/presentation/pages/terms_conditions_page.dart';
import '../../features/auth/presentation/pages/success_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/dashboard/presentation/pages/onboarding_dashboard.dart';
import '../../features/get_started/presentation/pages/get_started_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import 'package:wealthflow/core/utils/common_assets_viewer.dart';
import 'package:wealthflow/config/theme/textstyles/text_style_util.dart';
import 'package:wealthflow/core/gen/assets.gen.dart';
import 'app_routes.dart';

class MainShell extends StatefulWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0
          ? widget.child
          : Center(
              child: Text(
                'Coming Soon',
                style: TextStyleUtil.h3(color: const Color(0xFF667085)),
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF083332),
        unselectedItemColor: const Color(0xFF667085),
        selectedLabelStyle:
            TextStyleUtil.bodySmall(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyleUtil.bodySmall(),
        items: [
          BottomNavigationBarItem(
            icon: CommonAssetsViewer(
              svgPath: Assets.svgs.dashboard.homeInactive.path,
              width: 24,
              height: 24,
            ),
            activeIcon: CommonAssetsViewer(
              svgPath: Assets.svgs.dashboard.homeActive.path,
              width: 24,
              height: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: CommonAssetsViewer(
              svgPath: Assets.svgs.dashboard.assetsInactive.path,
              width: 24,
              height: 24,
            ),
            activeIcon: CommonAssetsViewer(
              svgPath: Assets.svgs.dashboard.assetsActive.path,
              width: 24,
              height: 24,
            ),
            label: 'Assets & Liabilities',
          ),
          BottomNavigationBarItem(
            icon: CommonAssetsViewer(
              svgPath: Assets.svgs.dashboard.wealthFlowInactive.path,
              width: 24,
              height: 24,
            ),
            activeIcon: CommonAssetsViewer(
              svgPath: Assets.svgs.dashboard.wealthFlowActive.path,
              width: 24,
              height: 24,
            ),
            label: 'WealthFlow',
          ),
          BottomNavigationBarItem(
            icon: CommonAssetsViewer(
              svgPath: Assets.svgs.dashboard.hoxtonInactive.path,
              width: 24,
              height: 24,
            ),
            activeIcon: CommonAssetsViewer(
              svgPath: Assets.svgs.dashboard.hoxtonActive.path,
              width: 24,
              height: 24,
            ),
            label: 'My Hoxton',
          ),
        ],
      ),
    );
  }
}

class RouterNotifier extends ChangeNotifier {
  final AuthBloc _authBloc;

  RouterNotifier(this._authBloc) {
    _authBloc.stream.listen((state) {
      notifyListeners();
    });
  }
}

class AppRouter {
  final AuthBloc authBloc;
  late final GoRouter router;

  AppRouter(this.authBloc) {
    router = GoRouter(
      initialLocation: AppRoutes.splash,
      refreshListenable: RouterNotifier(authBloc),
      redirect: (context, state) {
        final authState = authBloc.state;

        final isSplash = state.uri.path == AppRoutes.splash;
        final isGetStarted = state.uri.path == AppRoutes.getStarted;
        final isLogin = state.uri.path == AppRoutes.login;
        final isRegisterEmail = state.uri.path == AppRoutes.registerEmail;
        final isRegisterPassword = state.uri.path == AppRoutes.registerPassword;
        final isPrivacy = state.uri.path == AppRoutes.privacyPolicy;
        final isTerms = state.uri.path == AppRoutes.termsConditions;
        final isSuccess = state.uri.path == AppRoutes.success;

        final isPublicRoute = isSplash ||
            isGetStarted ||
            isLogin ||
            isRegisterEmail ||
            isRegisterPassword ||
            isPrivacy ||
            isTerms ||
            isSuccess;

        if (authState.status == AuthStatus.initial) return null;

        final isAuthenticated = authState.status == AuthStatus.authenticated;

        if (!isAuthenticated && !isPublicRoute) {
          return AppRoutes.getStarted;
        }

        if (isAuthenticated &&
            (isLogin ||
                isRegisterEmail ||
                isRegisterPassword ||
                isGetStarted ||
                isSuccess)) {
          return AppRoutes.onboarding;
        }

        return null;
      },
      routes: [
        GoRoute(
          path: AppRoutes.splash,
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: AppRoutes.getStarted,
          builder: (context, state) => const GetStartedPage(),
        ),
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: AppRoutes.registerEmail,
          builder: (context, state) => const EmailInputPage(),
        ),
        GoRoute(
          path: AppRoutes.registerPassword,
          builder: (context, state) {
            final email = state.extra as String? ?? '';
            return PasswordInputPage(email: email);
          },
        ),
        GoRoute(
          path: AppRoutes.privacyPolicy,
          builder: (context, state) => const PrivacyPolicyPage(),
        ),
        GoRoute(
          path: AppRoutes.termsConditions,
          builder: (context, state) => const TermsConditionsPage(),
        ),
        GoRoute(
          path: AppRoutes.success,
          builder: (context, state) => const SuccessPage(),
        ),
        GoRoute(
          path: AppRoutes.onboarding,
          builder: (context, state) => const OnboardingDashboard(),
        ),
        ShellRoute(
          builder: (context, state, child) => MainShell(child: child),
          routes: [
            GoRoute(
              path: AppRoutes.dashboard,
              builder: (context, state) => const DashboardPage(),
            ),
          ],
        ),
      ],
    );
  }
}
