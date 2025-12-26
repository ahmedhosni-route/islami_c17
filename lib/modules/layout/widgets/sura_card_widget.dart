
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../sura_details/model/sura_model.dart';
import '../../sura_details/pages/sura_details_screen.dart';

class SuraCardWidget extends StatelessWidget {
  final SuraModel suraModel;
  final void Function(SuraModel suraModel) onTap;
  const SuraCardWidget({super.key, required this.suraModel,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call(suraModel);
        Navigator.pushNamed(context, SuraDetailsScreen.routeName,
            arguments: suraModel);
      },
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/aya_icon.png"),
                    fit: BoxFit.cover)),
            child: Center(
              child: Text(
                suraModel.id.toString(),
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white),
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  suraModel.nameEn,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white),
                ),
                Text(
                  "${suraModel.ayaVerses} verses",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white),
                ),
              ],
            ),
          ),
          Text(
            suraModel.nameAr,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
