import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wealthflow/core/utils/responsive.dart';

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Responsive.w(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height: MediaQuery.of(context).padding.top + Responsive.h(16)),
          // NetWorthHeader Shimmer
          _buildShimmerItem(width: Responsive.w(80), height: Responsive.h(16)),
          SizedBox(height: Responsive.h(12)),
          _buildShimmerItem(width: Responsive.w(220), height: Responsive.h(40)),
          SizedBox(height: Responsive.h(12)),
          _buildShimmerItem(width: Responsive.w(140), height: Responsive.h(16)),

          SizedBox(height: Responsive.h(24)),

          // NetWorthChart Shimmer (Card shape)
          Container(
            height: Responsive.h(300),
            width: double.infinity,
            padding: EdgeInsets.all(Responsive.w(16)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE4E7EC)),
            ),
            child: Column(
              children: [
                Expanded(
                    child: _buildShimmerItem(
                        width: double.infinity, height: double.infinity)),
                SizedBox(height: Responsive.h(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      6,
                      (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: _buildShimmerItem(
                                width: Responsive.w(40),
                                height: Responsive.h(32),
                                borderRadius: 20),
                          )),
                ),
              ],
            ),
          ),

          SizedBox(height: Responsive.h(24)),

          // Assets card shimmer placeholder
          _buildCardShimmer(),
        ],
      ),
    ),
    );
  }

  Widget _buildCardShimmer() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.w(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE4E7EC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildShimmerItem(width: Responsive.w(100), height: Responsive.h(24)),
          SizedBox(height: Responsive.h(16)),
          Column(
              children: List.generate(
                  2,
                  (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            _buildShimmerItem(
                                width: 48, height: 48, borderRadius: 8),
                            SizedBox(width: Responsive.w(12)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildShimmerItem(width: 120, height: 14),
                                  const SizedBox(height: 8),
                                  _buildShimmerItem(width: 80, height: 18),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
            ),
        ],
      ),
    );
  }

  Widget _buildShimmerItem({
    required double width,
    required double height,
    double borderRadius = 8,
  }) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFF2F4F7),
      highlightColor: Colors.white,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
