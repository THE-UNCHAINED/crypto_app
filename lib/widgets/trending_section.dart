import 'package:crypto_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class TrendingSection extends StatelessWidget {
  final List<dynamic> trendingList;

  const TrendingSection({super.key, required this.trendingList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            '🔥 Trending',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(
          height: 150,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: trendingList.length,
            itemBuilder: (context, index) {
              final trend = trendingList[index];
              return Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(12),
                width: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      trend.name ?? 'Unknown',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      trend.symbol ?? '',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '\$${trend.price?.toStringAsFixed(2) ?? '0.00'}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
