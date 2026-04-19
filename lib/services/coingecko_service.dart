import 'dart:convert';

import 'package:crypto_app/models/crypto_model.dart';
import 'package:http/http.dart' as http;

class CoingeckoService {
  static const String baseUrl = 'https://api.coingecko.com/api/v3';

  Future<List<CryptoModel>> getTopCryptos() async {
    try {
      String url =
          '$baseUrl/simple/price?ids=bitcoin,ethereum,cardano,solana,ripple&vs_currencies=usd,inr';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        List<CryptoModel> cryptos = [];

        data.forEach((cryptoId, prices) {
          CryptoModel crypto = CryptoModel.fromJson(cryptoId, prices);
          cryptos.add(crypto);
        });

        return cryptos;
      } else {
        throw Exception('Failed to load cryptos: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getting cryptos: $e');
      return [];
    }
  }

  Future<List<CryptoModel>> searchCrypto(String query) async {
    try {
      String url = '$baseUrl/simple/price?ids=$query&vs_currencies=usd,inr';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        if (data.isEmpty) {
          throw Exception("Crypto not found"); // ← Crypto doesn't exist
        }
        List<CryptoModel> crypots = [];

        data.forEach((cryptoId, prices) {
          crypots.add(CryptoModel.fromJson(cryptoId, prices));
        });

        return crypots;
      } else {
        throw Exception("Cyrpto not FOUND");
      }
    } catch (e) {
      print("Error Searching : $e");
      return [];
    }
  }
}
