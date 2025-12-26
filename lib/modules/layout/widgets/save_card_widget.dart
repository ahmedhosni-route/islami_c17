import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../sura_details/model/sura_model.dart';
import '../../sura_details/pages/sura_details_screen.dart';

class SaveCardWidget extends StatelessWidget {
  const SaveCardWidget({
    super.key,
    required this.suraModel,
  });

  final SuraModel suraModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, SuraDetailsScreen.routeName,
            arguments: suraModel);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: AppColors.primary,
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              mainAxisAlignment:
              MainAxisAlignment.spaceAround,
              children: [
                Text(
                  suraModel.nameEn,
                  style: TextStyle(
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  suraModel.nameAr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "${suraModel.ayaVerses} Verses",
                  style: TextStyle(
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              width: 16,
            ),
            Image.asset(
              "assets/images/quranSura.png",
              height: 90,
            )
          ],
        ),
      ),
    );
  }
}
