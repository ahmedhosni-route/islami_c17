import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islamic_c17/modules/hadeth_details/screens/hadeth_screen.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../hadeth_details/model/hadeth_data.dart';

class HadethScreen extends StatefulWidget {
  const HadethScreen({super.key});

  @override
  State<HadethScreen> createState() => _HadethScreenState();
}

class _HadethScreenState extends State<HadethScreen> {
  List<HadethData> ahadeth = [];
  @override
  Widget build(BuildContext context) {
    if (ahadeth.isEmpty) {
      readHadeth();
    }
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ResizeImage(
              const AssetImage(
                  "assets/images/vertical-shot-hassan-ii-mosque-casablanca-morocco.jpg"),
              width: 1000),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.dark.withValues(alpha: 0.7),
                    AppColors.dark,
                  ],
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/img_header.png",
                        width: 300,
                      ),
                    ),
                    Expanded(
                      child: CarouselSlider(
                        options: CarouselOptions(
                            height: double.infinity,
                            viewportFraction: 0.8,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: true,
                            enlargeFactor: 0.15),
                        items: ahadeth.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, HadethDetailsScreen.routeName ,arguments: i );
                                },
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/HadithCardBackGround.png"),
                                            opacity: 0.2),
                                        borderRadius: BorderRadius.circular(16)),
                                    child: Column(
                                      children: [
                                        Row(
                                          textDirection: TextDirection.ltr,
                                          children: [
                                            Image.asset(
                                              "assets/images/img_left_corner.png",
                                              color: AppColors.dark,
                                              width: 80,
                                            ),
                                            Expanded(
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Center(
                                                  child: Text(
                                                    i.title,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: AppColors.dark,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Image.asset(
                                              "assets/images/img_right_corner.png",
                                              color: AppColors.dark,
                                              width: 80,
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              i.body,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: AppColors.dark,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                              maxLines: 19,
                                              overflow: TextOverflow.ellipsis,
                                              textDirection: TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> readHadeth() async {
    for (int i = 1; i <= 50; i++) {
      String hadeth = await rootBundle.loadString("assets/hadeeth/h$i.txt");
      hadeth = hadeth.trim();
      String title = hadeth.split("\n").first.trim();
      String body = hadeth.replaceAll(title, "");
      ahadeth.add(HadethData(
        title: title,
        body: body,
      ));
    }
    setState(() {});
  }
}
