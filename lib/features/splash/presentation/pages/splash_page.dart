import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wealthflow/config/router/app_routes.dart';
import 'package:wealthflow/core/utils/common_assets_viewer.dart';
import 'package:wealthflow/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:wealthflow/features/splash/presentation/cubit/splash_state.dart';
import 'package:go_router/go_router.dart';
import 'package:wealthflow/core/di/init_dependencies.dart';
import 'package:wealthflow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wealthflow/features/auth/presentation/bloc/auth_state.dart';
import 'package:wealthflow/core/gen/assets.gen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  static const _logoSlideDuration = Duration(milliseconds: 900);
  static const _brandingRevealDuration = Duration(milliseconds: 700);

  static const _logoWidth = 69.0;
  static const _logoHeight = 38.0;
  static const _logoToBrandingGap = 14.0;
  static const _brandingWidth = 230.0;
  static const _comboWidth = _logoWidth + _logoToBrandingGap + _brandingWidth;

  late final AnimationController _logoSlideController;
  late final AnimationController _brandingRevealController;
  late final Animation<double> _logoSlideProgress;
  late final Animation<double> _brandingSizeFactor;
  late final Animation<double> _brandingOpacity;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _logoSlideController = AnimationController(
      vsync: this,
      duration: _logoSlideDuration,
    );
    _logoSlideProgress = CurvedAnimation(
      parent: _logoSlideController,
      curve: Curves.easeInOutCubic,
    );

    _brandingRevealController = AnimationController(
      vsync: this,
      duration: _brandingRevealDuration,
    );
    _brandingSizeFactor = CurvedAnimation(
      parent: _brandingRevealController,
      curve: Curves.easeOutCubic,
    );
    _brandingOpacity = CurvedAnimation(
      parent: _brandingRevealController,
      curve: const Interval(0.0, 0.75, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _logoSlideController.dispose();
    _brandingRevealController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SplashCubit>()..init(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<SplashCubit, SplashState>(
            listener: (context, state) {
              if (state.status == SplashStatus.animatingLogo) {
                _logoSlideController.forward();
              } else if (state.status == SplashStatus.animatingBranding) {
                _brandingRevealController.forward();
              } else if (state.status == SplashStatus.completed) {
                _attemptNavigation(context);
              }
            },
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.status != AuthStatus.initial) {
                _attemptNavigation(context);
              }
            },
          ),
        ],
        child: Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              final screenHeight = constraints.maxHeight;

              final logoCenterX = (screenWidth - _logoWidth) / 2;
              final logoCenterY = (screenHeight - _logoHeight) / 2;
              final logoFinalX = (screenWidth - _comboWidth) / 2;

              return Stack(
                children: [
                  Positioned.fill(
                    child: CommonAssetsViewer(
                      imagePath: Assets.images.splashScreen.path,
                      fit: BoxFit.cover,
                    ),
                  ),
                  _buildAnimatedLogo(logoCenterX, logoFinalX, logoCenterY),
                  _buildAnimatedBranding(logoFinalX, logoCenterY),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _attemptNavigation(BuildContext context) {
    final splashStatus = context.read<SplashCubit>().state.status;
    final authStatus = context.read<AuthBloc>().state.status;

    if (splashStatus == SplashStatus.completed && authStatus != AuthStatus.initial) {
      if (authStatus == AuthStatus.authenticated) {
        context.go(AppRoutes.dashboard);
      } else {
        context.go(AppRoutes.getStarted);
      }
    }
  }

  Widget _buildAnimatedLogo(double startX, double endX, double y) {
    return AnimatedBuilder(
      animation: _logoSlideProgress,
      builder: (context, child) {
        final x = lerpDouble(startX, endX, _logoSlideProgress.value)!;
        return Positioned(
          left: x,
          top: y,
          child: child!,
        );
      },
      child: SvgPicture.asset(
        Assets.svgs.logo.path,
        width: _logoWidth,
        height: _logoHeight,
      ),
    );
  }

  Widget _buildAnimatedBranding(double logoX, double y) {
    return Positioned(
      left: logoX + _logoWidth + _logoToBrandingGap,
      top: y,
      height: _logoHeight,
      child: Align(
        alignment: Alignment.centerLeft,
        child: AnimatedBuilder(
          animation: _brandingRevealController,
          builder: (context, child) {
            return ClipRect(
              child: Align(
                alignment: Alignment.centerLeft,
                widthFactor: _brandingSizeFactor.value,
                child: Opacity(
                  opacity: _brandingOpacity.value,
                  child: child,
                ),
              ),
            );
          },
          child: SvgPicture.asset(
            Assets.svgs.brandingName.path,
            height: 28,
          ),
        ),
      ),
    );
  }
}
