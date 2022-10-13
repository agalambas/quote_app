import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:quote_app/src/features/quotes/domain/quote.dart';

final quotesRepositoryProvider = Provider<QuotesRepository>((ref) {
  return QuotesRepository(
    client: http.Client(),
  );
});

class QuotesRepository {
  final http.Client client;
  const QuotesRepository({required this.client});

  Future<Quote> fetchRandomQuote({Quote? lastQuote}) async {
    final response = await client.get(Uri.http(
      'quotes.stormconsultancy.co.uk',
      '/random.json',
    ));

    if (response.statusCode == 200) {
      final quote = _decodeQuote(response.body);
      return quote == lastQuote
          ? await fetchRandomQuote(lastQuote: lastQuote)
          : quote;
    } else {
      throw Exception('Failed to fetch a quote');
    }
  }

  Future<Quote> fetchQuote({int? quoteId}) async {
    final response = await client.get(Uri.http(
      'quotes.stormconsultancy.co.uk',
      '/quotes/$quoteId.json',
    ));

    if (response.statusCode == 200) {
      return _decodeQuote(response.body);
    } else {
      throw Exception('Failed to fetch the quote');
    }
  }

  Quote _decodeQuote(String body) {
    final json = jsonDecode(body) as Map<String, dynamic>;
    return Quote.fromJson(json);
  }
}
