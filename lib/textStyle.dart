import 'package:flutter/material.dart';

class Style {
  static final baseTextStyle = const TextStyle(fontFamily: 'Acme',color: Colors.white);
  static final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w600);
  static final regularTextStyle = const TextStyle(
    fontFamily: 'Josefin Sans',
      color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w200);
      static final commonTextStyle =regularTextStyle.copyWith(
      color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w200);
   static final headerstyle=headerTextStyle.copyWith(color: Colors.white);   
}
