import 'package:equatable/equatable.dart';

class Quote with EquatableMixin {
  final int id;
  final String quote;
  final String author;

  const Quote({
    required this.id,
    required this.quote,
    required this.author,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        id: json['id'],
        quote: json['quote'],
        author: json['author'],
      );

  @override
  List<Object?> get props => [id];
}
