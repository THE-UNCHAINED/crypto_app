import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto_app/models/news_model.dart';
import 'package:crypto_app/utils/constants.dart';

class NewsService {
  Future<List<NewsModel>> getNews(String query) async {
    try {
      String url =
          '${Constants.newsBaseUrl}/everything?q=$query&sortBy=publishedAt&apiKey=${Constants.newsApiKey}';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> articles = data['articles'] ?? [];

        if (articles.isEmpty) {
          throw Exception('No news found for "$query"');
        }

        //  Using map instead of forEach  or for

        List<NewsModel> newsList = articles
            .map((article) => NewsModel.fromJson(article))
            .toList();

        return newsList;
      } else {
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching news: $e');
      return [];
    }
  }
}
