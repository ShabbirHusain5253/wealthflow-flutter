import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:wealthflow/core/utils/responsive.dart';
import 'package:wealthflow/config/theme/textstyles/text_style_util.dart';

class NetWorthChart extends StatelessWidget {
  final List<FlSpot> spots;
  final String selectedPeriod;
  final Function(String) onPeriodChanged;

  const NetWorthChart({
    super.key,
    required this.spots,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (spots.isEmpty) return const SizedBox.shrink();

    final minX = spots.first.x;
    final maxX = spots.last.x;

    double minY = spots.map((e) => e.y).reduce((a, b) => a < b ? a : b);
    double maxY = spots.map((e) => e.y).reduce((a, b) => a > b ? a : b);

    // Ensure there's a range even if all values are the same
    if (minY == maxY) {
      minY = (minY - 1000).clamp(0, double.infinity);
      maxY = maxY + 1000;
    }

    // Add padding to Y axis
    final yPadding = (maxY - minY) * 0.2;
    minY = (minY - yPadding).clamp(0, double.infinity);
    maxY = maxY + yPadding;

    final yInterval = (maxY - minY) / 5;
    final xInterval = (maxX - minX) / 4;

    return Column(
      children: [
        SizedBox(
          height: Responsive.h(250),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: yInterval > 0 ? yInterval : 1,
                getDrawingHorizontalLine: (value) {
                  return const FlLine(
                    color: Color(0xFFE4E7EC),
                    strokeWidth: 1,
                  );
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    interval: xInterval > 0 ? xInterval : 1,
                    getTitlesWidget: (value, meta) {
                      // Hide exact min and max to prevent edge clipping/overlapping with other UI
                      if (value == minX || value == maxX) {
                        return const SizedBox.shrink();
                      }
                      final date =
                          DateTime.fromMillisecondsSinceEpoch(value.toInt());
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        space: 8.0,
                        child: Text(
                          DateFormat('MMM d').format(date),
                          style: TextStyleUtil.bodySmall(
                              color: const Color(0xFF667085)),
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: yInterval > 0 ? yInterval : 1,
                    getTitlesWidget: (value, meta) {
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        space: 0,
                        child: Text(
                          _formatLargeNumber(value),
                          style: TextStyleUtil.bodySmall(
                              color: const Color(0xFF667085)),
                          maxLines: 1,
                          overflow: TextOverflow.visible,
                        ),
                      );
                    },
                    reservedSize: 46,
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              minX: minX,
              maxX: maxX,
              minY: minY,
              maxY: maxY,
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: const Color(0xFF083332),
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF083332).withOpacity(0.2),
                        const Color(0xFF083332).withOpacity(0.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
          ),
        ),
        SizedBox(height: Responsive.h(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              '1W', '1M', '6M', '1Y', 'YTD', 'Max'
            ].map((period) {
              final isSelected = selectedPeriod == period;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ChoiceChip(
                  label: Text(
                    period,
                    style: TextStyleUtil.bodySmall(
                      color: isSelected ? Colors.white : const Color(0xFF667085),
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) onPeriodChanged(period);
                  },
                  selectedColor: const Color(0xFF083332),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: isSelected
                          ? const Color(0xFF083332)
                          : const Color(0xFFE4E7EC),
                    ),
                  ),
                  showCheckmark: false,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  String _formatLargeNumber(double value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toInt()}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toInt()}K';
    }
    return value.toInt().toString();
  }
}
