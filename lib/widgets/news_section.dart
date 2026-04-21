import 'package:crypto_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class NewsSection extends StatelessWidget {
  final List<dynamic> newsList;
  const NewsSection({super.key, required this.newsList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            '📰 News',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: newsList.length,
          itemBuilder: (context, index) {
            final article = newsList[index];
            return Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title ?? 'No title',
                    maxLines: 2,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        article.source ?? 'Unknown',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.secondary,
                        ),
                      ),
                      Text(
                        article.publishedAt ?? 'Unknown',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
