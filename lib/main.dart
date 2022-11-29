import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:nba_app/intro%20page.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const NbaTeam());
}

class NbaTeam extends StatelessWidget {
  const NbaTeam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sizer',
          theme: ThemeData.light(),
          home: AnimatedSplashScreen(
            splashIconSize: 300,
            splashTransition: SplashTransition.fadeTransition,
            duration: 3000,
            splash: Image.asset(
              'images/nbalogo.png',
            ),
            nextScreen: IntroPage(),
          ),
        );
      },
    );
  }
}
