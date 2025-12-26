import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic_c17/modules/splash/pages/splash_screen.dart';

import 'modules/hadeth_details/screens/hadeth_screen.dart';
import 'modules/layout/pages/layout_screen.dart';
import 'modules/sura_details/pages/sura_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Islamic',
      theme: ThemeData(
        fontFamily: GoogleFonts.tajawal().fontFamily,
      ),
      routes: {
        LayoutScreen.routeName: (_) => LayoutScreen(),
        SplashScreen.routeName: (_) => SplashScreen(),
        SuraDetailsScreen.routeName: (_) => SuraDetailsScreen(),
        HadethDetailsScreen.routeName: (_) => HadethDetailsScreen(),
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}
