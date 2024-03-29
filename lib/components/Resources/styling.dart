import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';

class Apptheme {
  Apptheme._();

  static const SecondaryColor = const Color(0xff7ab9e5);
  static const PrimaryColor = const Color(0xff358EF0);
  static const TextColor = const Color(0xFF929794);
  static const boardingTextColor = const Color(0xFF8a97c1);
  static const boardinglabelColor = const Color(0xFF3576fd);
  static const textColo1r = const Color(0xffF32458);
  static const textColor2 = const Color(0xFFfa4f22);
  static const blacktextColor = const Color(0xFF000000);
  static const whitetextcolor = const Color(0xFFffffff);

  static final ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Apptheme.PrimaryColor,
      brightness: Brightness.light,
      textTheme: LightTextTheme);

  // ignore: non_constant_identifier_names
  static final LightTextTheme = TextTheme(headline6: maintextColor);

  static final TextStyle loginPageTitle = GoogleFonts.oregano(
    fontWeight: FontWeight.w400,
    fontSize: 3 * SizeConfig.textMultiplier,
    color: Apptheme.blacktextColor,
  );
  // TextStyle(

  //    );

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  static final TextStyle maintextColor =
      TextStyle(color: Apptheme.whitetextcolor);
}
