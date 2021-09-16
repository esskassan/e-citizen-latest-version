import 'package:e_citizen/consts/app_assets.dart';
import 'package:e_citizen/consts/app_colors.dart';
import 'package:e_citizen/consts/app_styles.dart';
import 'package:e_citizen/helpers/screen_dimensions.dart';
import 'package:e_citizen/views/verify_phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: fullHeight(context),
          width: fullWidth(context),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                SvgPicture.asset(
                  AppAssets.addUser,
                ),
                const SizedBox(height: 15),
                const Text(
                  "Votre inscription",
                  style: AppStyles.title,
                ),
                const SizedBox(height: 15),
                const Text(
                  "PRÉNOMS",
                  style: AppStyles.textFieldLabel,
                ),
                const SizedBox(height: 5),
                const TextField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0),
                    ),
                    filled: true,
                    fillColor: AppColors.fillTextFieldColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0),
                    ),
                    hintText: 'Samael',
                    hintStyle: TextStyle(color: AppColors.hintColor),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "NOM",
                  style: AppStyles.textFieldLabel,
                ),
                const SizedBox(height: 5),
                const TextField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0),
                    ),
                    filled: true,
                    fillColor: AppColors.fillTextFieldColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0),
                    ),
                    hintText: 'ABALO',
                    hintStyle: TextStyle(color: AppColors.hintColor),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "NOM DE LA MÈRE",
                  style: AppStyles.textFieldLabel,
                ),
                const SizedBox(height: 5),
                const TextField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0),
                    ),
                    filled: true,
                    fillColor: AppColors.fillTextFieldColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0),
                    ),
                    hintText: 'ADJO',
                    hintStyle: TextStyle(color: AppColors.hintColor),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "NUMÉRO DE TÉLÉPHONE",
                  style: AppStyles.textFieldLabel,
                ),
                const SizedBox(height: 5),
                TextField(
                  style: const TextStyle(letterSpacing: 1.0),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Text(
                            "+228",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.hintColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0),
                    ),
                    filled: true,
                    fillColor: AppColors.fillTextFieldColor,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0),
                    ),
                    hintText: 'XX XX XX XX',
                    hintStyle: const TextStyle(color: AppColors.hintColor),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "TYPE DE CARTE",
                  style: AppStyles.textFieldLabel,
                ),
                const SizedBox(height: 5),
                Container(
                  color: AppColors.fillTextFieldColor,
                  child: DropdownButton<String>(
                    elevation: 0,
                    focusColor: AppColors.fillTextFieldColor,
                    dropdownColor: AppColors.fillTextFieldColor,
                    isExpanded: true,
                    underline: const SizedBox(),
                    hint: const Text(
                      "Sélectionner un type de carte",
                      style: TextStyle(color: AppColors.hintColor),
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items:
                        /*
                      CE => Carte d'électeur
                      10:09 AM
                      CNI => Carte d'identité
                      10:09 AM
                      PP => Passeport
                      10:09 AM
                      CMI => Carte d'identité des forces de l'ordre
                      10:10 AM
                      XPP => Passeport Etranger
                      */
                        <String>[
                      "Carte d'électeur",
                      "Carte d'identité",
                      "Passeport",
                      "Carte d'identité des forces de l'ordre",
                      "Passeport Etranger",
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                ),
                const SizedBox(height: 30),
                CheckboxListTile(
                  value: false,
                  onChanged: (value) {},
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: const EdgeInsets.all(0),
                  dense: true,
                  isThreeLine: false,
                  title: const Text(
                    "En cochant cette case, j'accepte la politique de confidentialité",
                    style: AppStyles.information,
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
                        builder: (context) => const VerifyPhone(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Créer un compte",
                          textAlign: TextAlign.center,
                          style: AppStyles.buttonText,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
