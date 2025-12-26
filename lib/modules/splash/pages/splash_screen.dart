import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:islamic_c17/core/theme/app_colors.dart';
import 'package:islamic_c17/modules/layout/pages/layout_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "/";
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Center(
                    child: ElasticIn(
                        duration: Duration(seconds: 2),
                        child: Image.asset("assets/images/logo.png")))),
            Center(
                child: FadeInUpBig(
              delay: Duration(seconds: 2),
              duration: Duration(seconds: 1),
              onFinish: (direction) {
                Navigator.pushReplacementNamed(context, LayoutScreen.routeName);
              },
              child: Image.asset(
                "assets/images/route_logo.png",
                width: 200,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
