import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islamic_c17/core/theme/app_colors.dart';
import 'package:islamic_c17/modules/layout/pages/tabs/hadeth_screen.dart';
import 'package:islamic_c17/modules/layout/pages/tabs/quran_screen.dart';
import 'package:islamic_c17/modules/layout/pages/tabs/radio_screen.dart';
import 'package:islamic_c17/modules/layout/pages/tabs/sebha_screen.dart';
import 'package:islamic_c17/modules/layout/pages/tabs/time_screen.dart';

class LayoutScreen extends StatefulWidget {
  static const String routeName = "layout";
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(
        const AssetImage("assets/images/taj-mahal-agra-india.jpg"),
        context,
      );
    });
    super.initState();
  }

  int index = 0;
  List<Widget> tabs = [
    QuranScreen(),
    HadethScreen(),
    SebhaScreen(),
    RadioScreen(),
    TimeScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.primary,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          showUnselectedLabels: false,
          currentIndex: index,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          onTap: (value) {
            index = value;
            setState(() {});
          },
          items: [
            getItem(icon: "assets/svg/ic_quran.svg", label: "Quran"),
            getItem(icon: "assets/svg/ic_hadeth.svg", label: "Hadeth"),
            getItem(icon: "assets/svg/ic_sebha.svg", label: "Sebha"),
            getItem(icon: "assets/svg/ic_radio.svg", label: "Radio"),
            getItem(icon: "assets/svg/ic_time.svg", label: "Time"),
          ]),
      body: tabs[index],
    );
  }

  BottomNavigationBarItem getItem(
      {required String icon, required String label}) {
    return BottomNavigationBarItem(
      activeIcon: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.dark.withValues(alpha: 0.6)),
        child: SvgPicture.asset(icon,
            color: AppColors.white, width: 28, height: 28),
      ),
      icon: SvgPicture.asset(
        icon,
        width: 26,
        height: 26,
      ),
      label: label,
    );
  }
}
