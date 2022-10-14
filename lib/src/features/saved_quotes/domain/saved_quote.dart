import 'package:equatable/equatable.dart';

class SavedQuote with EquatableMixin {
  final int quoteId;
  final int styleId;

  SavedQuote({required this.quoteId, required this.styleId});

  factory SavedQuote.fromString(String savedString) {
    final idList = savedString.split('#').map((s) => int.parse(s));
    return SavedQuote(quoteId: idList.first, styleId: idList.last);
  }

  @override
  String toString() => '$quoteId#$styleId';

  @override
  List<Object?> get props => [quoteId];
}
