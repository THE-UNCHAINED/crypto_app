import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WatchListServices {
  static const String _watchlistKey =
      'watchlist'; //ye bna class constant to access a list key hai bs

  //Adding into shared prefernce
  Future<void> addToWatchList(String cryptoId) async {
    final prefs = await SharedPreferences.getInstance();

    final watchlist = prefs.getStringList(_watchlistKey) ?? [];

    if (!watchlist.contains(cryptoId)) {
      watchlist.add(cryptoId);
      await prefs.setStringList(_watchlistKey, watchlist);
    }
  }

  //removing from the shared
  Future<void> removeFromWatchlist(String cryptoId) async {
    final prefs = await SharedPreferences.getInstance();
    final watchList = prefs.getStringList(_watchlistKey) ?? [];

    watchList.remove(cryptoId);
    await prefs.setStringList(_watchlistKey, watchList);
  }

  //saving in
  Future<List<String>> getWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_watchlistKey) ?? [];
  }

  Future<bool> isInWatchList(String cryptoId) async {
    final watchlist = await getWatchlist();
    return watchlist.contains(cryptoId);
  }
}
