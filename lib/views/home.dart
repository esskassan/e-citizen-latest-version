import 'package:e_citizen/consts/app_assets.dart';
import 'package:e_citizen/consts/app_styles.dart';
import 'package:e_citizen/helpers/utils.dart';
import 'package:e_citizen/states/user_state.dart';
import 'package:e_citizen/views/add_id_doc.dart';
import 'package:e_citizen/views/add_personnal_doc.dart';

import 'package:e_citizen/views/docs_holder.dart';
import 'package:e_citizen/views/profile.dart';
import 'package:e_citizen/views/quick_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'add_health_pass.dart';
import 'add_travel_doc.dart';
import 'docs_list.dart';
import 'widgets/footer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

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
                            const Color(0xFF9baeb6),

                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          height: 210,
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
                            const Color(0xFF266486),
                            //const Color(0xFF32a852),
                          ),
                        ),
                        child: Container(
                          height: 210,
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
                const SizedBox(height: 35),
                Column(
                  children: [
                      Column(
                        children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DocsList(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xFFe8e7e3),
                    ),
                  ),
                  child: Container(
                    child: ListTile(
                      title: Text(
                        "0",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        "Documents d'identification",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black87.withOpacity(0.8),
                        ),
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
                        builder: (context) => DocsList(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xFFe8e7e3),
                      //const Color(0xFF32a852),
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      "0",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.blue.shade800,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      "Documents de voyage",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black87.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
                          const SizedBox(height: 35),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 1,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DocsList(),
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      const Color(0xFFe8e7e3),
                                    ),
                                  ),
                                  child: Container(
                                    child: ListTile(
                                      title: Text(
                                        "0",
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.blue.shade800,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "preuves de vaccination",
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black87.withOpacity(0.8),
                                        ),
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
                                        builder: (context) => DocsList(),
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      const Color(0xFFe8e7e3),
                                      //const Color(0xFF32a852),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: ListTile(
                                    title: Text(
                                      "0",
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.blue.shade800,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "Documents personnels",
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.black87.withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
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
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueAccent,
        items: <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.compare_arrows, size: 30),
        ],
        onTap: (index) {
          if(index==0) {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: new Icon(Icons.person_add),
                      title: new Text('Ajouter un document d\'identification'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddIdDoc(),
                          ),
                        );
                      },
                    ),
                    const Divider(
                      height: 20,
                      thickness: 5,
                      indent: 20,
                      endIndent: 20,
                    ),
                    ListTile(
                      leading: new Icon(Icons.wallet_travel),
                      title: new Text('Ajouter un document de voyage'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddTravelDoc(),
                          ),
                        );
                      },
                    ),
                    const Divider(
                      height: 20,
                      thickness: 5,
                      indent: 20,
                      endIndent: 20,
                    ),
                    ListTile(
                      leading: new Icon(Icons.health_and_safety),
                      title: new Text('Ajouter un passe sanitaire'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddHealthPass(),
                          ),
                        );
                      },
                    ),
                    const Divider(
                      height: 20,
                      thickness: 5,
                      indent: 20,
                      endIndent: 20,
                    ),
                    ListTile(
                      leading: new Icon(Icons.document_scanner),
                      title: new Text('Ajouter un document personnel'),
                      onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => const AddPersonnalDoc(),
                    ),
                    );
                    },
                    ),
                  ],
                );
              });
          }
            if(index==1)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DocsList(),
                ),
              );

          if(index==2) {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: new Icon(FontAwesomeIcons.facebookSquare),
                        title: new Text('Facebook'),
                        onTap: () {
                          share(SocialMedia.facebook);
                        },
                      ),
                      const Divider(
                        height: 20,
                        thickness: 5,
                        indent: 20,
                        endIndent: 20,
                      ),
                      ListTile(
                        leading: new Icon(FontAwesomeIcons.twitterSquare),
                        title: new Text('Twitter'),
                        onTap: () {
                          share(SocialMedia.twitter);
                        },
                      ),
                      const Divider(
                        height: 20,
                        thickness: 5,
                        indent: 20,
                        endIndent: 20,
                      ),
                      ListTile(
                        leading: new Icon(FontAwesomeIcons.linkedin),
                        title: new Text('LinkedIn'),
                        onTap: () {
                          share(SocialMedia.linkedln);
                        },
                      ),
                      const Divider(
                        height: 20,
                        thickness: 5,
                        indent: 20,
                        endIndent: 20,
                      ),
                    ],
                  );
                });
          }
        },
      ),
    );
  }
}

Future share(SocialMedia platform) async {

  final urls = {
    SocialMedia.facebook : ('https://www.facebook.com/NumeriqueTG/')
    ,SocialMedia.twitter : ('https://twitter.com/NumeriqueTG')
    ,SocialMedia.linkedln : ('https://www.linkedin.com/company/numeriquetg/mycompany/')
  };
  final url = urls[platform]!;
  await launch(url);
}


enum SocialMedia { facebook, twitter, linkedln}

Widget buildSocialButton({required IconData icon, Color? color, required Function() onClicked})
=> InkWell(
  child: Container(
    width : 60,
    height : 60,
    child:  Center(
        child: FaIcon(icon, color:color,size: 40)
    ),
  ),
  onTap: onClicked,
);
