import 'package:mocktail/mocktail.dart';
import 'package:quote_app/src/features/quotes/data/quotes_repository.dart';
import 'package:quote_app/src/features/saved_quotes/data/saved_quotes_repository.dart';

class MockQuotesRepository extends Mock implements QuotesRepository {}

class MockSavedQuotesRepository extends Mock implements SavedQuotesRepository {}
