import 'package:crypto_app/services/coingecko_service.dart';
import 'package:crypto_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class Searchresultscreen extends StatelessWidget {
  final String query;
  final Function() onBack;
  final coingeckoService = CoingeckoService();
  Searchresultscreen({super.key, required this.query, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: onBack, // ← Clear search when tapped
              ),
              Expanded(
                child: Text(
                  'Search Results for "$query"',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<dynamic>>(
            future: coingeckoService.searchCrypto(query),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No crypto found for "$query"'));
              }
              final results = snapshot.data as List<dynamic>;

              return ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final crypto = results[index];
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
                          crypto.id?.toUpperCase() ?? 'Unknown',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${crypto.priceUsd.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.secondary,
                              ),
                            ),
                            Text(
                              '₹${crypto.priceInr.toStringAsFixed(0)}',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
