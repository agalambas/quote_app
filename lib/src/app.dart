import 'package:flutter/material.dart';
import 'package:quote_app/src/features/quotes/domain/styled_quote.dart';
import 'package:quote_app/src/features/saved_quotes/presentation/quote_screen.dart';

import 'features/quotes/presentation/quote_feed_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotes',
      debugShowCheckedModeBanner: false,
      // debugShowMaterialGrid: true,
      theme: ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed: Colors.white,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const QuoteFeedScreen(),
      },
      onGenerateRoute: (settings) {
        final quote = settings.arguments as StyledQuote;
        return MaterialPageRoute(
          builder: (context) => QuoteScreen(quote),
        );
      },
    );
  }
}
