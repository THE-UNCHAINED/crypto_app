import 'package:crypto_app/services/watch_list_services.dart';
import 'package:flutter/material.dart';
import 'package:crypto_app/utils/app_colors.dart';

class DetailScreen extends StatefulWidget {
  final dynamic crypto;

  const DetailScreen({required this.crypto});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final watchListServices = WatchListServices();
  bool isinWatchlist = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkWatchList();
  }

  void _checkWatchList() async {
    final inWatchList = await watchListServices.isInWatchList(widget.crypto.id);
    setState(() {
      isinWatchlist = inWatchList;
    });
  }

  void _toggleWatchlist() async {
    if (isinWatchlist) {
      await watchListServices.removeFromWatchlist(widget.crypto.id);
    } else {
      await watchListServices.addToWatchList(widget.crypto.id);
    }
    setState(() {
      isinWatchlist = !isinWatchlist;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isinWatchlist
              ? '${widget.crypto.id} added to watchlist!'
              : '${widget.crypto.id} removed from watchlist!',
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.crypto.id?.toUpperCase() ?? 'Crypto'),
        backgroundColor: AppColors.primary,
        elevation: 0,

        actions: [
          IconButton(
            onPressed: _toggleWatchlist,
            icon: Icon(
              isinWatchlist ? Icons.favorite : Icons.favorite_border,
              color: isinWatchlist ? Colors.red : Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),

              // Crypto Name
              Text(
                widget.crypto.id?.toUpperCase() ?? 'Unknown',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              SizedBox(height: 20),

              // Price Section
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.cardBg,
                  border: Border.all(color: AppColors.primary, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      'Current Price',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 12),

                    // USD Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'USD:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${widget.crypto.priceUsd.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    // INR Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'INR:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '₹${widget.crypto.priceInr.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: _toggleWatchlist,
                icon: Icon(
                  isinWatchlist ? Icons.favorite : Icons.favorite_border,
                ),
                label: Text(
                  isinWatchlist ? 'Remove from Watchlist' : 'Add to Watchlist',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isinWatchlist
                      ? Colors.red
                      : AppColors.primary,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
              SizedBox(height: 40),
              // Info Card
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    Text(
                      'Crypto Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'This is the detail screen for ${widget.crypto.id}.\n\nYou can add more details here like:\n- Price history charts\n- Market cap\n- Trading volume\n- Percentage change\n\nComing soon! 🚀',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
