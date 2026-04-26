import 'package:flutter/material.dart';
import 'package:wealthflow/core/utils/responsive.dart';
import 'package:wealthflow/config/theme/textstyles/text_style_util.dart';
import 'package:wealthflow/core/utils/common_assets_viewer.dart';
import 'package:wealthflow/core/gen/assets.gen.dart';

class ForecastWatchlistSection extends StatelessWidget {
  const ForecastWatchlistSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ForecastCard(),
        SizedBox(height: Responsive.h(16)),
        const WatchlistCard(),
      ],
    );
  }
}

class ForecastCard extends StatelessWidget {
  const ForecastCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.w(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE4E7EC)),
      ),
      child: Column(
        children: [
          CommonAssetsViewer(
            svgPath: Assets.svgs.dashboard.wealthFlow.path,
            width: 48,
            height: 48,
          ),
          SizedBox(height: Responsive.h(16)),
          Text(
            'Forecast Your Financial Future with WealthFlow',
            textAlign: TextAlign.center,
            style: TextStyleUtil.sentientStyle(
              fontSize: Responsive.sp(18),
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1D2939),
            ),
          ),
          SizedBox(height: Responsive.h(8)),
          Text(
            'See how your wealth could grow over time. WealthFlow helps you forecast future projections based on your assets, growth assumptions, and inflation trends.',
            textAlign: TextAlign.center,
            style: TextStyleUtil.bodyMedium(
              color: const Color(0xFF667085),
              height: 1.5,
            ),
          ),
          SizedBox(height: Responsive.h(20)),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF083332),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: Responsive.h(14)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Text(
                'Create Wealth Forecast',
                style: TextStyleUtil.bodyMedium(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WatchlistCard extends StatelessWidget {
  const WatchlistCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.w(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE4E7EC)),
      ),
      child: Column(
        children: [
          CommonAssetsViewer(
            svgPath: Assets.svgs.dashboard.watchlist.path,
            width: 48,
            height: 48,
          ),
          SizedBox(height: Responsive.h(16)),
          Text(
            'Your Watchlist',
            textAlign: TextAlign.center,
            style: TextStyleUtil.sentientStyle(
              fontSize: Responsive.sp(18),
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1D2939),
            ),
          ),
          SizedBox(height: Responsive.h(8)),
          Text(
            'Track stocks, ETFs, crypto, and currencies—all in one place. Stay updated with market shifts.',
            textAlign: TextAlign.center,
            style: TextStyleUtil.bodyMedium(
              color: const Color(0xFF667085),
              height: 1.5,
            ),
          ),
          SizedBox(height: Responsive.h(20)),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF083332),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: Responsive.h(14)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Text(
                'Start Tracking',
                style: TextStyleUtil.bodyMedium(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
