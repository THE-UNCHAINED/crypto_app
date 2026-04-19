import 'dart:convert';

import 'package:crypto_app/models/trending_model.dart';
import 'package:crypto_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class TrendingService {
  Future<List<TrendingModel>> getTrendingNews() async {
    try {
      String url = '${Constants.coingeckoBaseUrl}/search/trending';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        List<dynamic> coins = data['coins'] ?? [];
        if (coins.isEmpty) {
          throw Exception("NO treding News found");
        }

        List<TrendingModel> trendingList = coins
            .map((coin) => TrendingModel.fromJson(coin))
            .toList();

        return trendingList;
      } else {
        throw Exception('Failed to load trending: ${response.statusCode}');
      }
    } catch (e) {
      print("Error in getting trending News: $e");
      return [];
    }
  }
}
