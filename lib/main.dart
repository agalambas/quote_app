import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart';
import 'src/utils/instance_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await container.read(sharedPreferencesFutureProvider.future);
  //! add font licenses
  runApp(UncontrolledProviderScope(
    container: container,
    child: const MyApp(),
  ));
}
