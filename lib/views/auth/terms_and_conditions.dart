import 'package:e_citizen/consts/app_assets.dart';
import 'package:e_citizen/consts/app_colors.dart';
import 'package:e_citizen/consts/app_styles.dart';

import 'package:e_citizen/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'register.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  _TermsAndConditionsState createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: Utils.fullHeight(context),
          width: Utils.fullWidth(context),
          child: Padding(
            padding: AppStyles.pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  AppAssets.blason,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Vos données sont protegées",
                  style: AppStyles.title,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Conformément à la loi XXX vos données sont protégées Donec nec justo eget felis facilisis fermentum. Aliquam porttitor mauris sit amet orci. Aenean dignissim pellentesque felis.\n\nMorbi in sem quis dui placerat ornare. Pellentesque odio nisi, euismod in, pharetra a, ultricies in, diam. Sed arcu. Cras consequat.",
                  style: AppStyles.information,
                ),
                const Spacer(),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primaryColor),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Register(),
                        ));
                  },
                  child: Padding(
                    padding: AppStyles.buttonPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Poursuivre",
                          textAlign: TextAlign.center,
                          style: AppStyles.buttonText,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
