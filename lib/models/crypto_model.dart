class CryptoModel {
  final String id;
  final double priceUsd;
  final double priceInr;

  CryptoModel({
    required this.id,
    required this.priceUsd,
    required this.priceInr,
  });

  factory CryptoModel.fromJson(String cryptoId, Map<String, dynamic> json) {
    return CryptoModel(
      id: cryptoId,
      priceUsd: json['usd'].toDouble(),
      priceInr: json['inr'].toDouble(),
    );
  }
}
