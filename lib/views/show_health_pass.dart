import 'package:e_citizen/consts/app_assets.dart';
import 'package:e_citizen/consts/app_colors.dart';
import 'package:e_citizen/consts/values.dart';
import 'package:e_citizen/helpers/screen_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widgets/footer.dart';

class ShowHealthPass extends StatefulWidget {
  const ShowHealthPass({Key? key}) : super(key: key);

  @override
  _ShowHealthPassState createState() => _ShowHealthPassState();
}

class _ShowHealthPassState extends State<ShowHealthPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: pagePadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                ),
                              ),
                              SvgPicture.asset(
                                AppAssets.addUser,
                                height: 60,
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            "Mon pass sanitaire",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Center(
                        child: Image.asset(
                          AppAssets.qrCode,
                          width: 300,
                          height: 300,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Container(
                      width: fullWidth(context),
                      color: AppColors.sectionGrey,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 12, 18, 12),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("Maladie Cible"),
                                  Flexible(
                                    child: Text("COVID-19"),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("Nombre de doses reçues"),
                                  Flexible(
                                    child: Text("2/2"),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: AppColors.primaryColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Dose 1",
                                  ),
                                  Flexible(
                                    child: Text(
                                      "BNT162b2 / COMIRNATY Tozinameran (INN) / BioNTech/Pfizer Fabricant : BioNTech/Pfizer Lot : FC8889 Date de vaccination : 12/07/2021",
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("Dose 2"),
                                  Flexible(
                                    child: Text(
                                      "BNT162b2 / COMIRNATY Tozinameran (INN) / BioNTech/Pfizer Fabricant : BioNTech/Pfizer Lot : FC8889 Date de vaccination : 12/07/2021",
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: fullHeight(context) / 5,
                    ),
                    const Footer(),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
