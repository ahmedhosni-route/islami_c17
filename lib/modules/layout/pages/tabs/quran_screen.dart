import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islamic_c17/core/constant/app_constant.dart';
import 'package:islamic_c17/core/theme/app_colors.dart';
import 'package:islamic_c17/modules/sura_details/model/sura_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/save_card_widget.dart';
import '../../widgets/sura_card_widget.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  List<String> ids = [];
  List<int> searchList = [];
  @override
  void initState() {
    getSuraList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ResizeImage(
              const AssetImage("assets/images/taj-mahal-agra-india.jpg"),
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
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/images/img_header.png",
                          width: 300,
                        ),
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            hintText: "Sura Name",
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            fillColor: AppColors.dark.withValues(alpha: 0.7),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: AppColors.primary)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: AppColors.primary)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: AppColors.primary)),
                            prefixIcon: SvgPicture.asset(
                              "assets/svg/ic_quran.svg",
                              color: AppColors.primary,
                              width: 20,
                              fit: BoxFit.scaleDown,
                            )),
                        onChanged: (value) {
                          search(value);
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      if (ids.isNotEmpty && searchList.isEmpty)
                        Text(
                          "Most Recently",
                          style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      if (ids.isNotEmpty && searchList.isEmpty)
                        SizedBox(
                          height: 100,
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: 8,
                              );
                            },
                            itemCount: ids.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              int id = int.parse(ids[index]);
                              SuraModel suraModel = SuraModel(
                                  id: id + 1,
                                  nameEn: AppConstant.suraEn[id],
                                  nameAr: AppConstant.suranAr[id],
                                  ayaVerses: AppConstant.ayaNumber[id]);
                              return SaveCardWidget(suraModel: suraModel);
                            },
                          ),
                        ),
                      SizedBox(
                        height: 12,
                      ),
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Divider(
                              endIndent: 30,
                              indent: 30,
                              height: 25,
                            );
                          },
                          itemCount: searchList.isEmpty
                              ? AppConstant.ayaNumber.length
                              : searchList.length,
                          itemBuilder: (context, i) {
                            int index = searchList.isEmpty ? i : searchList[i];
                            return SuraCardWidget(
                              onTap: (suraModel) {
                                saveSura(index.toString());
                              },
                              suraModel: SuraModel(
                                  id: index + 1,
                                  nameEn: AppConstant.suraEn[index],
                                  nameAr: AppConstant.suranAr[index],
                                  ayaVerses: AppConstant.ayaNumber[index]),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> saveSura(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    ids.remove(id);
    ids.insert(0, id);
    await prefs.setStringList("suraList", ids);
    setState(() {});
  }

  Future<void> getSuraList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    ids = prefs.getStringList("suraList") ?? [];
    setState(() {});
  }

  void search(String q) {
    searchList = [];
    if (q.isEmpty) {
      setState(() {});
      return;
    }

    AppConstant.suranAr.where(
      (element) {
        if (element.toLowerCase().contains(q.toLowerCase())) {
          searchList.add(AppConstant.suranAr.indexOf(element));
        }
        return true;
      },
    ).toList();
    AppConstant.suraEn.where(
      (element) {
        if (element.contains(q)) {
          searchList.add(AppConstant.suraEn.indexOf(element));
        }
        return true;
      },
    ).toList();
    print(searchList);
    setState(() {});
  }
}
