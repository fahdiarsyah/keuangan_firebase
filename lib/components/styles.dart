import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var primaryColor = const Color(0xffF4A261);
var warningColor = const Color(0xFFE9C46A);
var dangerColor = const Color(0xFFE76F51);
var successColor = const Color(0xFF00FF00);
var whiteColor = Color.fromARGB(255, 243, 246, 247);
var blueColor = Color.fromARGB(255, 51, 135, 209);
var youngBlue = Color.fromARGB(255, 43, 168, 199);
var accountColor = Color.fromARGB(255, 22, 6, 6);

TextStyle headerStyle({int level = 1, bool blue = true}) {
  List<double> levelSize = [30, 24, 20, 16, 12, 8];
  return TextStyle(
      fontSize: levelSize[level - 1],
      fontFamily: GoogleFonts.roboto().fontFamily,
      fontWeight: FontWeight.bold,
      color: blue ? Colors.blue.shade800 : Colors.white);
}

TextStyle titleStyle({int level = 1, bool dark = false}) {
  List<double> levelSize = [30, 24, 20, 16, 12, 8];
  return TextStyle(
      fontSize: levelSize[level - 1],
      fontFamily: GoogleFonts.montserrat().fontFamily,
      fontWeight: FontWeight.bold,
      color: dark ? Colors.black : Colors.white,);
}

ButtonStyle buttonStyle = ElevatedButton.styleFrom(
  foregroundColor: whiteColor, padding: const EdgeInsets.symmetric(vertical: 15), backgroundColor: blueColor,
  side: BorderSide(color: blueColor, width: 2),
);

ButtonStyle buttonStyle2 = ElevatedButton.styleFrom(
  foregroundColor: blueColor, padding: const EdgeInsets.symmetric(vertical: 15), backgroundColor: whiteColor,
  side: BorderSide(color: blueColor, width: 2),
);