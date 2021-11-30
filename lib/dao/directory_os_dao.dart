import 'package:e_citizen/consts/app_names.dart';
import 'package:e_citizen/models/directory_model.dart';
import 'package:e_citizen/states/database_state.dart';
import 'package:sqflite/sqflite.dart';

class DirectoryOSdao {
  static var _dirTableName;
  List<DirectoryOS>? masterDirectories = [];

  static getDirectoryTableName(String? dirName) {
    if(dirName!=null) {
      dirName = dirName.replaceAll('-', '');
      dirName = dirName.replaceAll('.', '');
      dirName = dirName.replaceAll(' ', '');
      dirName = dirName.replaceAll(':', '');
      _dirTableName = '"' + dirName + '"';
      return _dirTableName;
    }
  }

  static Future createDirectory({required DirectoryOS directory}) async {
    Database? db = await DatabaseState.instance.db;
    int index = await db!.insert(AppNames.masterTableName, {
      'dir_name': directory.dirName,
      'dir_path': directory.dirPath,
      'created': directory.created.toString(),
      'image_count': directory.imageCount,
      'first_img_path': directory.firstImgPath,
      'last_modified': directory.lastModified.toString(),
      'new_name': directory.newName
    });

    db.execute('''
      CREATE TABLE ${getDirectoryTableName(directory.dirName)}(
      idx INTEGER,
      img_path TEXT)
      ''');
  }

  static Future deleteDirectory({String? dirPath}) async {
    Database? db = await DatabaseState.instance.db;
    await db!
        .delete(AppNames.masterTableName, where: 'dir_path == ?', whereArgs: [dirPath]);
    String dirName = dirPath!.substring(dirPath.lastIndexOf("/") + 1);
    getDirectoryTableName(dirName);
    await db.execute('DROP TABLE $_dirTableName');
  }


  static Future<int> renameDirectory({DirectoryOS? directory}) async {
    Database? db = await DatabaseState.instance.db;
    return await db!.update(AppNames.masterTableName, {'new_name': directory!.newName},
        where: 'dir_name == ?', whereArgs: [directory.dirName]);
  }


  static Future getDirectoryData(String? tableName) async {
    Database? db = await DatabaseState.instance.db;
    getDirectoryTableName(tableName);
    List<Map<String, dynamic>> data = await db!.query(_dirTableName);
    return data;
  }


  Future<List<DirectoryOS>?> getDirectories() async {
    masterDirectories = [];
    for (var directory in await DatabaseState.getMasterData()) {
      var flag = false;
      for (var dir in masterDirectories!) {
        if (dir.dirPath == directory['dir_path']) {
          flag = true;
        }
      }
      if (!flag) {
        masterDirectories!.add(
          DirectoryOS(
            dirName: directory['dir_name'],
            dirPath: directory['dir_path'],
            created: DateTime.parse(directory['created']),
            imageCount: directory['image_count'],
            firstImgPath: directory['first_img_path'],
            lastModified: DateTime.parse(directory['last_modified']),
            newName: directory['new_name'],
          ),
        );
      }
    }
    masterDirectories = masterDirectories!.reversed.toList();
    return masterDirectories;
  }
}