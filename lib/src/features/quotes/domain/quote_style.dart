import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuoteStyle {
  final int id;
  final Color backgroundColor;
  final Color foregroundColor;
  final String fontFamily;

  QuoteStyle._({
    required this.id,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.fontFamily,
  });

  factory QuoteStyle.fromIndex(int id) {
    final colors = _colorPairs[id % _colorPairs.length];
    final font = _fontFamilies[id % _fontFamilies.length];
    return QuoteStyle._(
      id: id,
      backgroundColor: colors.first,
      foregroundColor: colors.last,
      fontFamily: font,
    );
  }

  static List<List<Color>> get _colorPairs => [
        [const Color(0xFF9254FF), const Color(0xFF00FFD1)],
        [const Color(0xFFF1C3B7), const Color(0xFF191E80)],
        [const Color(0xFF50E3C1), const Color(0xFF9254FF)],
        [const Color(0xFF3D1F62), const Color(0xFF00E1E5)],
        [Colors.black, const Color(0xFFFF0100)],
        [const Color(0xFF00AAD2), const Color(0xFFFFCD3C)],
        [const Color(0xFF0061C2), const Color(0xFFFDFF43)],
        [const Color(0xFF5CA14A), Colors.white],
        [const Color(0xFFE64B4B), Colors.white],
      ];

  static List<String> get _fontFamilies => [
        GoogleFonts.abrilFatface().fontFamily!,
        GoogleFonts.alfaSlabOne().fontFamily!,
        GoogleFonts.barrio().fontFamily!,
        GoogleFonts.jotiOne().fontFamily!,
        GoogleFonts.lacquer().fontFamily!,
      ];
}
