import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic_c17/core/theme/app_colors.dart';
import 'package:islamic_c17/modules/sura_details/model/sura_model.dart';

class SuraDetailsScreen extends StatefulWidget {
  static const String routeName = "sura-details";
  SuraDetailsScreen({super.key});

  @override
  State<SuraDetailsScreen> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen> {
  String sura = "";
  List<String> suraList = [];

  @override
  Widget build(BuildContext context) {
    SuraModel suraModel =
        ModalRoute.of(context)?.settings.arguments as SuraModel;
    if (suraList.isEmpty) {
      readFile(suraModel.id.toString());
    }
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.primary),
        backgroundColor: Colors.transparent,
        title: Text(
          suraModel.nameEn,
          style:
              TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: AppColors.dark,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              textDirection: TextDirection.ltr,
              children: [
                Image.asset("assets/images/img_left_corner.png"),
                Expanded(
                  child: Center(
                    child: Text(
                      suraModel.nameAr,
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
            // todo : New Version

            Expanded(
              child: SingleChildScrollView(
                child: Text.rich(
                  TextSpan(
                    children: suraList.map(
                      (e) {
                        int index = suraList.indexOf(e);
                        return TextSpan(
                          text: "$e[${index + 1}] ",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                    width: double.infinity,
                                    height: 300,
                                    child: Center(child: Text(e)),
                                  );
                                },
                              );
                            },
                          style: TextStyle(
                              fontSize: 20,
                              color: e.contains("اللَّهِ")
                                  ? Colors.blue
                                  : AppColors.primary,
                              height: 2,
                              fontFamily: GoogleFonts.amiriQuran().fontFamily),
                        );
                      },
                    ).toList(),
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
            )

            // todo : Old Version
            // Expanded(child: ListView.builder(
            //     itemCount: suraList.length,
            //     itemBuilder: (context, index) {
            //       return Container(
            //         margin: EdgeInsets.all(4),
            //         padding: EdgeInsets.all(12),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(16),
            //           border: Border.all(
            //             color: AppColors.primary
            //           )
            //         ),
            //         child: Center(
            //           child: Text( "${suraList[index]}[${index+1}]"  ,style: TextStyle(
            //             fontSize: 16,
            //             color: AppColors.primary,
            //             // fontFamily: GoogleFonts.amiriQuran().fontFamily
            //           ),
            //           textDirection: TextDirection.rtl,
            //           textAlign: TextAlign.center,
            //           ),
            //         ),
            //       );
            //     },))
          ],
        ),
      ),
    );
  }

  Future<void> readFile(String id) async {
    sura = await rootBundle.loadString("assets/suras/$id.txt");
    suraList = sura.trim().split("\n");
    setState(() {});
  }
}
