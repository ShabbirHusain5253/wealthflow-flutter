import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wealthflow/core/utils/responsive.dart';
import '../bloc/dashboard_bloc.dart';
import '../widgets/net_worth_header.dart';
import '../widgets/net_worth_chart.dart';
import '../widgets/assets_liabilities_summary.dart';
import '../widgets/assets_liabilities_list.dart';
import '../widgets/forecast_watchlist_section.dart';
import '../widgets/services_vault_section.dart';
import '../widgets/article_carousel_section.dart';
import 'package:wealthflow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wealthflow/features/auth/presentation/bloc/auth_event.dart';
import 'package:wealthflow/features/auth/presentation/bloc/auth_state.dart';
import '../widgets/dashboard_shimmer.dart';
import 'package:wealthflow/core/di/init_dependencies.dart';
import 'package:wealthflow/config/theme/textstyles/text_style_util.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return BlocProvider(
      create: (context) => sl<DashboardBloc>()..add(FetchDashboardData()),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      endDrawer: const DashboardDrawer(),
      body: SafeArea(
        top: false,
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state.status == DashboardStatus.loading ||
                state.status == DashboardStatus.initial) {
              return const DashboardShimmer();
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<DashboardBloc>().add(FetchDashboardData());
              },
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFC7E7E5),
                            Color(0xFFF9FAFB),
                          ],
                          stops: [0.0, 0.9],
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: Responsive.w(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).padding.top +
                                Responsive.h(8)),
                        NetWorthHeader(
                          amount: state.netWorth,
                          change: state.netWorthChange,
                          percentage: state.netWorthChangePercentage,
                          lastUpdated: state.lastUpdated,
                        ),
                        SizedBox(height: Responsive.h(24)),
                        NetWorthChart(
                          spots: state.chartData,
                          selectedPeriod: state.selectedPeriod,
                          onPeriodChanged: (period) {
                            context
                                .read<DashboardBloc>()
                                .add(ChangeChartPeriod(period));
                          },
                        ),
                        SizedBox(height: Responsive.h(32)),
                        AssetsLiabilitiesSummary(
                          assets: state.assets,
                          liabilities: state.liabilities,
                        ),
                        SizedBox(height: Responsive.h(16)),
                        const AssetsLiabilitiesList(),
                        SizedBox(height: Responsive.h(16)),
                        const ForecastWatchlistSection(),
                        SizedBox(height: Responsive.h(16)),
                        const ServicesVaultSection(),
                        SizedBox(height: Responsive.h(16)),
                        const ArticleCarouselSection(),
                        SizedBox(height: Responsive.h(32)),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final userEmail = state.user?.email ?? 'User';
            final initials = userEmail.isNotEmpty ? userEmail[0].toUpperCase() : 'U';

            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(Responsive.w(20)),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Color(0xFFE4E7EC))),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(0xFF083332),
                        radius: Responsive.w(24),
                        child: Text(
                          initials,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: Responsive.w(12)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'User', // Backend doesn't provide a name yet
                              style: TextStyleUtil.bodyLarge(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1D2939),
                              ),
                            ),
                            Text(
                              userEmail,
                              style: TextStyleUtil.bodySmall(
                                color: const Color(0xFF667085),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.all(Responsive.w(20)),
                  child: ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                          title: Text(
                            'Logout',
                            style: TextStyleUtil.h4(color: const Color(0xFF1D2939)),
                          ),
                          content: Text(
                            'Are you sure you want to logout from your account?',
                            style: TextStyleUtil.bodyMedium(
                                color: const Color(0xFF667085)),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(dialogContext),
                              child: Text(
                                'Cancel',
                                style: TextStyleUtil.bodyMedium(
                                    color: const Color(0xFF667085)),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context
                                    .read<AuthBloc>()
                                    .add(const LogoutRequested());
                                Navigator.pop(dialogContext); // Close dialog
                                Navigator.pop(context); // Close drawer
                              },
                              child: Text(
                                'Logout',
                                style: TextStyleUtil.bodyMedium(
                                    color: const Color(0xFFD92D20),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    leading: const Icon(Icons.logout, color: Color(0xFFD92D20)),
                    title: Text(
                      'Logout',
                      style: TextStyleUtil.bodyMedium(
                        color: const Color(0xFFD92D20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Color(0xFFFEE4E2)),
                    ),
                    tileColor: const Color(0xFFFEF3F2),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

