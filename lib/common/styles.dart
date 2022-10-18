import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// size
const double defaultMargin = 20;

// color
const Color backgroundColor = Color(0xFFF4F4F0);
const Color primaryColor = Color(0xffFD841F);
const Color secondaryColor = Color(0xFF2B2826);
const Color whiteColor = Color(0xffFFFFFF);
const Color greyColor = Color(0xFFAEAEAE);

// fontWeight
FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;

// font
TextTheme customTextTheme = TextTheme(
  titleLarge: GoogleFonts.poppins(
    fontSize: 20,
    height: 1.27,
    letterSpacing: 0,
    fontWeight: semiBold,
  ),
  titleMedium: GoogleFonts.poppins(
    fontSize: 16,
    height: 1.09,
    letterSpacing: 0.15,
    fontWeight: medium,
  ),
  titleSmall: GoogleFonts.poppins(
    fontSize: 14,
    height: 1.2,
    letterSpacing: 0.1,
    fontWeight: medium,
  ),
  bodyLarge: GoogleFonts.poppins(
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0.15,
    fontWeight: regular,
  ),
  bodyMedium: GoogleFonts.poppins(
    fontSize: 14,
    height: 1.42,
    letterSpacing: 0.25,
    fontWeight: regular,
  ),
  bodySmall: GoogleFonts.poppins(
    fontSize: 12,
    height: 1.33,
    letterSpacing: 0.4,
    fontWeight: regular,
  ),
);
