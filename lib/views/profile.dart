import 'package:e_citizen/consts/app_assets.dart';
import 'package:e_citizen/consts/app_styles.dart';
import 'package:e_citizen/states/user_state.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/footer.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppStyles.pagePadding,
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
                  Image.asset(
                    AppAssets.profileDefault,
                    height: 50,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Mon profil",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(const Color(0xFF32a852))),
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Mettre à jour'),
                  ),
                ],
              ),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Text(
                      "Muméro Carte :",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "${Provider.of<UserState>(context, listen: false).actualUser.cardId}",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Text(
                      "Nom :",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "${Provider.of<UserState>(context, listen: false).actualUser.lastname}",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Text(
                      "Prénoms :",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "${Provider.of<UserState>(context, listen: false).actualUser.firstname}",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Text(
                      "Téléphone :",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "${Provider.of<UserState>(context, listen: false).actualUser.telephone}",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Footer(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
