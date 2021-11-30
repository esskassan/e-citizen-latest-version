import 'package:e_citizen/views/docs_list.dart';
import 'package:e_citizen/views/view_document.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'consts/app_assets.dart';
import 'consts/app_colors.dart';
import 'consts/app_names.dart';
import 'helpers/utils.dart';
import 'models/user_model.dart';
import 'states/database_state.dart';
import 'states/user_state.dart';
import 'views/home.dart';
import 'views/auth/welcome.dart';
import 'package:path/path.dart' as p;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserState>(create: (_) => UserState()),
        ChangeNotifierProvider<DatabaseState>(create: (_) => DatabaseState()),
      ],
      child: const MyApp(),
    ),
  );

  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorWidget =
        const SpinKitPouringHourGlassRefined(color: AppColors.primaryColor)
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..backgroundColor = Colors.white
    ..indicatorColor = AppColors.primaryColor
    ..textColor = Colors.black87
    ..userInteractions = false
    ..maskColor = Colors.grey
    ..dismissOnTap = true;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

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
        builder: EasyLoading.init(),
        initialRoute: '/',
        routes: {
          '/': (context) => FutureBuilder<Database>(
                future: DatabaseState.initializeDB(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    EasyLoading.dismiss();
                    final db = snapshot.data;
                    if (db != null) {
                      db.query(AppNames.dbUserTable).then(
                        (List<Map<String, dynamic>> maps) {
                          print("DB MAPS : " + maps.toString());
                          Provider.of<DatabaseState>(context, listen: false).db = db;
                          if (maps.isNotEmpty) {
                            Provider.of<UserState>(context, listen: false)
                                .actualUser = Users.fromDB(maps[0]);

                            db.query(AppNames.masterTableName).then(
                                  (List<Map<String, dynamic>> maps2) {
                                if (maps2.isNotEmpty) {
                                  print("DB MAPS 2: " + maps2.toString());
                                } else {
                                  print("DB MAPS 2: vide");
                                }
                              },
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const WelcomePage(),
                              ),
                            );
                          }
                        },
                      );
                    } else {
                      return Scaffold(
                        body: SafeArea(
                          child: SizedBox(
                            height: Utils.fullHeight(context),
                            width: Utils.fullWidth(context),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.app_blocking_outlined,
                                    size: 90,
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    "L'application n'a pas démarré correctement.\n Veuillez la fermer(terminer) et réessayer.\n Si le problème persiste, veuillez contacter le service client.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }
                  return Scaffold(
                    body: SizedBox(
                      height: Utils.fullHeight(context),
                      width: Utils.fullWidth(context),
                    ),
                  );
                },
              ),
          WelcomePage.id: (context) => const WelcomePage(),
          DocsList.route: (context) => DocsList(),
          ViewDocument.route: (context) => ViewDocument(),
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
        height: Utils.fullHeight(context),
        width: Utils.fullWidth(context),
        child: Center(
          child: Image.asset(AppAssets.placeHolder),
        ),
      ),
    );
  }
}
