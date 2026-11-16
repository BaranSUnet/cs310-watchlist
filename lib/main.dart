import 'package:flutter/material.dart';

import 'screens/access_screen.dart';
import 'theme.dart';

void main() => runApp(const WatchlistApp());

class WatchlistApp extends StatelessWidget {
  const WatchlistApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Watchlist',
    debugShowCheckedModeBanner: false,
    theme: watchlistTheme,
    home: const AccessScreen(),
  );
}
