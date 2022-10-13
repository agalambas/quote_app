import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_app/src/utils/instance_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

final savedQuotesRepositoryProvider = Provider<SavedQuotesRepository>((ref) {
  return SavedQuotesRepository(prefs: ref.watch(sharedPreferencesProvider));
});

class SavedQuotesRepository {
  final SharedPreferences prefs;
  final key = 'saved_quotes';

  SavedQuotesRepository({required this.prefs});

  List<int> getSavedQuoteIds() {
    return prefs
            .getStringList(key)
            ?.map((idString) => int.parse(idString))
            .toList() ??
        [];
  }

  void saveToggleQuote(int quoteId) async {
    final list = prefs.getStringList(key) ?? [];
    final quoteIdString = quoteId.toString();
    list.contains(quoteIdString)
        ? list.remove(quoteIdString)
        : list.insert(0, quoteIdString);
    prefs.setStringList(key, list);
  }
}
