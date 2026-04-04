import 'package:flutter/material.dart';

Widget texto2Lineas(String titulo,String texto, Color colorTitulo, Color colorText,double fontSizeTitle,double fontSizeText, bool boldTitle, bool boldSubTitle){
    return  RichText(
        text: TextSpan(
            children: <TextSpan>[
                TextSpan(text: "$titulo \n", style: TextStyle(color: colorTitulo, fontSize: fontSizeTitle, fontWeight: boldTitle==true? FontWeight.bold:FontWeight.normal)),
                TextSpan(text: "$texto", style: TextStyle(color: colorText, fontSize: fontSizeText, fontWeight: boldSubTitle==true? FontWeight.bold:FontWeight.normal)),
            ]
        ),
    );
}


Widget texto4Lineas(String texto1, String texto2, String texto3, String texto4, Color colorTexto1, Color colorTexto2, Color colorTexto3, Color colorTexto4,
                    double fontSizeText1,double fontSizeText2,double fontSizeText3,double fontSizeText4,bool boldText1, bool boldText2,bool boldText3, bool boldText4){
    return  RichText(
        text: TextSpan(
            children: <TextSpan>[
                TextSpan(text: "$texto1", style: TextStyle(color: colorTexto1, fontSize: fontSizeText1, fontWeight: boldText1==true? FontWeight.bold:FontWeight.normal)),
                TextSpan(text: "$texto2\n", style: TextStyle(color: colorTexto2, fontSize: fontSizeText2, fontWeight: boldText2==true? FontWeight.bold:FontWeight.normal)),
                TextSpan(text: "$texto3", style: TextStyle(color: colorTexto3, fontSize: fontSizeText3, fontWeight: boldText3==true? FontWeight.bold:FontWeight.normal)),
                TextSpan(text: "$texto4", style: TextStyle(color: colorTexto4, fontSize: fontSizeText4, fontWeight: boldText4==true? FontWeight.bold:FontWeight.normal)),
            ]
        ),
    );
}
