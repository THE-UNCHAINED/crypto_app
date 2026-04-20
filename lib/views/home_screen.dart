import 'package:crypto_app/services/coingecko_service.dart';
import 'package:crypto_app/services/news_service.dart';
import 'package:crypto_app/services/trending_service.dart';
import 'package:crypto_app/utils/app_colors.dart';
import 'package:crypto_app/widgets/custom_trend_box.dart';
import 'package:crypto_app/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final coingeckoService = CoingeckoService();
  final newsService = NewsService();
  final trendingService = TrendingService();

  Future<List<dynamic>> callSingleApi() async {
    List coins = await coingeckoService.getTopCryptos();
    print(coins);
    return coins;
  }

  Future<Map<String, dynamic>> callAllApi() async {
    try {
      final results = await Future.wait([
        coingeckoService.getTopCryptos(),
        newsService.getNews('crypotocurrency'),
        trendingService.getTrendingNews(),
      ]);

      return {
        'cryptos': results[0],
        'news': results[1],
        'trending': results[2],
      };
    } catch (e) {
      print("Error loading data: $e");
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crypto Tracket"),
        elevation: 0,
        backgroundColor: AppColors.primary,
      ),

      body: Flexible(
        child: FutureBuilder<List<dynamic>>(
          future: callSingleApi(),
          builder: (context, snapshot) {
            // State 1: Loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            // State 2: Error
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            // State 3: Success
            if (snapshot.hasData) {
              final coins = snapshot.data as List<dynamic>;

              return ListView.builder(
                itemCount: coins.length, // ← How many items?
                itemBuilder: (context, index) {
                  final crypto = coins[index]; // ← Get ONE crypto

                  return Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(crypto.id), // ← Show name
                        Text(crypto.priceUsd.toString()),
                        Text(crypto.priceInr.toString()), // ← Show price
                      ],
                    ),
                  );
                },
              );
            }

            return Center(child: Text('No data'));
          },
        ),
      ),
    );
  }
}
