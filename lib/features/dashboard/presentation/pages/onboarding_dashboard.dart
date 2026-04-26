import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wealthflow/config/router/app_routes.dart';
import 'package:wealthflow/core/utils/common_assets_viewer.dart';
import 'package:wealthflow/config/theme/textstyles/text_style_util.dart';
import 'package:wealthflow/core/gen/assets.gen.dart';
import 'package:wealthflow/features/dashboard/presentation/bloc/onboarding_dashboard_bloc.dart';
import 'package:wealthflow/features/dashboard/presentation/widgets/loading_step_widget.dart';
import 'package:wealthflow/features/dashboard/presentation/widgets/loading_dots.dart';

class OnboardingDashboard extends StatelessWidget {
  const OnboardingDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingDashboardBloc()..add(StartOnboarding()),
      child: const OnboardingDashboardView(),
    );
  }
}

class OnboardingDashboardView extends StatelessWidget {
  const OnboardingDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingDashboardBloc, OnboardingDashboardState>(
      listener: (context, state) {
        if (state.isComplete) {
          context.go(AppRoutes.dashboard);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0B2F2A),
        body: Stack(
          children: [
            Positioned.fill(
              child: CommonAssetsViewer(
                imagePath: Assets.images.splashScreen.path,
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 3),
                    // Primary Title
                    BlocBuilder<OnboardingDashboardBloc,
                        OnboardingDashboardState>(
                      buildWhen: (p, c) => p.title != c.title,
                      builder: (context, state) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 800),
                          layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
                            return Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                ...previousChildren,
                                if (currentChild != null) currentChild,
                              ],
                            );
                          },
                          transitionBuilder: (child, animation) {
                            final isIncoming = child.key == ValueKey(state.title);
                            
                            final slideAnimation = Tween<Offset>(
                              begin: isIncoming ? const Offset(0.0, 0.5) : const Offset(0.0, -0.5),
                              end: Offset.zero,
                            ).animate(CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeInOutCubic,
                            ));

                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: slideAnimation,
                                child: child,
                              ),
                            );
                          },
                          child: SizedBox(
                            key: ValueKey(state.title),
                            width: double.infinity,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: state.title,
                                    style: TextStyleUtil.sentientStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      height: 1.2,
                                    ),
                                  ),
                                  if (!state.title.contains("ready"))
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.baseline,
                                      baseline: TextBaseline.alphabetic,
                                      child: SizedBox(
                                        width: 32,
                                        child: LoadingDots(
                                          style: TextStyleUtil.sentientStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    // Secondary Subtitle with custom transition
                    BlocBuilder<OnboardingDashboardBloc,
                        OnboardingDashboardState>(
                      buildWhen: (p, c) => p.subtitle != c.subtitle,
                      builder: (context, state) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 800),
                          transitionBuilder: (child, animation) {
                            final offsetAnimation = Tween<Offset>(
                              begin: const Offset(0, 0.5),
                              end: Offset.zero,
                            ).animate(CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOutCubic,
                            ));
                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              ),
                            );
                          },
                          child: Text(
                            state.subtitle,
                            key: ValueKey(state.subtitle),
                            textAlign: TextAlign.center,
                            style: TextStyleUtil.interStyle(
                              fontSize: 16,
                              color: const Color(0xFF8AA39F),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 48),
                    // Loading Steps
                    BlocBuilder<OnboardingDashboardBloc,
                        OnboardingDashboardState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            LoadingStepWidget(
                              text: state.step1Status == LoadingStatus.complete
                                  ? "Profile Complete"
                                  : "Setting Profile",
                              status: state.step1Status,
                            ),
                            LoadingStepWidget(
                              text: "Setting Up Your Dashboard",
                              status: state.step2Status,
                              isVisible: state.step2Visible,
                            ),
                          ],
                        );
                      },
                    ),
                    const Spacer(flex: 4),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
