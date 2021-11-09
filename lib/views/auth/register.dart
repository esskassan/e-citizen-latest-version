import 'package:e_citizen/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:e_citizen/consts/app_assets.dart';
import 'package:e_citizen/consts/app_colors.dart';
import 'package:e_citizen/consts/app_styles.dart';

import 'package:e_citizen/views/auth/verify_phone.dart';

import 'package:flutter_svg/flutter_svg.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String? cardType;
  late String cardId, name, firstName, motherName, phoneNumber;
  bool policyAccepted = true;
  final Map<String, dynamic> idTypes = {
    "Carte d'électeur": 'CE',
    "Carte d'identité": 'CNI',
    "Passeport": 'PP',
    "Carte d'identité des forces de l'ordre": 'CMI',
    "Passeport Etranger": 'XPP',
  };

  String? namesValidator(String? value, {String hint = 'nom'}) {
    if (value != null && value.isNotEmpty) {
      if (value.length > 2) {
        if (!RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%/]').hasMatch(value)) {
          return null;
        }
        return "Veuillez entrer un nom valide";
      }
      return "Veuillez entrer un nom d'au moins 3 caractères";
    }
    return "N'oubliez pas le nom";
  }

  Widget textFieldLabel(String label) => Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 5),
        child: Text(
          label,
          style: AppStyles.textFieldLabel,
        ),
      );

  InputDecoration textFieldDecoration(String hintText, {bool phone = false}) {
    return InputDecoration(
      prefixIcon: phone
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 7.0, bottom: 1.2),
                  child: Text(
                    "+228",
                    style: TextStyle(
                      fontSize: 16.3,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            )
          : null,
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
      hintText: hintText,
      hintStyle: const TextStyle(
        color: AppColors.hintColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: Utils.fullHeight(context),
          width: Utils.fullWidth(context),
          child: SingleChildScrollView(
            padding: AppStyles.pagePadding,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    AppAssets.addUser,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.warning_amber_outlined,
                          color: Colors.brown,
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            "Les informations fournies doivent correspondre à celles de la piéce d'identité",
                            style: AppStyles.information
                                .copyWith(color: Colors.brown),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    "Votre inscription",
                    style: AppStyles.title,
                  ),
                  textFieldLabel("TYPE DE CARTE"),
                  Container(
                    color: AppColors.fillTextFieldColor,
                    child: DropdownButton<String>(
                      elevation: 2,
                      focusColor: Colors.white,
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      underline: const SizedBox(),
                      hint: const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Sélectionner un type de carte",
                          style: TextStyle(color: AppColors.hintColor),
                        ),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      value: cardType,
                      items: <String>[...idTypes.keys].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => cardType = value!),
                    ),
                  ),
                  textFieldLabel("ID DE LA CARTE"),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        if (!RegExp(r'[!@#<>?":`~;[\]\\|=+)(*&^%/]')
                            .hasMatch(value)) {
                          return null;
                        }
                        return "Veuillez entrer un identifiant valide";
                      }
                      return "N'oubliez pas l'identifiant";
                    },
                    onSaved: (newValue) => setState(() => cardId = newValue!),
                    decoration: textFieldDecoration("T2R4Z118305"),
                  ),
                  textFieldLabel("NOM"),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.deny(
                        "[]!@#<>?:_`~;|=+*\\/)(&^%]\"\$.,",
                      )
                    ],
                    validator: namesValidator,
                    onSaved: (newValue) =>
                        setState(() => name = newValue!.toUpperCase()),
                    decoration: textFieldDecoration("ABALO"),
                  ),
                  textFieldLabel("PRÉNOMS"),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.deny(
                        "[]!@#<>?:_`~;|=+*\\/)(&^%]\"\$.,",
                      )
                    ],
                    validator: (value) => namesValidator(value, hint: "prénom"),
                    onSaved: (newValue) =>
                        setState(() => firstName = newValue!.toUpperCase()),
                    decoration: textFieldDecoration('Samael'),
                  ),
                  textFieldLabel("NUMÉRO DE TÉLÉPHONE"),
                  TextFormField(
                    style: const TextStyle(letterSpacing: 1.0),
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      if ((value != null) &&
                          value.isNotEmpty &&
                          value.length > 7 &&
                          (int.tryParse(value) != null)) {
                        return null;
                      }
                      return 'Numéro invalide';
                    },
                    onSaved: (newValue) =>
                        setState(() => phoneNumber = '228' + newValue!),
                    decoration: textFieldDecoration('XX XX XX XX', phone: true),
                  ),
                  textFieldLabel("NOM DE LA MÈRE"),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.deny(
                        "[]!@#<>?:_`~;|=+*\\/)(&^%]\"\$.,",
                      )
                    ],
                    decoration: textFieldDecoration("ADJO"),
                    onSaved: (newValue) =>
                        setState(() => motherName = newValue!.toUpperCase()),
                    validator: namesValidator,
                  ),
                  const SizedBox(height: 30),
                  CheckboxListTile(
                    value: policyAccepted,
                    onChanged: (value) {
                      setState(() {
                        policyAccepted = !policyAccepted;
                      });
                    },
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
                    onPressed: () async {
                      if (policyAccepted) {
                        if (cardType != null) {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            List getCodeResult =
                                await Utils.getCodeFromRegister(
                              cardId: cardId,
                              cardType: idTypes[cardType],
                              name: name,
                              phoneNumber: phoneNumber,
                            );
                            if (getCodeResult[0] == true &&
                                getCodeResult.length == 3) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VerifyPhone(
                                    token: getCodeResult[1]!,
                                    otp: getCodeResult[2]!,
                                    userMap: {
                                      'id': "",
                                      'lastname': name,
                                      'firstname': firstName,
                                      'telephone': phoneNumber,
                                      'idNum': cardId,
                                      'idType': idTypes[cardType],
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
                              if (getCodeResult.length > 1) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.black87,
                                    duration: const Duration(seconds: 4),
                                    content: Text(
                                      getCodeResult[1] == "Invalide Card"
                                          ? "Il semble que l'identifiant de la carte soit incorrect. Vérifiez d'avoir entré exactement les informations de la carte et réessayez."
                                          : "Les informations fournies semblent incorrectes. Vérifiez d'avoir entré exactement les informations de la carte et réessayez.",
                                      style: TextStyle(
                                        color: Colors.yellow.shade800,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                Utils.showErrorSnackbar(context);
                              }
                            } else {
                              Utils.showAppErrorSnackbar(context);
                            }
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.redAccent,
                              duration: Duration(seconds: 4),
                              content: Text(
                                "Veuillez choisir un type de carte pour continuer.",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 4),
                            content: Text(
                              "Veuillez accepter notre politique de confidentialité pour continuer.",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: AppStyles.buttonPadding,
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
      ),
    );
  }
}
