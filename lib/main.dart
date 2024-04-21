import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/pages/intro.dart';
import 'colors.dart';

void main() {
  runApp(MyApp());
}

final ThemeData _blueArchiveTheme = _buildBlueArchiveTheme();

ThemeData _buildBlueArchiveTheme() {
  final ThemeData base = ThemeData.light(useMaterial3: true);
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: baMain,
      secondary: baNPC,
      background: baAntagonist, // Change background color here
      error: Colors.red,
    ),
    // TODO: Add the text themes (103)
    textTheme: _buildShrineTextTheme(base.textTheme),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: baMain,
    ),
    // TODO: Decorate the inputs (103)
  );
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base.copyWith(
    headlineLarge: GoogleFonts.openSansTextTheme(base).headlineSmall!.copyWith(
        fontSize: 26.0, fontWeight: FontWeight.w900, color: Colors.white),
    headlineSmall: GoogleFonts.openSansTextTheme(base).headlineSmall!.copyWith(
        fontWeight: FontWeight.w600, fontSize: 16.0, color: Colors.black),
    titleLarge: GoogleFonts.openSansTextTheme(base).titleLarge!.copyWith(
        fontSize: 24.0, fontWeight: FontWeight.w900, color: Colors.white),
    bodySmall: GoogleFonts.openSansTextTheme(base).bodySmall!.copyWith(
        fontWeight: FontWeight.w600, fontSize: 14.0, color: Colors.white),
    bodyMedium: GoogleFonts.openSansTextTheme(base).bodyMedium!.copyWith(
        fontWeight: FontWeight.w700, fontSize: 16.0, color: Colors.white),
    bodyLarge: GoogleFonts.openSansTextTheme(base).bodyLarge!.copyWith(
        fontWeight: FontWeight.w800, fontSize: 18.0, color: Colors.white),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Flutter App',
      theme: _blueArchiveTheme,
      home: IntroScreen(),
    );
  }
}
