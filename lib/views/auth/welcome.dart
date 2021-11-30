import 'package:e_citizen/consts/app_styles.dart';

import 'package:e_citizen/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_citizen/consts/app_assets.dart';
import 'package:e_citizen/consts/app_colors.dart';
import 'package:e_citizen/views/auth/login.dart';
import 'package:e_citizen/views/auth/terms_and_conditions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

const List<String> texts = [
  "XXX est la nouvelle façon d'interagir avec l'administration publique",
  "XXX est la nouvelle façon de faire vos démarches administratives",
  "XXX sécurise tous vos échanges et vous les mets à disposition en 1 clic",
];

class WelcomePage extends StatefulWidget {
  static const id = "welcome_page";
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final CarouselController _controller = CarouselController();
  ValueNotifier<int> index = ValueNotifier(0);

  Future<bool> _requestPermission() async {
    if (await Permission.storage.request().isGranted &&
        await Permission.camera.request().isGranted) {
      return true;
    }
    await Permission.storage.request();
    await Permission.camera.request();
    return false;
  }

  void askPermission() async {
    await _requestPermission();
  }


  @override
  void initState() {
    askPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: Utils.fullHeight(context),
          width: Utils.fullWidth(context),
          child: Padding(
            padding: AppStyles.pagePadding,
            child: ValueListenableBuilder<int>(
                valueListenable: index,
                builder: (context, i, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        texts[i],
                        style: AppStyles.bigTitle,
                      ),
                      Expanded(
                        child: CarouselSlider(
                          items: [
                            SvgPicture.asset(
                              AppAssets.welcomePageA,
                            ),
                            SvgPicture.asset(
                              AppAssets.welcomePageB,
                            ),
                            SvgPicture.asset(
                              AppAssets.welcomePageC,
                            ),
                          ],
                          carouselController: _controller,
                          options: CarouselOptions(
                            viewportFraction: 1.0,
                            //height: fullHeight(context) * 3.5 / 5,
                            enlargeCenterPage: false,
                            initialPage: 0,
                            enableInfiniteScroll: false,
                            autoPlayCurve: Curves.ease,
                            onPageChanged: (newIndex, reason) {
                              index.value = newIndex;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: texts.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
                              child: Container(
                                width: 12.0,
                                height: 12.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: i == entry.key
                                      ? AppColors.primaryColor
                                      : AppColors.grey,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.primaryColor),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TermsAndConditions(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: AppStyles.buttonPadding,
                          child: Row(
                            children: const [
                              Expanded(
                                child: Text(
                                  "Créer un compte",
                                  textAlign: TextAlign.center,
                                  style: AppStyles.buttonText,
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(
                            AppColors.primaryColor,
                          ),
                          elevation: MaterialStateProperty.all(0.0),
                          side: MaterialStateProperty.all(
                            const BorderSide(
                              color: AppColors.primaryColor,
                              width: 0.5,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: AppStyles.buttonPadding,
                              child: Text(
                                "J'ai déja un un compte",
                                textAlign: TextAlign.center,
                                style: AppStyles.buttonText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
