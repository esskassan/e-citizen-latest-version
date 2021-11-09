import 'package:e_citizen/consts/app_assets.dart';
import 'package:e_citizen/consts/app_colors.dart';
import 'package:e_citizen/consts/app_styles.dart';
import 'package:e_citizen/helpers/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'profile.dart';

const InputBorder roundedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(20.0)),
  borderSide: BorderSide(color: AppColors.fillTextFieldColor, width: 5),
);

const List<Map<String, String>> contacts = [
  {
    'name': "Info Coronavirus",
    'number': "111",
    'description': "Numéro vert pour toute information relative au Coronavirus",
  },
  {
    'name': "Gendarmerie Nationale",
    'number': "117",
    'description': "",
  },
  {
    'name': "Sapeurs Pompiers",
    'number': "118",
    'description': "",
  },
  {
    'name': "Police secours",
    'number': "177",
    'description': "",
  },
  {
    'name': "Lutte contre la corruption",
    'number': "1014",
    'description':
        "Numéro pour dénoncer toute indélicatesse d'un agent des forces de l'ordre.",
  },
  {
    'name': "Suivi des réformes pédagogiques et académiques",
    'number': "8250",
    'description':
        "Numéro vert pour une remontée rapide d’informations sur les éventuels dysfonctionnements et manquements.",
  },
  {
    'name': "CHU Sylvanus Olympio",
    'number': "22 21 25 01",
    'description': "",
  },
  {
    'name': "CHU Campus",
    'number': "22 25 77 68 / 22 25 47 39",
    'description': "",
  },
  {
    'name': "Commissariat Central Lomé",
    'number': "22 21 28 71",
    'description': "",
  },
];

class QuickContacts extends StatefulWidget {
  const QuickContacts({Key? key}) : super(key: key);

  @override
  _QuickContactsState createState() => _QuickContactsState();
}

class _QuickContactsState extends State<QuickContacts> {
  final _formKey = GlobalKey<FormState>();
  ValueNotifier<String?> searchText = ValueNotifier('');
  ValueNotifier<bool> showSuffix = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: Utils.fullHeight(context),
          width: Utils.fullWidth(context),
          child: Padding(
            padding: AppStyles.pagePadding.copyWith(bottom: 0),
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
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 15),
                  child: Text(
                    "Numéros d'urgences",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: showSuffix,
                    builder: (context, valueL, _) {
                      return TextFormField(
                        keyboardType: TextInputType.name,
                        validator: (value) => null,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            if (!valueL) {
                              showSuffix.value = true;
                            }
                          } else {
                            showSuffix.value = false;
                          }
                          searchText.value = value;
                        },
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(12, 0, 12, 0),
                          border: roundedBorder,
                          focusedBorder: roundedBorder,
                          enabledBorder: roundedBorder,
                          prefixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                CupertinoIcons.search,
                                color: AppColors.grey,
                              ),
                            ],
                          ),
                          suffixIcon: (valueL
                              ? IconButton(
                                  onPressed: () {
                                    _formKey.currentState!.reset();
                                    showSuffix.value = false;
                                    searchText.value = '';
                                  },
                                  icon: const Icon(
                                    Icons.clear,
                                    color: AppColors.grey,
                                  ),
                                )
                              : null),
                          hintText: 'Rechercher un contact',
                          hintStyle: TextStyle(
                            color: AppColors.primaryColor.withOpacity(0.8),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: ValueListenableBuilder<String?>(
                        valueListenable: searchText,
                        builder: (context, searchValue, _) {
                          List<Map<String, String>> searchResult = contacts;
                          if (searchValue != null && searchValue.isNotEmpty) {
                            searchResult = List.from(
                              contacts.where((element) =>
                                  (element['name']!.toLowerCase())
                                      .contains(searchValue.toLowerCase())),
                            );
                          }
                          return Column(
                            children: [
                              for (var i = 0; i < searchResult.length; i++)
                                ListTile(
                                  title: Text(searchResult[i]['name']!),
                                  subtitle: Text(
                                    searchResult[i]['number']!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(CupertinoIcons.phone),
                                  ),
                                ),
                            ],
                          );
                        }),
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
