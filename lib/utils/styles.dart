import 'package:flutter/material.dart';
import 'package:note/utils/contants.dart';

// ***************** COLORS *****************
const ligth = Color(0xFFFFFFFF);

const grey300 = Color(0xFFF0F0F0);
const grey400 = Color(0xFFE6E6E6);
const grey600 = Color(0xFF7C7C7C);

const blue300 = Color(0xFFD9E8FC);
const pink300 = Color(0xFFFFD8F4);
const green300 = Color(0xFFB0E9CA);
const yellow300 = Color(0xFFFDE99D);
const orange300 = Color(0xFFFFEADD);

List<Color> get colors {
  return [blue300, pink300, green300, yellow300, orange300];
}
// ***************** COLORS *****************

const inputDecoration = InputDecorationTheme(
  filled: true,
  fillColor: grey300,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
    borderSide: BorderSide.none,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(padding)),
    borderSide: BorderSide(color: Colors.red, width: 1),
  ),
);

final chipTheme = ChipThemeData(
  backgroundColor: Colors.blue,
  disabledColor: Colors.transparent,
  selectedColor: Colors.green,
  secondarySelectedColor: Colors.black,
  checkmarkColor: Colors.purple,
  surfaceTintColor: Colors.yellow,
  showCheckmark: false,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
  ),
  labelStyle: ThemeData.light().textTheme.titleLarge,
  secondaryLabelStyle: ThemeData.light().textTheme.titleLarge,
  padding: const EdgeInsets.all(12.0),
);

ThemeData get theme {
  return ThemeData(
    useMaterial3: true,
    inputDecorationTheme: inputDecoration,
    fontFamily: 'ProductSans',
    chipTheme: chipTheme,
  );
}
