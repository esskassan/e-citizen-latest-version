import 'dart:io';

import 'package:e_citizen/consts/app_assets.dart';
import 'package:e_citizen/consts/app_colors.dart';
import 'package:e_citizen/dao/directory_os_dao.dart';
import 'package:e_citizen/models/directory_model.dart';
import 'package:e_citizen/states/database_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'auth/welcome.dart';
import 'home.dart';
import 'widgets/FAB.dart';
import 'view_document.dart';
import 'package:quick_actions/quick_actions.dart';

class DocsList extends StatefulWidget {
  static String route = "DocsList";

  @override
  _DocsListState createState() => _DocsListState();
}

class _DocsListState extends State<DocsList> with TickerProviderStateMixin {
  QuickActions quickActions = QuickActions();

  Future homeRefresh() async {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    // Quick Action related
    quickActions.initialize((String shortcutType) {
      switch (shortcutType) {
        case 'Normal Scan':
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewDocument(
                quickScan: false,
                directoryOS: DirectoryOS(),
              ),
            ),
          ).whenComplete(() {
            homeRefresh();
          });
          break;
        case 'Quick Scan':
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewDocument(
                quickScan: true,
                directoryOS: DirectoryOS(),
              ),
            ),
          ).whenComplete(() {
            homeRefresh();
          });
          break;
        case 'Import from Gallery':
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewDocument(
                quickScan: false,
                directoryOS: DirectoryOS(),
                fromGallery: true,
              ),
            ),
          ).whenComplete(() {
            homeRefresh();
          });
          break;
      }
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      ShortcutItem(
        type: 'Normal Scan',
        localizedTitle: 'Normal Scan',
        icon: 'normal_scan',
      ),
      ShortcutItem(
        type: 'Quick Scan',
        localizedTitle: 'Quick Scan',
        icon: 'quick_scan',
      ),
      ShortcutItem(
        type: 'Import from Gallery',
        localizedTitle: 'Import from Gallery',
        icon: 'gallery_action',
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
          return true;},
        child: SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFe8e7e3),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          title: RichText(
            text: TextSpan(
              text: 'E-',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600,color: AppColors.secondaryColor),
              children: [
                TextSpan(text: 'Citizen', style: TextStyle(color: AppColors.secondaryColor))
              ],
            ),
          ),
        ),
        drawer: Container(
          width: size.width * 0.55,
          color: Color(0xFFe8e7e3),
          child: Column(
            children: <Widget>[
              Spacer(),
              SvgPicture.asset(
                AppAssets.fingerPrint,
                height: 90,
              ),
              Spacer(),
              Divider(
                thickness: 0.2,
                indent: 6,
                endIndent: 6,
                color: Colors.black26,
              ),
              ListTile(
                title: Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
              ),
              Divider(
                thickness: 0.2,
                indent: 6,
                endIndent: 6,
                color: Colors.black26,
              ),
              ListTile(
                title: Text(
                    'User guide',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WelcomePage(),
                    ),
                  );
                },
              ),
              Divider(
                thickness: 0.2,
                indent: 6,
                endIndent: 6,
                color: Colors.black26,
              ),
              Spacer(
                flex: 9,
              ),
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
                color: AppColors.secondaryColor,
              ),
              Spacer(),
            ],
          ),
        ),
        body: RefreshIndicator(
          backgroundColor: AppColors.primaryColor,
          color: AppColors.secondaryColor,
          onRefresh: homeRefresh,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  'Glisser vers le bas pour actualiser',
                  style: TextStyle(color: Colors.grey[700], fontSize: 11),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future:  DatabaseState.getMasterData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return Theme(
                      data:
                      Theme.of(context).copyWith(accentColor: AppColors.primaryColor),
                      child: ListView.builder(
                        itemCount: DatabaseState.getData().length,
                        itemBuilder: (context, index) {
                          return FocusedMenuHolder(
                            onPressed:() =>null,
                            menuWidth: size.width * 0.44,
                            child: ListTile(
                              leading: Image.file(
                                File(DatabaseState.getData()[index]['first_img_path']),
                                width: 50,
                                height: 50,
                              ),
                              title: Text(
                                DatabaseState.getData()[index]['new_name'] ?? DatabaseState.getData()[index]['dir_name'],
                                style: TextStyle(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Last Modified: ${DateTime.parse(DatabaseState.getData()[index]['last_modified']).day}-${DateTime.parse(DatabaseState.getData()[index]['last_modified']).month}-${DateTime.parse(DatabaseState.getData()[index]['last_modified']).year}',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                  Text(
                                    '${DatabaseState.getData()[index]['image_count']} ${(DatabaseState.getData()[index]['image_count'] == 1) ? 'image' : 'images'}',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ],
                              ),
                              trailing: Icon(
                                Icons.arrow_right,
                                size: 30,
                                color: AppColors.secondaryColor,
                              ),
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewDocument(
                                      directoryOS: DirectoryOS.fromMap(DatabaseState.getData()[index]),
                                    ),
                                  ),
                                ).whenComplete(() {
                                  homeRefresh();
                                });
                              },
                            ),
                            menuItems: [
                              FocusedMenuItem(
                                title: Text(
                                  'Rename',
                                  style: TextStyle(color: Colors.black),
                                ),
                                trailingIcon: Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  bool isEmptyError = false;
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      String? fileName;
                                      return StatefulBuilder(
                                        builder: (BuildContext context,
                                            void Function(void Function())
                                            setState) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            title: Text('Rename File'),
                                            content: TextField(
                                              controller: TextEditingController(
                                                text: fileName ??
                                                    DatabaseState.getData()[index]['new_name'],
                                              ),
                                              onChanged: (value) {
                                                fileName = value;
                                              },
                                              cursorColor: AppColors.secondaryColor,
                                              textCapitalization:
                                              TextCapitalization.words,
                                              decoration: InputDecoration(
                                                prefixStyle: TextStyle(
                                                    color: Colors.white),
                                                focusedBorder:
                                                UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColors.secondaryColor),
                                                ),
                                                errorText: isEmptyError
                                                    ? 'Error! File name cannot be empty'
                                                    : null,
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  fileName = fileName!.trim();
                                                  fileName = fileName!
                                                      .replaceAll('/', '');
                                                  if (fileName!.isNotEmpty) {
                                                    DirectoryOS dir=DirectoryOS.fromMap(DatabaseState.getData()[index]);
                                                    dir.newName=fileName!;
                                                    DirectoryOSdao.renameDirectory(
                                                        directory: dir);
                                                    Navigator.pop(context);
                                                    homeRefresh();
                                                  } else {
                                                    setState(() {
                                                      isEmptyError = true;
                                                    });
                                                  }
                                                },
                                                child: Text(
                                                  'Save',
                                                  style: TextStyle(
                                                      color: AppColors.secondaryColor),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ).whenComplete(() {
                                    setState(() {});
                                  });
                                },
                              ),
                              FocusedMenuItem(
                                title: Text('Delete'),
                                trailingIcon: Icon(Icons.delete),
                                backgroundColor: Colors.redAccent,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        title: Text('Delete'),
                                        content: Text(
                                            'Do you really want to delete file?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Directory(DatabaseState.getData()[index]['dir_path'])
                                                  .deleteSync(recursive: true);
                                              DirectoryOSdao.deleteDirectory(
                                                  dirPath:
                                                  DatabaseState.getData()[index]['dir_path']);
                                              Navigator.pop(context);
                                              homeRefresh();
                                            },
                                            child: Text(
                                              'Delete',
                                              style: TextStyle(
                                                  color: Colors.redAccent),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ).whenComplete(() {
                                    setState(() {});
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FAB(
          normalScanOnPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewDocument(
                  quickScan: false,
                  directoryOS: DirectoryOS(),
                ),
              ),
            ).whenComplete(() {
              homeRefresh();
            });
          },
          quickScanOnPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewDocument(
                  quickScan: true,
                  directoryOS: DirectoryOS(),
                ),
              ),
            ).whenComplete(() {
              homeRefresh();
            });
          },
          galleryOnPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewDocument(
                  quickScan: false,
                  directoryOS: DirectoryOS(),
                  fromGallery: true,
                ),
              ),
            ).whenComplete(() {
              homeRefresh();
            });
          },
        ),
      ),
    ),
    );
  }
}

