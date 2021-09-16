import 'package:e_citizen/consts/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SvgPicture.asset(
            AppAssets.blason,
            height: 80,
          ),
          const Text(
            "XXX une application du gouvernement Togolais",
            style: TextStyle(fontSize: 7.777864),
          ),
        ],
      ),
    );
  }
}
