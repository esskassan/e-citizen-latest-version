import 'package:e_citizen/models/directory_model.dart';
import 'package:e_citizen/models/user_model.dart';
import 'package:hive/hive.dart';


class DataModelAdapter extends TypeAdapter<DirectoryOS> {
  @override
  final typeId = 0;

  @override
  DirectoryOS read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DirectoryOS(
        id: fields[0] as int?,
    dirName:  fields[1] as String?,
    dirPath: fields[2] as String?,
    created: fields[3] as DateTime?,
    imageCount: fields[4] as int?,
    firstImgPath: fields[5] as String?,
    lastModified:  fields[6] as DateTime?,
    newName:  fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DirectoryOS obj) {
    writer
      ..writeByte(0)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dirName)
      ..writeByte(2)
      ..write(obj.dirPath)
      ..writeByte(3)
      ..write(obj.created)
      ..writeByte(4)
      ..write(obj.imageCount)
      ..writeByte(5)
      ..write(obj.firstImgPath)
      ..writeByte(6)
      ..write(obj.lastModified)
      ..writeByte(6)
      ..write(obj.newName);
  }
}