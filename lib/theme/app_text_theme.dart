import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/*---------------------------------------------------TEXT WIDGETS-------------------------------------------------------------------------------*/
///font regular
buildTextRegularWidget(String title,Color textColor,BuildContext context,double textSize,{FontWeight fontWeight=FontWeight.w400,
  TextAlign align=TextAlign.justify,double letterSpacing=0.0,FontStyle fontStyle=FontStyle.normal,int maxLines=5,
  TextDecoration decoration=TextDecoration.none}){
  return Text(title,style: GoogleFonts.rubik(textStyle: TextStyle(fontSize: textSize,color: textColor, fontWeight: fontWeight, letterSpacing: letterSpacing,
    fontStyle: fontStyle, decoration:decoration,)), maxLines: maxLines, textAlign: align);
}

///font medium
buildTextMediumWidget(String title,Color textColor,BuildContext context,double textSize,{FontWeight fontWeight=FontWeight.w700,
  TextAlign align=TextAlign.justify,double letterSpacing=0.0,FontStyle fontStyle=FontStyle.normal,int maxLines=5,
  TextDecoration decoration=TextDecoration.none,bool toUpperCase=false}){
  return Text(toUpperCase?title.toUpperCase():title,style: GoogleFonts.rubik(textStyle: TextStyle(fontSize: textSize,color: textColor, fontWeight: fontWeight, letterSpacing: letterSpacing,
    fontStyle: fontStyle, decoration:decoration)),maxLines: maxLines, textAlign: align,);
}

///font bold
buildTextBoldWidget(String title,Color textColor,BuildContext context,double textSize,{FontWeight fontWeight=FontWeight.bold,
  TextAlign align=TextAlign.justify,double letterSpacing=0.0,FontStyle fontStyle=FontStyle.normal,int maxLines=5,
  TextDecoration decoration=TextDecoration.none,}){
  return Text(title,style: GoogleFonts.rubik(textStyle: TextStyle(fontSize: textSize,color: textColor, fontWeight: fontWeight, letterSpacing: letterSpacing,
    fontStyle: fontStyle, decoration:decoration)),maxLines: maxLines, textAlign: align);
}
