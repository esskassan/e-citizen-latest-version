import 'dart:async';
import 'dart:io';

import 'package:e_citizen/dao/directory_os_dao.dart';
import 'package:e_citizen/dao/image_os_dao.dart';
import 'package:e_citizen/models/directory_model.dart';
import 'package:e_citizen/models/image_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../flutter_scanner_cropper.dart';
import '../states/database_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class FileOperations {
  final String appName = 'com.example.e_citizen';
  static bool pdfStatus=false;
  DatabaseState database = DatabaseState();

  Future<String> getAppPath() async {
    final Directory _appDocDir = await getApplicationDocumentsDirectory();
    final Directory _appDocDirFolder =
    Directory('${_appDocDir.path}/$appName/');

    if (await _appDocDirFolder.exists()) {
      return _appDocDirFolder.path;
    } else {
      final Directory _appDocDirNewFolder =
      await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }
  }

  /// Create new PDF
  Future<bool> createPdf(
      {selectedDirectory, fileName, List<File>? images}) async {
    try {
      final output = File("${selectedDirectory.path}/$fileName.pdf");

      int i = 0;

      final doc = pw.Document();

      for (i = 0; i < images!.length; i++) {
        final image = pw.MemoryImage(images[i].readAsBytesSync());
        doc.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Center(
                child: pw.Image(image),
              );
            },
            margin: pw.EdgeInsets.all(2.0),
          ),
        );
      }

      output.writeAsBytesSync(await doc.save());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // ADD IMAGES
  Future<File?> openCamera() async {
    File? image;
    var picture = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picture != null) {
      image = File(picture.path);
    }
    return image;
  }

  Future<dynamic> openGallery() async {
    List<XFile>? pic;
    try {
      pic = (await ImagePicker().pickMultiImage())!;
    } catch (e) {
      print(e);
    }

    List<File> imageFiles = [];

    if (pic != null) {
      for (XFile image in pic) {
        imageFiles.add(File(image.path));
      }
    }
    print(imageFiles);
    return imageFiles;
  }

  Future<void> saveImage({required File image, required int index, required String dirPath}) async {
    if (!await Directory(dirPath).exists()) {
      new Directory(dirPath).create();
      await DirectoryOSdao.createDirectory(
        directory: DirectoryOS(
          dirName: dirPath.substring(dirPath.lastIndexOf('/') + 1),
          dirPath: dirPath,
          imageCount: 0,
          created: DateTime.parse(dirPath
              .substring(dirPath.lastIndexOf('/') + 1)
              .substring(
              dirPath.substring(dirPath.lastIndexOf('/') + 1).indexOf(' ') +
                  1)),
          newName: dirPath.substring(dirPath.lastIndexOf('/') + 1),
          lastModified: DateTime.parse(dirPath
              .substring(dirPath.lastIndexOf('/') + 1)
              .substring(
              dirPath.substring(dirPath.lastIndexOf('/') + 1).indexOf(' ') +
                  1)),
          firstImgPath: dirPath,
        ),
      );
    }

    // Removed Index in image path
    File tempPic = File("$dirPath/${DateTime.now()}.jpg");
    image.copy(tempPic.path);
    ImageOSdao.createImage(
      image: ImageOS(
        imgPath: tempPic.path,
        idx: index,
      ),
      tableName: dirPath.substring(dirPath.lastIndexOf('/') + 1),
    );
    if (index == 1) {
      ImageOSdao.updateFirstImagePath(imagePath: tempPic.path, dirPath: dirPath);
    }
  }

  // SAVE TO DEVICE
  Future<Directory> pickDirectory(
      BuildContext context, selectedDirectory) async {
    Directory directory = selectedDirectory;
    try {
      if (Platform.isAndroid) {
        directory = Directory("/storage/emulated/0/Documents/");
      } else {
        directory = (await getExternalStorageDirectory())!;
      }
    } catch (e) {
      print(e);
      directory = (await getExternalStorageDirectory())!;
    }

    return directory;
  }

  Future<String?> saveToDevice(
      {required BuildContext context,
        required String fileName,
        required List<ImageOS> images,
        required int quality,}) async {
    Directory? selectedDirectory;
    Directory ecitizenDir = Directory("/storage/emulated/0/Documents/e-citizen");
    Directory ecitizenPdfDir =
    Directory("/storage/emulated/0/Documents/e-citizen/PDF");
    int desiredQuality = 100;

    try {
      if (!ecitizenDir.existsSync()) {
        ecitizenDir.createSync();
        ecitizenPdfDir.createSync();
      }
      selectedDirectory = ecitizenPdfDir;
    } catch (e) {
      print(e);
      selectedDirectory = await pickDirectory(context, selectedDirectory);
    }

    List<File> imageFiles = [];
    String path;

    if (quality == 1) {
      desiredQuality = 20;
    } else if (quality == 2) {
      desiredQuality = 60;
    } else if (quality == 3) {
      desiredQuality = 100;
    } else {
      desiredQuality = 50;
    }

    print(desiredQuality);

    Directory cacheDir = await getTemporaryDirectory();
    for (ImageOS image in images) {
      path = await FlutterScannerCropper.compressImage(
        src: image.imgPath,
        dest: cacheDir.path,
        desiredQuality: desiredQuality,
      );
      imageFiles.add(File(path));
    }

    fileName = fileName.replaceAll('-', '');
    fileName = fileName.replaceAll('.', '');
    fileName = fileName.replaceAll(':', '');

    pdfStatus = await createPdf(
      selectedDirectory: selectedDirectory,
      fileName: fileName,
      images: imageFiles,
    );
    return (pdfStatus) ? selectedDirectory.path : null;
  }

  Future<bool> saveToAppDirectory(
      {required BuildContext context, required String fileName, dynamic images}) async {
    Directory selectedDirectory = await getApplicationDocumentsDirectory();

    List<ImageOS> imageOSList = [];
    List<File> imageFiles = [];

    if (images.runtimeType == imageOSList.runtimeType) {
      for (ImageOS image in images) {
        imageFiles.add(File(image.imgPath));
      }
    }

    pdfStatus = await createPdf(
      selectedDirectory: selectedDirectory,
      fileName: fileName,
      images: imageFiles,
    );
    return pdfStatus;
  }

  /// Delete the temporary files created by the image_picker package
  Future<void> deleteTemporaryFiles() async {
    Directory? appDocDir = await getExternalStorageDirectory();
    Directory cacheDir = await getTemporaryDirectory();
    String appDocPath = "${appDocDir!.path}/Pictures/";
    Directory del = Directory(appDocPath);
    if (del.existsSync()) {
      del.deleteSync(recursive: true);
    }
    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
    new Directory(appDocPath).create();
  }
}
