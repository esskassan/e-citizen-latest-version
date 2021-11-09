import 'package:e_citizen/consts/app_assets.dart';
import 'package:e_citizen/consts/app_colors.dart';
import 'package:e_citizen/consts/app_styles.dart';

import 'package:e_citizen/views/add_health_pass.dart';
import 'package:flutter/material.dart';

import 'profile.dart';
import 'widgets/footer.dart';

class DocsHolder extends StatefulWidget {
  const DocsHolder({Key? key}) : super(key: key);

  @override
  _DocsHolderState createState() => _DocsHolderState();
}

class _DocsHolderState extends State<DocsHolder> {
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
                "Mon porte documents",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              PopupMenuButton(
                elevation: 1,
                offset: const Offset(40, 30),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 10),
                    Text(
                      "Ajouter un document",
                      style: AppStyles.buttonText.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.add_circle,
                      color: AppColors.primaryColor,
                      size: 45,
                    ),
                  ],
                ),
                onSelected: (value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddHealthPass(),
                    ),
                  );
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    child: Text("Pass sanitaire"),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Text("Casier judiciare"),
                    value: 2,
                  ),
                  PopupMenuItem(
                    child: Text("Autres"),
                    value: 3,
                  )
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
