import 'package:flutter/material.dart';
import 'package:wealthflow/core/utils/responsive.dart';
import 'package:wealthflow/config/theme/textstyles/text_style_util.dart';
import 'package:wealthflow/core/gen/assets.gen.dart';
import 'dart:async';

class ArticleCarouselSection extends StatefulWidget {
  const ArticleCarouselSection({super.key});

  @override
  State<ArticleCarouselSection> createState() => _ArticleCarouselSectionState();
}

class _ArticleCarouselSectionState extends State<ArticleCarouselSection> {
  int _currentIndex = 0;
  late Timer _timer;

  final List<Map<String, String>> _articles = [
    {
      'title': 'How to Maximise Your 401(k) Contributions Throughout the Tax Year',
      'description': 'With the 2024 tax deadline now in the rear-view mirror, it\'s time to turn our attention towards it.',
      'image': 'assets/images/article_1.png',
    },
    {
      'title': 'Planning for Retirement: A Guide to Modern Wealth Management',
      'description': 'Discover key strategies to build a robust retirement portfolio in today\'s volatile market.',
      'image': 'assets/images/article_2.png',
    },
    {
      'title': 'The Future of Fintech: Trends to Watch in 2024 and Beyond',
      'description': 'From AI to blockchain, see how technology is reshaping the financial landscape.',
      'image': 'assets/images/article_3.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % _articles.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final article = _articles[_currentIndex];

    return Container(
      padding: EdgeInsets.all(Responsive.w(12)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE4E7EC)),
      ),
      child: Column(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: Row(
              key: ValueKey<int>(_currentIndex),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    Assets.images.carouselPic1.path,
                    width: Responsive.w(80),
                    height: Responsive.h(80),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: Responsive.w(12)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article['title']!,
                        style: TextStyleUtil.sentientStyle(
                          fontSize: Responsive.sp(15),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1D2939),
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: Responsive.h(4)),
                      Text(
                        article['description']!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleUtil.bodySmall(
                          color: const Color(0xFF667085),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Responsive.h(12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_articles.length, (index) {
              final isSelected = _currentIndex == index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: isSelected ? 24 : 4,
                height: 4,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF083332)
                      : const Color(0xFFE4E7EC),
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
