import 'package:crypto_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PopularCryptosSection extends StatelessWidget {
  final List<dynamic> cryptosList;
  const PopularCryptosSection({super.key, required this.cryptosList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            '💰 Popular',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: cryptosList.length,
          itemBuilder: (context, index) {
            final crypto = cryptosList[index];
            return Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    crypto.id?.toUpperCase() ?? 'Unknown',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${crypto.priceUsd.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 12, color: AppColors.secondary),
                  ),
                  Text(
                    '₹${crypto.priceInr.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
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
