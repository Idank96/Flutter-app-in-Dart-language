import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'pages/form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_app/myGlobals.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("he", "IL"),
      ],
      locale: Locale("he", "IL"),
      title: 'Garden App',
      theme: ThemeData(
          fontFamily: 'Rubik',
          primarySwatch: primeGreenColor2,
          primaryColor: primeGreenColor),
      home: AnimatedSplashScreen(
        splash: Icons.home,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: secondOrangeColor,
        nextScreen: FormScreen(),
      ),
    );
  }
}
