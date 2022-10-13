import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesFutureProvider = FutureProvider<SharedPreferences>(
  (ref) => SharedPreferences.getInstance(),
);

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => ref.watch(sharedPreferencesFutureProvider).value!,
);
