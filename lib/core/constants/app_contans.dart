import 'package:flutter/material.dart';

class AppRoutesScreen {
  // Constructor privado para evitar que se instancie
  AppRoutesScreen._();

  static const String splash = 'splash';
  static const String login = 'login';
  static const String home = 'home';
  static const String error = 'error';
  static const String devDashboard = 'not_found';

  static const String selectBusiness = 'select_business';
  static const String selectBusinessGrid = 'select_businessGrid';
  static const String homeRadial = 'home_radial';
  static const String homeBentoBox = 'home_bentoBox';
  static const String homeCategori = 'home_categori';
  static const String homeDashboard = 'home_dashboard';
  static const String homeGrid = 'home_grid';
}

class AppAssets {
  // Constructor privado para evitar que se instancie
  AppAssets._();
  static const String logo = 'assets/images/logo_blue.png';
 static const String logoSplash = 'assets/images/logo_white.png';
}

class AppColors {
  // Constructor privado para evitar que se instancie
  AppColors._();

  static const Color primary = Color(0xFF1E88E5);
  static const Color background = Color(0xFF13406D);
  static const Color backgroundSecondary = Color(0xFF13406D);
  static const Color buttonPrimary = Color(0xFF0C1C44);

  // Colores de componentes específicos
  static const Color headerPanel = Color.fromARGB(255, 0, 136, 40);
  static const Color titleGraphic = Colors.green;
  static const Color backgroundGraphic = Color.fromARGB(255, 227, 225, 225);

  static const Color appBarIcon = Color(0xFFFF0200);
  static const Color appBarTextTitle = Colors.white;
  static const Color appBarTextSubTitle = Color(0xff24CBE5);

  // Paleta para Gráficos (Pie charts, Bar charts, etc.)
  static const List<Color> graphics = [
    Color(0xff058DC7),
    Color(0xff50B432),
    Color(0xffED561B),
    Color(0xffDDDF00),
    Color(0xff24CBE5),
    Color(0xff64E572),
    Color(0xffFF9655),
    Color(0xffFFF263),
    Color(0xff6AF9C4),
  ];
}
