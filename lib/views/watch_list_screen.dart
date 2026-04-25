import 'package:crypto_app/services/coingecko_service.dart';
import 'package:crypto_app/services/watch_list_services.dart';
import 'package:crypto_app/utils/app_colors.dart';
import 'package:crypto_app/views/detail_screen.dart';
import 'package:flutter/material.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key});

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  final watchlistService = WatchListServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WatchList COINS",
          style: TextStyle(
            color: AppColors.textPrimary,
            backgroundColor: AppColors.background,
          ),
        ),
      ),
      body: FutureBuilder(
        future: watchlistService.getWatchlist(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("There is error in Loading data"));
          }
          if (snapshot.hasData) {
            final savedCryptos = snapshot.data!;
            if (savedCryptos.isEmpty) {
              return Center(child: Text('No cryptos in watchlist'));
            }
            return ListView.builder(
              itemCount: savedCryptos.length,
              itemBuilder: (context, index) {
                final cryptoId = savedCryptos[index];
                return FutureBuilder<List<dynamic>>(
                  future: CoingeckoService().searchCrypto(cryptoId),
                  builder: (context, priceSnapshot) {
                    if (priceSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Text('Loading...');
                    }
                    if (!priceSnapshot.hasData || priceSnapshot.data!.isEmpty) {
                      return ListTile(
                        title: Text(cryptoId),
                        subtitle: Text('Price unavailable'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await watchlistService.removeFromWatchlist(
                              cryptoId,
                            );
                            setState(() {});
                          },
                        ),
                      );
                    }
                    final crypto = priceSnapshot.data![0];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(crypto: crypto),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(crypto.id),
                        subtitle: Text(
                          '\$${crypto.priceUsd.toStringAsFixed(2)}',
                        ),
                        trailing: Text(
                          "₹${crypto.priceInr.toStringAsFixed(0)}",
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }

          return Center(child: Text("NO DATA HERE"));
        },
      ),
    );
  }
}
