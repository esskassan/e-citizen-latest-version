import 'package:e_citizen/consts/app_assets.dart';
import 'package:e_citizen/consts/app_colors.dart';
import 'package:e_citizen/consts/app_styles.dart';
import 'package:e_citizen/consts/values.dart';
import 'package:e_citizen/helpers/screen_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'verify_phone.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String phoneNumber = '';
  /* Future<bool> getCode() async {
    return;
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: fullHeight(context),
          width: fullWidth(context),
          child: Padding(
            padding: pagePadding,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 35),
                          SvgPicture.asset(AppAssets.addUserData),
                          const SizedBox(height: 25),
                          const Text(
                            "Connectez-vous",
                            style: TextStyle(
                              fontSize: 17.889,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            "VOTRE NUMÉRO DE TÉLÉPHONE",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            style: const TextStyle(letterSpacing: 1.0),
                            keyboardType: TextInputType.phone,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "N'oubliez pas le numéro !";
                              } else if (value.length != 8) {
                                return "Veuillez entrer un numéro de 8 chiffres !";
                              } else if (num.tryParse(value) == null) {
                                return "$value n'est pas un numéro valide";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: Text(
                                      "+228",
                                      style: TextStyle(
                                        color: AppColors.hintColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 2,
                                horizontal: 12,
                              ),
                              border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0),
                              ),
                              filled: true,
                              fillColor: AppColors.fillTextFieldColor,
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0),
                              ),
                              hintText: 'XX XX XX XX',
                              hintStyle: const TextStyle(
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
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VerifyPhone(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: buttonPadding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Obtenir le code",
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
      ),
    );
  }
}
