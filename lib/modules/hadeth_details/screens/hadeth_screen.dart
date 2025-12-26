import 'package:flutter/material.dart';
import 'package:islamic_c17/modules/hadeth_details/model/hadeth_data.dart';

import '../../../core/theme/app_colors.dart';

class HadethDetailsScreen extends StatelessWidget {
  static const String routeName = "hadeth_details";
  const HadethDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HadethData hadeth =
        ModalRoute.of(context)!.settings.arguments as HadethData;
    return Scaffold(
      backgroundColor: AppColors.dark,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.primary),
        backgroundColor: Colors.transparent,
        title: Text(
          hadeth.title,
          style:
              TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                textDirection: TextDirection.ltr,
                children: [
                  Image.asset("assets/images/img_left_corner.png"),
                  Expanded(
                    child: Center(
                      child: Text(
                        hadeth.title,
                        style: TextStyle(
                            fontSize: 24,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Image.asset("assets/images/img_right_corner.png"),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    hadeth.body,
                    style: TextStyle(color: AppColors.primary, fontSize: 18),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
