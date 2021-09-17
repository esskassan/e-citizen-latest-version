import 'package:e_citizen/consts/app_assets.dart';
import 'package:e_citizen/consts/app_colors.dart';
import 'package:e_citizen/views/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'helpers/screen_dimensions.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  /* final database = openDatabase(
    // Set the path to the database.
    p.join(await getDatabasesPath(), AppNames.dbName),
    // When first created, store the user data.
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE dogs(id INTEGER PRIMARY KEY, last_name TEXT,first_name TEXT, phone_number INTEGER)',
      );
    },
    version: 1,
  ); */
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: MaterialApp(
        title: 'E-citizen',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Poppins",
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: Colors.white,
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => FutureBuilder(
                future: Future.delayed(const Duration(milliseconds: 300)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return const WelcomePage();
                  }
                  return const Placeholder();
                },
              ),
          WelcomePage.id: (context) => const WelcomePage(),
        },
      ),
    );
  }
}

class Placeholder extends StatelessWidget {
  const Placeholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: fullHeight(context),
        width: fullWidth(context),
        child: Center(
          child: Image.asset(AppAssets.placeHolder),
        ),
      ),
    );
  }
}
