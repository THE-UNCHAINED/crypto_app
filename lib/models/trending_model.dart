class TrendingModel {
  final String id;
  final String name;
  final String symbol;
  final int marketCapRank;
  final String imageUrl;
  final double price;

  TrendingModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.marketCapRank,
    required this.imageUrl,
    required this.price,
  });

  factory TrendingModel.fromJson(Map<String, dynamic> json) {
    return TrendingModel(
      id: json['item']['id'],
      name: json['item']['name'],
      symbol: json['item']['symbol'],
      marketCapRank: json['item']['market_cap_rank'],
      imageUrl: json['item']['large'],
      price: (json['item']['data']?['price'] ?? 0).toDouble(),
    );
  }
}
