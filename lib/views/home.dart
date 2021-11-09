import 'package:e_citizen/consts/app_assets.dart';
import 'package:e_citizen/consts/app_colors.dart';
import 'package:e_citizen/consts/app_styles.dart';
import 'package:e_citizen/helpers/utils.dart';
import 'package:e_citizen/states/user_state.dart';

import 'package:e_citizen/views/docs_holder.dart';
import 'package:e_citizen/views/profile.dart';
import 'package:e_citizen/views/quick_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'widgets/footer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: Utils.fullHeight(context),
          width: Utils.fullWidth(context),
          padding: AppStyles.pagePadding.copyWith(bottom: 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          AppAssets.fingerPrint,
                          height: 90,
                        ),
                        Text(
                          "Bienvenu ${Provider.of<UserState>(context, listen: false).actualUser.lastname}",
                          style: const TextStyle(
                            fontSize: 23.33359,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DocsHolder(),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            AppColors.primaryColor,
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          height: 100,
                          child: const Text(
                            "Mon porte documents",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.5557,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QuickContacts(),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xFF32a852),
                          ),
                        ),
                        child: Container(
                          height: 100,
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: const Text(
                            "Mes contacts d'urgences",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.5557,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          /* Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DocsHolder(),
                            ),
                          ); */
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xFF32a852),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          height: 100,
                          child: const Text(
                            "Annuaire de l'administration",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.5557,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          /* Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QuickContacts(),
                            ),
                          ); */
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            AppColors.primaryColor,
                          ),
                        ),
                        child: Container(
                          height: 100,
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: const Text(
                            "Contacter l'administration",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.5557,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      "Actualités",
                      style: TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Tout voir >",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    for (var i = 0; i < 3; i++)
                      Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Le Togo adhère à la convention des Nations-Unies sur l’eau",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              "Un peu plus d’un an après le feu vert de l’exécutif et du parlement, le Togo a officiellement adhéré à…",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black87.withOpacity(0.8),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(thickness: 2),
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 40),
                const Footer(),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
