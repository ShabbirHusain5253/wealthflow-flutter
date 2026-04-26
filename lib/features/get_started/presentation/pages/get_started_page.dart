import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wealthflow/config/router/app_routes.dart';
import 'package:wealthflow/core/utils/responsive.dart';
import 'package:wealthflow/config/theme/textstyles/text_style_util.dart';
import 'package:wealthflow/core/widgets/common_button.dart';
import 'package:wealthflow/features/get_started/presentation/widgets/feature_bullet_tile.dart';
import 'package:wealthflow/core/utils/common_assets_viewer.dart';
import 'package:wealthflow/features/get_started/presentation/cubit/get_started_cubit.dart';
import 'package:wealthflow/features/get_started/presentation/cubit/get_started_state.dart';
import 'package:wealthflow/core/di/init_dependencies.dart';
import 'package:go_router/go_router.dart';
import 'package:wealthflow/core/gen/assets.gen.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage>
    with TickerProviderStateMixin {
  // Animation Durations
  static const _fadeDuration = Duration(milliseconds: 600);
  static const _slideDuration = Duration(milliseconds: 800);
  static const _bulletStaggerDuration = Duration(milliseconds: 1000);

  // Controllers
  late final AnimationController _takeControlController;
  late final AnimationController _richTextController;
  late final AnimationController _headlineSlideController;
  late final AnimationController _bulletRevealController;
  late final AnimationController _buttonController;

  // Animations
  late final Animation<double> _takeControlOpacity;
  late final Animation<double> _richTextOpacity;
  late final Animation<double> _headlineSlideProgress;
  late final List<Animation<double>> _bulletAnimations;
  late final Animation<double> _buttonOpacity;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _takeControlController =
        AnimationController(vsync: this, duration: _fadeDuration);
    _takeControlOpacity =
        CurvedAnimation(parent: _takeControlController, curve: Curves.easeIn);

    _richTextController =
        AnimationController(vsync: this, duration: _fadeDuration);
    _richTextOpacity =
        CurvedAnimation(parent: _richTextController, curve: Curves.easeIn);

    _headlineSlideController =
        AnimationController(vsync: this, duration: _slideDuration);
    _headlineSlideProgress = CurvedAnimation(
        parent: _headlineSlideController, curve: Curves.easeInOutCubic);

    _bulletRevealController =
        AnimationController(vsync: this, duration: _bulletStaggerDuration);
    _bulletAnimations = List.generate(5, (index) {
      final start = index * 0.15;
      final end = (start + 0.4).clamp(0.0, 1.0);
      return CurvedAnimation(
        parent: _bulletRevealController,
        curve: Interval(start, end, curve: Curves.easeOut),
      );
    });

    _buttonController =
        AnimationController(vsync: this, duration: _fadeDuration);
    _buttonOpacity =
        CurvedAnimation(parent: _buttonController, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _takeControlController.dispose();
    _richTextController.dispose();
    _headlineSlideController.dispose();
    _bulletRevealController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return BlocProvider(
      create: (context) => sl<GetStartedCubit>()..init(),
      child: BlocListener<GetStartedCubit, GetStartedState>(
        listener: (context, state) {
          switch (state.status) {
            case GetStartedStatus.fadingTakeControl:
              _takeControlController.forward();
              break;
            case GetStartedStatus.fadingRichText:
              _richTextController.forward();
              break;
            case GetStartedStatus.slidingHeadline:
              _headlineSlideController.forward();
              break;
            case GetStartedStatus.revealingBullets:
              _bulletRevealController.forward();
              break;
            case GetStartedStatus.completed:
              _buttonController.forward();
              break;
            default:
              break;
          }
        },
        child: Scaffold(
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
                  padding: EdgeInsets.symmetric(horizontal: Responsive.w(24)),
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            _buildAnimatedHeadline(),
                            _buildAnimatedBullets(),
                          ],
                        ),
                      ),
                      _buildAnimatedButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedHeadline() {
    return AnimatedBuilder(
      // Listen to all three controllers that affect the headline
      animation: Listenable.merge([
        _takeControlController,
        _richTextController,
        _headlineSlideController,
      ]),
      builder: (context, _) {
        final baseSize = Responsive.sp(36);
        return Align(
          alignment:
              Alignment(0, _lerpDouble(0, -0.8, _headlineSlideProgress.value)),
          child: RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Take Control',
                  style: TextStyleUtil.sentientStyle(
                    fontSize: baseSize,
                    fontWeight: FontWeight.normal,
                    color: Colors.white.withOpacity(_takeControlOpacity.value),
                  ),
                ),
                TextSpan(
                  text: ' of Your Wealth with Hoxton Wealth App',
                  style: TextStyleUtil.sentientStyle(
                    fontSize: baseSize,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xFF9EEEE6)
                        .withOpacity(_richTextOpacity.value),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedBullets() {
    return AnimatedBuilder(
      animation: _headlineSlideProgress,
      builder: (context, _) {
        if (_headlineSlideProgress.value < 0.4) return const SizedBox.shrink();

        return Positioned(
          top: Responsive.h(230),
          left: 0,
          right: 0,
          child: _buildBulletPoints(),
        );
      },
    );
  }

  Widget _buildBulletPoints() {
    final features = [
      {
        'icon': Assets.svgs.internet.path,
        'text': 'Organize Your Finances in One Place'
      },
      {
        'icon': Assets.svgs.chart.path,
        'text': 'Track Your Financial Performance'
      },
      {
        'icon': Assets.svgs.support.path,
        'text': 'Free, Intuitive, and Backed by Financial Experts'
      },
      {
        'icon': Assets.svgs.growthGraph.path,
        'text': 'Plan Your Financial Future'
      },
      {'icon': Assets.svgs.security.path, 'text': 'Security You Can Trust'},
    ];

    return Column(
      children: List.generate(features.length, (index) {
        return FeatureBulletTile(
          iconPath: features[index]['icon']!,
          text: features[index]['text']!,
          animation: _bulletAnimations[index],
        );
      }),
    );
  }

  Widget _buildAnimatedButton() {
    return AnimatedBuilder(
      animation: _buttonOpacity,
      builder: (context, child) {
        return Padding(
          padding: EdgeInsets.only(bottom: Responsive.h(24)),
          child: Opacity(
            opacity: _buttonOpacity.value,
            child: CommonButton(
              text: 'Get Started',
              onPressed: () => context.push(AppRoutes.registerEmail),
              height: Responsive.h(44),
              isOutlined: true,
            ),
          ),
        );
      },
    );
  }

// Todo in Utils
  double _lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }
}
