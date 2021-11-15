import 'package:e_citizen/consts/app_assets.dart';
import 'package:e_citizen/consts/app_colors.dart';
import 'package:e_citizen/consts/app_styles.dart';

import 'package:e_citizen/views/widgets/footer.dart';
import 'package:flutter/material.dart';

import 'profile.dart';
import 'auth/verify_phone.dart';

class AddTravelDoc extends StatefulWidget {
  const AddTravelDoc({Key? key}) : super(key: key);

  @override
  _AddTravelDocState createState() => _AddTravelDocState();
}

class _AddTravelDocState extends State<AddTravelDoc> {
  String dropdownValue = 'TYPE DOCUMENT:';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            padding: AppStyles.pagePadding,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Profile(),
                              ),
                            );
                          },
                          child: Image.asset(
                            AppAssets.profileDefault,
                            height: 50,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),
                    const Text(
                      "Ajouter un document",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                      iconSize: 30,
                      elevation: 1,
                      style: const TextStyle(fontWeight: FontWeight.w600,color: Colors.black, fontSize: 13),
                      underline: Container(
                        height: 2,
                        color: AppColors.primaryColor,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['TYPE DOCUMENT:', 'PASSEPORT', 'VISA', 'ASSURANCE VOYAGE']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 35),
                    const Text(
                      "NUMÉRO DE LA PIECE",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
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
                        hintText: '2021111206000000',
                        hintStyle: TextStyle(
                          color: AppColors.hintColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "DATE D'EMISSION",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      style: const TextStyle(letterSpacing: 1.0),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
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
                        hintText: '01 01 1900',
                        hintStyle: const TextStyle(
                          color: AppColors.hintColor,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
              const Text(
                "DATE D'EXPIRATION",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                style: const TextStyle(letterSpacing: 1.0),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
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
                  hintText: '01 01 1905',
                  hintStyle: const TextStyle(
                    color: AppColors.hintColor,
                  ),
                ),
              ),
                    const Text(
                      "VOTRE NUMÉRO DE TÉLÉPHONE",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      style: const TextStyle(letterSpacing: 1.0),
                      keyboardType: TextInputType.phone,
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
                        hintStyle: const TextStyle(
                          color: AppColors.hintColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),
                    const Text(
                      "Un code vous sera envoyé par SMS pour valider les informations ci-dessus",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.primaryColor),
                      ),
                      onPressed: () {
                        //TODO: IMPLEMENT THIS PART
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VerifyPhone(
                              addHealthPass: true,
                              token: '',
                              otp: '',
                            ),
                          ),
                        );
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
                    const Spacer(),
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
