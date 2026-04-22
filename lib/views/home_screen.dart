import 'package:crypto_app/services/coingecko_service.dart';
import 'package:crypto_app/services/news_service.dart';
import 'package:crypto_app/services/trending_service.dart';
import 'package:crypto_app/utils/app_colors.dart';
import 'package:crypto_app/views/search_results_screen.dart';
import 'package:crypto_app/widgets/news_section.dart';
import 'package:crypto_app/widgets/popular_cryptos_section.dart';
import 'package:crypto_app/widgets/custom_search_bar.dart';
import 'package:crypto_app/widgets/trending_section.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';
  void _handleSearch(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  final coingeckoService = CoingeckoService();

  final newsService = NewsService();

  final trendingService = TrendingService();

  // Future<List<dynamic>> callSingleApi() async {
  Future<Map<String, dynamic>> callAllApi() async {
    try {
      final results = await Future.wait([
        coingeckoService.getTopCryptos(),
        newsService.getNews('cryptocurrency'), // ✅ Correct
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

      body: Column(
        children: [
          CustomSearchBar(onSearch: _handleSearch),
          Expanded(
            child: FutureBuilder<Map<String, dynamic>>(
              future: callAllApi(), // ✅ All 3 APIs!
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.hasData) {
                  if (searchQuery.isNotEmpty) {
                    return Searchresultscreen(
                      query: searchQuery,
                      onBack: () {
                        setState(() {
                          searchQuery = '';
                        });
                      },
                    );
                  }
                  // Extract all 3 datasets
                  final data = snapshot.data as Map<String, dynamic>;
                  final cryptos = data['cryptos'] as List<dynamic>;
                  final news = data['news'] as List<dynamic>;
                  final trending = data['trending'] as List<dynamic>;

                  // Now display all 3 in sections!
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        // Section 1: Trending
                        TrendingSection(trendingList: trending),
                        // Section 2: Popular Cryptos
                        PopularCryptosSection(cryptosList: cryptos),
                        // Section 3: News
                        NewsSection(newsList: news),
                      ],
                    ),
                  );
                }

                return Center(child: Text('No data'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
