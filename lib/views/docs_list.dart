import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:e_citizen/consts/app_assets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'add_health_pass.dart';
import 'add_id_doc.dart';
import 'add_personnal_doc.dart';
import 'add_travel_doc.dart';
import 'home.dart';
import 'profile.dart';
import 'widgets/footer.dart';

class DocsList extends StatefulWidget {
  List<String> item = ["Carte nationale d'identité","Passeport","Laisser-passer","Visa",
    "Carte de séjour", "Passe covid-19", "Permis de conduire"];
  @override
  _DocsList createState() => _DocsList();
}

class Document extends StatelessWidget {
  const Document({ required this.title, required this.author, required this.nombre });

  final String title;
  final String author;
  final int nombre;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme
        .of(context)
        .textTheme;
    return new Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: new BoxDecoration(
        color: Colors.grey.shade200.withOpacity(0.3),
        borderRadius: new BorderRadius.circular(5.0),
      ),
      child: new IntrinsicHeight(
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(top: 4.0, bottom: 4.0, right: 10.0),
              child: new CircleAvatar(
                backgroundImage: AssetImage('assets/images/porte-docs.jpg'),
                radius: 20.0,
              ),
            ),
            new Expanded(
              child: InkWell(
              child: new Container(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(title, style: textTheme.subtitle1),
                    new Text(author, style: textTheme.caption),
                  ],
                ),
              ),
                onTap: () {
                print("tapped on container");
              },
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 5.0),
              child: new InkWell(
                child: new Icon(Icons.play_arrow, size: 40.0),
                onTap: () {
                  // TODO(implement)
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Afficher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: [
        new Document(title: 'Carte nationale d\'identité', author: 'Expire le 20/12/2022', nombre: 1),
        new Document(title: 'Passport', author: 'Expire le 20/12/2025', nombre: 1),
        new Document(title: 'Laisser-passer', author: 'Expire le 20/12/2022', nombre: 1),
        new Document(title: 'Visa', author: 'Expire le 20/12/2022', nombre: 0),
        new Document(title: 'Carte de séjour', author: 'Expire le 20/12/2022', nombre: 0,),
        new Document(title: 'Passe covid-19', author: 'Expire le 20/12/2022', nombre: 0,),
        new Document(title: 'Permis de conduire', author: 'Expire le 20/12/2022', nombre: 1,),
      ],
    );
  }
}

class CustomTabBar extends AnimatedWidget implements PreferredSizeWidget {
  CustomTabBar({ required this.pageController, required this.pageNames })
      : super(listenable: pageController);

  final PageController pageController;
  final List<String> pageNames;

  @override
  final Size preferredSize = new Size(0.0, 40.0);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme
        .of(context)
        .textTheme;
    return new Container(
      height: 40.0,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: new BoxDecoration(
        color: Colors.grey.shade800.withOpacity(0.5),
        borderRadius: new BorderRadius.circular(20.0),
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: new List.generate(pageNames.length, (int index) {
          return new InkWell(
              child: new Text(
                  pageNames[index],
                  style: textTheme.subtitle1!.copyWith(
                    color: Colors.black.withOpacity(
                      index == pageController.page ? 1.0 : 0.2,
                    ),
                  )
              ),
              onTap: () {
                pageController.animateToPage(
                  index,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 300),
                );
              }
          );
        })
            .toList(),
      ),
    );
  }
}

class _DocsList extends State<DocsList> {

  PageController _pageController = new PageController(initialPage: 2);

  @override
  build(BuildContext context) {
    final Map<String, Widget> pages = <String, Widget>{
      'Cocher': new Center(
        child: new Text('My Document not implemented'),
      ),
      'Partager': new Center(
        child: new Text('Shared not implemented'),
      ),
      'Afficher': new Afficher(),
    };
    TextTheme textTheme = Theme
        .of(context)
        .textTheme;
    return new Stack(
      children: [
        new Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    const Color.fromARGB(255, 255, 255, 255),
                    const Color.fromARGB(255, 255, 255, 255),
                  ],
                  stops: [0.0, 1.0],
                )
            ),
            child: new Align(
                alignment: FractionalOffset.bottomCenter,
                child: new Container(
                  padding: const EdgeInsets.all(10.0),
                )
            )
        ),
        new Scaffold(
          backgroundColor: const Color(0x00000000),
          appBar: new AppBar(
            backgroundColor: const Color(0x00000000),
            elevation: 0.0,
            leading: new Center(
              child: new ClipOval(
                child: Image.asset(
                  AppAssets.profileDefault,
                  height: 50,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            actions: [
              new IconButton(
                icon: new Icon(Icons.add,
                  color: Colors.blue.shade400,),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddPersonnalDoc(),
                    ),
                  );
                },
              ),
            ],
            title: const Text('Mes documents',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20.5557,
              ),),
            bottom: new CustomTabBar(
              pageController: _pageController,
              pageNames: pages.keys.toList(),
            ),
          ),
          body: new PageView(
            controller: _pageController,
            children: pages.values.toList(),
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
        ),
      ],
    );
  }
}