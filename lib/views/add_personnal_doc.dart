import 'package:e_citizen/consts/app_assets.dart';
import 'package:e_citizen/consts/app_colors.dart';
import 'package:e_citizen/consts/app_styles.dart';
import 'package:e_citizen/views/profile.dart';

import 'package:e_citizen/views/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:e_citizen/consts/app_assets.dart';
import 'package:e_citizen/consts/app_colors.dart';
import 'package:e_citizen/consts/app_styles.dart';

import 'package:e_citizen/views/widgets/footer.dart';
import 'package:flutter/material.dart';

import 'package:qrscan/qrscan.dart' as scanner;
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;


class AddPersonnalDoc extends StatefulWidget {
  const AddPersonnalDoc({Key? key}) : super(key: key);

  @override
  _AddPersonnalDocState createState() => _AddPersonnalDocState();
}

class _AddPersonnalDocState extends State<AddPersonnalDoc> {
  Uint8List bytes = Uint8List(0);
  late  TextEditingController _inputController;

  @override
  initState() {
    super.initState();
    this._inputController = new TextEditingController();
  }
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
                    _qrCodeWidget(this.bytes, context),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          TextField(
                            controller: this._inputController,
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.go,
                            onSubmitted: (value) => _generateBarCode(value),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.text_fields),
                              helperText:
                              'Please input your code to generage qrcode image.',
                              hintText: 'Please Input Your Code',
                              hintStyle: TextStyle(fontSize: 15),
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 15),
                            ),
                          ),
                          SizedBox(height: 20),
                          this._buttonGroup(),
                          SizedBox(height: 70),
                        ],
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


  Widget _qrCodeWidget(Uint8List bytes, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Card(
        elevation: 6,
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Icon(Icons.verified_user, size: 18, color: Colors.green),
                  Text('  Generate Qrcode', style: TextStyle(fontSize: 15)),
                  Spacer(),
                  Icon(Icons.more_vert, size: 18, color: Colors.black54),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4), topRight: Radius.circular(4)),
              ),
            ),
            Padding(
              padding:
              EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 10),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 190,
                    child: bytes.isEmpty
                        ? Center(
                      child: Text('Empty code ... ',
                          style: TextStyle(color: Colors.black38)),
                    )
                        : Image.memory(bytes),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 7, left: 25, right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: GestureDetector(
                            child: Text(
                              'remove',
                              style:
                              TextStyle(fontSize: 15, color: Colors.blue),
                              textAlign: TextAlign.left,
                            ),
                            onTap: () =>
                                this.setState(() => this.bytes = Uint8List(0)),
                          ),
                        ),
                        Text('|',
                            style:
                            TextStyle(fontSize: 15, color: Colors.black26)),
                        Expanded(
                          flex: 5,
                          child: GestureDetector(
                            onTap: () async {
                              final success =
                              await ImageGallerySaver.saveImage(this.bytes);
                              SnackBar snackBar;
                              if (success['isSuccess']) {
                                snackBar = new SnackBar(
                                    content:
                                    new Text('Successful Preservation!'));
                                Scaffold.of(context).showSnackBar(snackBar);
                              } else {
                                snackBar = new SnackBar(
                                    content: new Text('Save failed!'));
                              }
                            },
                            child: Text(
                              'save',
                              style:
                              TextStyle(fontSize: 15, color: Colors.blue),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(height: 2, color: Colors.black26),
            Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.history, size: 16, color: Colors.black38),
                  Text('  Generate History',
                      style: TextStyle(fontSize: 14, color: Colors.black38)),
                  Spacer(),
                  Icon(Icons.chevron_right, size: 16, color: Colors.black38),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
            )
          ],
        ),
      ),
    );
  }

  Widget _buttonGroup() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 120,
            child: InkWell(
              onTap: () => _generateBarCode(this._inputController.text),
              child: Card(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Image.asset('assets/images/generate_qrcode.png'),
                    ),
                    Divider(height: 20),
                    Expanded(flex: 1, child: Text("Generate")),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 120,
            child: InkWell(
              onTap: _scan,
              child: Card(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Image.asset('assets/images/scanner.png'),
                    ),
                    Divider(height: 20),
                    Expanded(flex: 1, child: Text("Scan")),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 120,
            child: InkWell(
              onTap: _scanPhoto,
              child: Card(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Image.asset('assets/images/albums.png'),
                    ),
                    Divider(height: 20),
                    Expanded(flex: 1, child: Text("Scan Photo")),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future _scan() async {
    await Permission.camera.request();
    String? barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
      this._inputController.text = barcode;
    }
  }

  Future _scanPhoto() async {
    await Permission.storage.request();
    String barcode = await scanner.scanPhoto();
    this._inputController.text = barcode;
  }

  Future _scanPath(String path) async {
    await Permission.storage.request();
    String barcode = await scanner.scanPath(path);
    this._inputController.text = barcode;
  }

  Future _scanBytes() async {
    File file = (await ImagePicker().getImage(source: ImageSource.camera)) as File;
    if (file == null) return;
    Uint8List bytes = file.readAsBytesSync();
    String barcode = await scanner.scanBytes(bytes);
    this._inputController.text = barcode;
  }

  Future _generateBarCode(String inputCode) async {
    Uint8List result = await scanner.generateBarCode(inputCode);
    this.setState(() => this.bytes = result);
  }
}
