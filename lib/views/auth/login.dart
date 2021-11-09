import 'package:e_citizen/consts/app_assets.dart';
import 'package:e_citizen/consts/app_colors.dart';
import 'package:e_citizen/consts/app_styles.dart';

import 'package:e_citizen/helpers/utils.dart';
import 'package:e_citizen/views/auth/verify_phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: Utils.fullHeight(context),
          width: Utils.fullWidth(context),
          child: Padding(
            padding: AppStyles.pagePadding,
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
                              if (value != null &&
                                  value.isNotEmpty &&
                                  value.length > 7) {
                                return null;
                              }
                              return 'Numéro invalide';
                            },
                            onSaved: (newValue) =>
                                setState(() => phoneNumber = newValue!),
                            decoration: InputDecoration(
                              prefixIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.0, right: 7.0, bottom: 1.2),
                                    child: Text(
                                      "+228",
                                      style: TextStyle(
                                        fontSize: 16.3,
                                        color: Colors.black87,
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        List getCodeResult = await Utils.getCodeFromLogin(
                          phoneNumber: phoneNumber,
                        );
                        if (getCodeResult[0] == true &&
                            getCodeResult.length == 3) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 1, milliseconds: 250),
                              content: Text(
                                "Un code vous a été envoyé.",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                          await Future.delayed(const Duration(seconds: 1));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerifyPhone(
                                token: getCodeResult[1]!,
                                otp: getCodeResult[2]!,
                                userMap: {
                                  'id': "",
                                  'lastname': "",
                                  'firstname': "",
                                  'telephone': phoneNumber,
                                  'idNum': "",
                                  'idType': "",
                                  'email': "",
                                  'date_naissance': "",
                                  'profession': "",
                                  'profile_photo_path': "",
                                  'token': getCodeResult[1]!
                                },
                              ),
                            ),
                          );
                        } else if (getCodeResult[0] == false) {
                          Utils.showErrorSnackbar(context);
                        } else {
                          Utils.showAppErrorSnackbar(context);
                        }
                      }
                    },
                    child: Padding(
                      padding: AppStyles.buttonPadding,
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
