class NewsModel {
  final String title;
  final String description;
  final String imageUrl;
  final String url;
  final String publishedAt;
  final String source;

  NewsModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.url,
    required this.publishedAt,
    required this.source,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? 'No title',
      description: json['description'] ?? 'No description',
      imageUrl: json['urlToImage'] ?? '',
      url: json['url'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      source: json['source']['name'] ?? 'Unknown',
    );
  }
}
