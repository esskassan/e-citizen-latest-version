import 'package:e_citizen/consts/app_assets.dart';
import 'package:e_citizen/consts/app_colors.dart';
import 'package:e_citizen/consts/app_styles.dart';
import 'package:e_citizen/consts/values.dart';
import 'package:e_citizen/helpers/screen_dimensions.dart';
import 'package:e_citizen/views/home.dart';
import 'package:e_citizen/views/show_health_pass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerifyPhone extends StatefulWidget {
  final bool addHealthPass;
  const VerifyPhone({
    Key? key,
    this.addHealthPass = false,
  }) : super(key: key);

  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: fullHeight(context),
          width: fullWidth(context),
          child: Padding(
            padding: pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 35),
                        SvgPicture.asset(
                          AppAssets.phoneNumberVerification,
                          height: 90,
                        ),
                        const SizedBox(height: 25),
                        const Text(
                          "Confirmez votre numéro de téléphone",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "CODE DE CONFIRMATION",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const TextField(
                          style: TextStyle(letterSpacing: 1.0),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 12,
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0),
                            ),
                            filled: true,
                            fillColor: AppColors.fillTextFieldColor,
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0),
                            ),
                            hintText: '158755',
                            hintStyle: TextStyle(
                              color: AppColors.hintColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primaryColor),
                  ),
                  onPressed: () {
                    final Widget destination = widget.addHealthPass
                        ? const ShowHealthPass()
                        : const HomePage();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => destination,
                      ),
                    );
                  },
                  child: Padding(
                    padding: buttonPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Confirmer",
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
