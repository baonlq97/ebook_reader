import 'package:flutter/material.dart';


const ColorScheme lightColorScheme = ColorScheme(
  primary: Color(0xFF0D6681),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFBBEAFF),
  onPrimaryContainer: Color(0xFF001F29),
  secondary: Color(0xFF4C616B),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFCFE6F1),
  onSecondaryContainer: Color(0xFF071E26),
  tertiary: Color(0xFF5C5B7E),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFE2DFFF),
  onTertiaryContainer: Color(0xFF181837),
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFFDAD6),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFF5FAFD),
  onBackground: Color(0xFF171C1F),
  surface: Color(0xFFF5FAFD),
  onSurface: Color(0xFF171C1F),
  surfaceVariant: Color(0xFFDCE4E8),
  onSurfaceVariant: Color(0xFF40484C),
  outline: Color(0xFF70787D),
  outlineVariant: Color(0xFFC0C8CC),
  scrim: Color(0xFF000000),
  inverseSurface: Color(0xFF2C3134),
  onInverseSurface: Color(0xFFEDF1F5),
  inversePrimary: Color(0xFF89D0EE),
  surfaceTint: Color(0xFF0D6681),
  brightness: Brightness.light,
);

const ColorScheme darkColorScheme = ColorScheme(
  primary: Color(0xFF89D0EE),
  onPrimary: Color(0xFF003545),
  primaryContainer: Color(0xFF004D62),
  onPrimaryContainer: Color(0xFFBBEAFF),
  secondary: Color(0xFFB4CAD5),
  onSecondary: Color(0xFF1E333C),
  secondaryContainer: Color(0xFF354A53),
  onSecondaryContainer: Color(0xFFCFE6F1),
  tertiary: Color(0xFFC5C3EA),
  onTertiary: Color(0xFF2D2D4D),
  tertiaryContainer: Color(0xFF444465),
  onTertiaryContainer: Color(0xFFE2DFFF),
  error: Color(0xFFFFB4AB),
  onError: Color(0xFF690005),
  errorContainer: Color(0xFF93000A),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF0F1417),
  onBackground: Color(0xFFDEE3E6),
  surface: Color(0xFF0F1417),
  onSurface: Color(0xFFDEE3E6),
  surfaceVariant: Color(0xFF40484C),
  onSurfaceVariant: Color(0xFFC0C8CC),
  outline: Color(0xFF8A9296),
  outlineVariant: Color(0xFF40484C),
  scrim: Color(0xFF000000),
  inverseSurface: Color(0xFFDEE3E6),
  onInverseSurface: Color(0xFF2C3134),
  inversePrimary: Color(0xFF0D6681),
  surfaceTint: Color(0xFF89D0EE),
  brightness: Brightness.dark,
);

final ThemeData lightTheme = ThemeData(
  colorScheme: lightColorScheme,
  useMaterial3: true, // Use Material Design 3
);

final ThemeData darkTheme = ThemeData(
  colorScheme: darkColorScheme,
  useMaterial3: true, // Use Material Design 3
);