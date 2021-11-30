import 'package:e_citizen/consts/app_assets.dart';
import 'package:e_citizen/consts/app_colors.dart';
import 'package:e_citizen/consts/app_names.dart';
import 'package:e_citizen/consts/app_styles.dart';

import 'package:e_citizen/helpers/utils.dart';
import 'package:e_citizen/models/user_model.dart';
import 'package:e_citizen/states/database_state.dart';
import 'package:e_citizen/states/user_state.dart';
import 'package:e_citizen/views/home.dart';
import 'package:e_citizen/views/show_health_pass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class VerifyPhone extends StatefulWidget {
  final bool addHealthPass;
  final String token;
  final String otp;
  final Map? userMap;
  const VerifyPhone({
    Key? key,
    this.addHealthPass = false,
    required this.token,
    required this.otp,
    this.userMap,
  }) : super(key: key);

  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  final _formKey = GlobalKey<FormState>();
  String? otp;

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
                          TextFormField(
                            style: const TextStyle(letterSpacing: 1.0),
                            keyboardType: TextInputType.phone,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if ((value != null) && value.isNotEmpty) {
                                return null;
                              }
                              return 'Veuillez entrer le code reçu pour continuer';
                            },
                            onSaved: (newValue) =>
                                setState(() => otp = newValue!),
                            decoration: const InputDecoration(
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
                                fontSize: 16.3,
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
                        if (otp == widget.otp) {
                          if (widget.addHealthPass) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ShowHealthPass(),
                              ),
                            );
                          } else {
                            final dUser = Users.fromJson(
                              (Map<String, dynamic>.from(widget.userMap!)),
                            );
                            await Provider.of<DatabaseState>(context,
                                    listen: false)
                                .db!
                                .insert(
                                  AppNames.dbUserTable,
                                  dUser.toMap(),
                                  conflictAlgorithm: ConflictAlgorithm.replace,
                                );
                            Provider.of<UserState>(context, listen: false)
                                .actualUser = dUser;
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                              (route) => false,
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.black87,
                              duration: const Duration(seconds: 4),
                              content: Text(
                                "Le code entré est invalide. Vérifiez d'avoir entré exactement le code reçu par sms et réessayez.",
                                style: TextStyle(
                                  color: Colors.yellow.shade800,
                                ),
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: Padding(
                      padding: AppStyles.buttonPadding,
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
      ),
    );
  }
}
