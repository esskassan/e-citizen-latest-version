import 'package:e_citizen/consts/app_names.dart';
import 'package:e_citizen/models/image_model.dart';
import 'package:e_citizen/states/database_state.dart';
import 'package:sqflite/sqflite.dart';
import 'package:e_citizen/dao/directory_os_dao.dart';

class ImageOSdao {

  static Future createImage({ImageOS? image, String? tableName}) async {
    Database? db = await DatabaseState.instance.db;
    int index = await db!.insert(DirectoryOSdao.getDirectoryTableName(tableName!), {
      'idx': image!.idx,
      'img_path': image.imgPath,
      // 'shouldCompress': image.shouldCompress,
    });
    print('Image Index: $index');

    await db.update(
        AppNames.masterTableName,
        {
          'image_count': index,
          'last_modified': DateTime.now().toString(),
        },
        where: 'dir_name == ?',
        whereArgs: [tableName]);
  }


  static Future deleteImage({String? imgPath, String? tableName}) async {
    Database? db = await DatabaseState.instance.db;
    await db!
        .delete( DirectoryOSdao.getDirectoryTableName(tableName!), where: 'img_path == ?', whereArgs: [imgPath]);
  }
  static Future<int> updateFirstImagePath({String? imagePath, String? dirPath}) async {
    Database? db = await DatabaseState.instance.db;
    return await db!.update( AppNames.masterTableName, {'first_img_path': imagePath},
        where: 'dir_path == ?', whereArgs: [dirPath]);
  }


  static void updateImageCount({String? tableName}) async {
    Database? db = await DatabaseState.instance.db;
    var data = await DirectoryOSdao.getDirectoryData(tableName!);
    db!.update(
      AppNames.masterTableName,
      {'image_count': data.length},
      where: 'dir_name == ?',
      whereArgs: [tableName],
    );
  }

  /// <---- Directory Table Operations ---->


  static Future<int> updateImagePath({String? tableName, ImageOS? image}) async {
    Database? db = await DatabaseState.instance.db;
    return await db!.update(
        DirectoryOSdao.getDirectoryTableName(tableName!),
        {
          'img_path': image!.imgPath,
        },
        where: 'idx == ?',
        whereArgs: [image.idx]);
  }

  static Future<int> updateImageIndex({ImageOS? image, String? tableName}) async {
    Database? db = await DatabaseState.instance.db;
    return await db!.update(
        DirectoryOSdao.getDirectoryTableName(tableName!),
        {
          'idx': image!.idx,
        },
        where: 'img_path == ?',
        whereArgs: [image.imgPath]);
  }

  Future<int> updateShouldCompress({ImageOS? image, String? tableName}) async {
    Database? db = await DatabaseState.instance.db;
    DirectoryOSdao.getDirectoryData(tableName);
    return await db!.update(
        tableName!,
        {
          'shouldCompress': false,
        },
        where: 'img_path == ?',
        whereArgs: [image!.imgPath]);
  }
}