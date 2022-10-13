import 'package:flutter/material.dart';

import 'features/quotes/presentation/quote_screen.dart';

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
      home: const QuoteScreen(),
    );
  }
}
