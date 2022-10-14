import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_app/src/features/saved_quotes/domain/saved_quote.dart';
import 'package:quote_app/src/utils/instance_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

final savedQuotesRepositoryProvider = Provider<SavedQuotesRepository>((ref) {
  return SavedQuotesRepository(prefs: ref.watch(sharedPreferencesProvider));
});

class SavedQuotesRepository {
  final SharedPreferences prefs;
  final key = 'saved-quotes';

  SavedQuotesRepository({required this.prefs});

  SavedQuote? getSavedQuote(int quoteId) =>
      getSavedQuotes().firstWhereOrNull((saved) => saved.quoteId == quoteId);

  List<SavedQuote> getSavedQuotes() {
    try {
      return prefs
              .getStringList(key)
              ?.map((value) => SavedQuote.fromString(value))
              .toList() ??
          [];
    } catch (_) {
      prefs.remove(key);
      return [];
    }
  }

  void saveQuote(SavedQuote savedQuote) async {
    final savedQuoteString = savedQuote.toString();
    try {
      final list = prefs.getStringList(key) ?? [];
      list.remove(savedQuoteString);
      list.insert(0, savedQuoteString);
      prefs.setStringList(key, list);
    } catch (_) {
      prefs.remove(key);
      prefs.setStringList(key, [savedQuoteString]);
    }
  }

  void removeQuote(int quoteId) async {
    final quoteIdString = quoteId.toString();
    try {
      final list = prefs.getStringList(key) ?? [];
      list.removeWhere((saved) => saved.split('#').first == quoteIdString);
      prefs.setStringList(key, list);
    } catch (_) {
      prefs.remove(key);
    }
  }
}
